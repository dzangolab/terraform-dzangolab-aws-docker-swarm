//-------------------------------------------------------------------
// General settings
//-------------------------------------------------------------------

variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region in which to provision resources"
  default     = "ap-southeast-1"
}

variable "env" {
  description = "The environment of the current deployment"
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
  description = "SSH public key path for key pair"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_public_keys" {
  description = "SSH public keys to add to instances"
  type        = string
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
  default     = "ami-07f4cb4629342979c"
}

variable "availability_zone" {
  description = "The availability zone in which to create EC2 instances"
  default     = "ap-southeast-1c"
}

variable "manager_instance_type" {
  description = "Manager instance type"
  default     = "t3a.large"
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
  description = "Size of the gluster volume"
  default     = 1
}
