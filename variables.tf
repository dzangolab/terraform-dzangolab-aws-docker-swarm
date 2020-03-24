//-------------------------------------------------------------------
// General settings
//-------------------------------------------------------------------

variable "aws_profile" {
}

variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env" {
}

variable "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP address"
}

variable "eip_address" {
  description = "The Elastic IP address to be attached to first manager"
}

//-------------------------------------------------------------------
// Connection settings
//-------------------------------------------------------------------

variable "connection_timeout" {
  description = "Timeout for connection to servers"
  default     = "2m"
}

variable "key_pair_name" {
  description = "The name for the key pair"
}

variable "key_path" {
  description = "SSH public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_public_keys" {
  type        = string
  description = "SSH public keys to add to instances"
}

variable "ssh_user" {
  default = "ubuntu"
}

//-------------------------------------------------------------------
// Swarm settings
//-------------------------------------------------------------------

variable "ami" {
  description = "Ubuntu Server 18.04 LTS AMI"
  default = "ami-0dad20bd1b9c8c004"
}

variable "manager_instance_type" {
  description = "Manager instance type"
  default = "t2.micro"
}

variable "subnet_main_cidr" {
  default = "192.168.0.0/24"
}

variable "swarm_manager_count" {
  default = 1
}

variable "swarm_manager_name" {
  default = "manager"
}

variable "swarm_name" {
}

variable "swarm_worker_count" {
  default = 1
}

variable "swarm_worker_name" {
  default = "worker"
}

variable "vpc_cidr" {
  default = "192.168.0.0/24"
}

variable "worker_instance_type" {
  description = "Worker instance type"
  default = "t2.micro"
}

//-------------------------------------------------------------------
// EFS settings
//-------------------------------------------------------------------

variable "enable_efs" {
  default = false
}

//-------------------------------------------------------------------
// Gluster settings
//-------------------------------------------------------------------

variable "enable_gluster" {
  default = false
}

variable "gluster_volume_size" {
  default = 1
}
