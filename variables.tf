//-------------------------------------------------------------------
// General settings
//-------------------------------------------------------------------

variable "env" {
  description = "The environment of the current deployment"
}

variable "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP address"
}

//-------------------------------------------------------------------
// Connection settings
//-------------------------------------------------------------------
variable "connect_via_private_address" {
  description = "Whether connection to the servers should be made via the private ip address (true) or the public ip address (false)"
  default     = false
}

variable "connection_timeout" {
  description = "Timeout for connection to servers"
  default     = "2m"
}

variable "key_pair_name" {
  description = "The name for the key pair"
}

variable "private_key_path" {
  description = "SSH private key path for ssh connection."
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_keys" {
  description = "SSH public keys to add to instances"
  type        = string
  default     = ""
}

variable "ssh_user" {
  description = "User for logging into nodes (ansible)"
  default     = "ubuntu"
}

//-------------------------------------------------------------------
// Swarm settings
//-------------------------------------------------------------------

variable "ami" {
  description = "Ubuntu Server 18.04 LTS AMI"
  default     = "ami-09a4a9ce71ff3f20b"
}

variable "availability_zone" {
  description = "The availability zone in which to create EC2 instances"
  default     = "ap-southeast-1a"
}

variable "manager_instance_type" {
  description = "Manager instance type"
  default     = "t3a.large"
}

variable "manager_volume_delete_on_termination" {
  description = "Whether root volume should be destroyed on manager instance termination"
  default     = true
}

variable "manager_volume_size" {
  description = "The size of root volume of manager instance in gibibytes (GiB)."
  default     = 8
}

variable "manager_volume_type" {
  description = "The type of root volume of manager intances"
  default     = "gp2"
}

variable "subnet_main_cidr" {
  default = "192.168.0.0/24"
}

variable "swarm_manager_count" {
  description = "Number of manager nodes"
  default     = 1
}

variable "swarm_manager_name" {
  description = "Name to use for naming manager nodes"
  default     = "manager"
}

variable "swarm_name" {
}

variable "swarm_worker_count" {
  description = "Number of worker nodes"
  default     = 1
}

variable "swarm_worker_name" {
  description = "Name to use for naming worker nodes"
  default     = "worker"
}

variable "vpc_cidr" {
  default = "192.168.0.0/24"
}

variable "worker_instance_type" {
  description = "Worker instance type"
  default     = "t3a.large"
}

variable "worker_volume_delete_on_termination" {
  description = "Whether root volume should be destroyed on worker instance termination"
  default     = true
}

variable "worker_volume_size" {
  description = "The size of root volume of worker instance in gibibytes (GiB)."
  default     = 8
}

variable "worker_volume_type" {
  description = "The type of root volume of worker intances"
  default     = "gp2"
}

//-------------------------------------------------------------------
// EFS settings
//-------------------------------------------------------------------

variable "enable_efs" {
  description = "Set to true in order to enable EFS"
  default     = false
}

//-------------------------------------------------------------------
// Gluster settings
//-------------------------------------------------------------------

variable "enable_gluster" {
  description = "Set to true in order to enable gluster"
  default     = false
}

variable "gluster_volume_size" {
  description = "Size of the gluster volume in gibibytes (GiB)"
  default     = 1
}
