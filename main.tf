terraform {
  backend "s3" {
  }
}

locals {
  default_sg      = [aws_security_group.aws-common.id, aws_security_group.aws-swarm.id]
  gluster_sg      = var.enable_gluster ? [aws_security_group.aws-gluster[0].id] : []
  efs_sg          = var.enable_efs ? [aws_security_group.efs[0].id] : []
  security_groups = concat(local.default_sg, local.gluster_sg, local.efs_sg)
}

resource "aws_key_pair" "default" {
  key_name   = var.key_pair_name
  public_key = file(var.key_path)
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.swarm_name}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_main_cidr

  tags = {
    Name = "${var.swarm_name}-subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.swarm_name}-ig"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.swarm_name}-main"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.swarm_name}-public"
  }
}

resource "aws_main_route_table_association" "main_route" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "route" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = aws_instance.manager[0].availability_zone
  count             = var.enable_gluster ? var.swarm_manager_count : 0
  size              = 1
}

resource "aws_volume_attachment" "ebs_attachment" {
  count        = var.enable_gluster ? var.swarm_manager_count : 0
  device_name  = "/dev/xvdf"
  force_detach = true
  instance_id  = element(aws_instance.manager.*.id, count.index)
  volume_id    = element(aws_ebs_volume.ebs_volume.*.id, count.index)
}

resource "aws_efs_file_system" "main" {
  count          = var.enable_efs ? 1 : 0
  creation_token = var.swarm_name

  tags = {
    Name = var.swarm_name
  }
}

resource "aws_efs_mount_target" "main" {
  count           = var.enable_efs ? 1 : 0
  file_system_id  = aws_efs_file_system.main[0].id
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.efs[0].id]
}

resource "aws_instance" "manager" {
  ami                         = var.ami
  count                       = var.swarm_manager_count
  instance_type               = var.manager_instance_type
  key_name                    = aws_key_pair.default.id
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true
  vpc_security_group_ids      = local.security_groups

  tags = {
    Name = format(
      "%s-%s-%02d",
      var.swarm_name,
      var.swarm_manager_name,
      count.index + 1
    )
    "Node Type" = "${var.swarm_name}-swarm-manager"
  }

  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    user    = var.ssh_user
    timeout = var.connection_timeout
  }

  provisioner "remote-exec" {
    inline = [
      "echo '127.0.1.1 ${self.tags.Name}' | sudo tee -a /etc/hosts",
      "sudo hostnamectl set-hostname ${self.tags.Name}",
      "echo '\n${var.ssh_public_keys}\n' >> /home/ubuntu/.ssh/authorized_keys",
    ]
  }
}

resource "aws_instance" "worker" {
  ami                         = var.ami
  count                       = var.swarm_worker_count
  instance_type               = var.worker_instance_type
  key_name                    = aws_key_pair.default.id
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true
  vpc_security_group_ids      = local.security_groups

  tags = {
    Name = format(
      "%s-%s-%02d",
      var.swarm_name,
      var.swarm_worker_name,
      count.index + 1
    )
    "Node Type" = "${var.swarm_name}-swarm-worker"
  }

  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    user    = var.ssh_user
    timeout = var.connection_timeout
  }

  provisioner "remote-exec" {
    inline = [
      "echo '127.0.1.1 ${self.tags.Name}' | sudo tee -a /etc/hosts",
      "sudo hostnamectl set-hostname ${self.tags.Name}",
      "echo '\n${var.ssh_public_keys}\n' >> /home/ubuntu/.ssh/authorized_keys",
    ]
  }
}

data "template_file" "elastic_ip_script" {
  template = file("${path.module}/setup_elastic_ip.tpl")

  vars = {
    aws_profile        = var.aws_profile
    aws_region         = var.aws_region
    eip_allocation_id  = var.eip_allocation_id
    instance_id        = aws_instance.manager[0].id
    private_ip_address = aws_instance.manager[0].private_ip
  }
}

resource "null_resource" "elastic_ip_association" {
  triggers = {
    managers = join("\n", aws_instance.manager.*.public_ip)
    workers  = join("\n", aws_instance.worker.*.public_ip)
  }

  provisioner "local-exec" {
    command = data.template_file.elastic_ip_script.rendered
  }
}

locals {
  all_ips                     = aws_instance.manager.*.public_ip
  first_ip_to_remove          = [aws_instance.manager[0].public_ip]
  list_with_first_ip_in_front = distinct(concat(local.first_ip_to_remove, local.all_ips))
  list_without_first_ip = slice(
    local.list_with_first_ip_in_front,
    1,
    length(local.list_with_first_ip_in_front),
  )

  elastic_ip_list = [var.eip_address]

  manager_public_ip_list = concat(local.elastic_ip_list, local.list_without_first_ip)
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/ansible_inventory.tpl")

  vars = {
    env                 = var.env
    managers            = join("\n", local.manager_public_ip_list)
    workers             = join("\n", aws_instance.worker.*.public_ip)
    manager_private_ips = join("\n", aws_instance.manager.*.private_ip)
    efs_dns_name        = var.enable_efs ? aws_efs_mount_target.main[0].dns_name : ""
  }
  # managers = "${join("\n", "${var.eip_allocation_id == "null" ? aws_instance.manager.*.public_ip : local.manager_public_ip_list}")}"
  # Conditional operator on list  will be supported on Terraform 0.12. See issue https://github.com/hashicorp/terraform/issues/18259#issuecomment-434809754
}

resource "null_resource" "ansible_inventory_file" {
  triggers = {
    managers            = join("\n", aws_instance.manager.*.public_ip)
    workers             = join("\n", aws_instance.worker.*.public_ip)
    manager_private_ips = join("\n", aws_instance.manager.*.private_ip)
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.ansible_inventory.rendered}\" > \"${var.env}\".yml"
  }

  depends_on = [null_resource.elastic_ip_association]
}
