# AWS EC2 Docker Swarm Cluster

This terraform module creates a Docker Swarm cluster using AWS EC2 instances. It optionnally creates a gluster cluster and/or enables an EFS.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ami | Ubuntu Server 18.04 LTS AMI | `string` | `"ami-0dad20bd1b9c8c004"` | no |
| aws\_profile | n/a | `any` | n/a | yes |
| aws\_region | n/a | `string` | `"ap-southeast-1"` | no |
| connection\_timeout | Timeout for connection to servers | `string` | `"2m"` | no |
| eip\_address | The Elastic IP address to be attached to first manager | `any` | n/a | yes |
| eip\_allocation\_id | The allocation ID of the Elastic IP address | `any` | n/a | yes |
| enable\_efs | n/a | `bool` | `false` | no |
| enable\_gluster | n/a | `bool` | `false` | no |
| env | n/a | `any` | n/a | yes |
| gluster\_volume\_size | n/a | `number` | `1` | no |
| key\_pair\_name | The name for the key pair | `any` | n/a | yes |
| key\_path | SSH public key path | `string` | `"~/.ssh/id_rsa.pub"` | no |
| manager\_instance\_type | Manager instance type | `string` | `"t2.micro"` | no |
| ssh\_public\_keys | SSH public keys to add to instances | `string` | n/a | yes |
| ssh\_user | n/a | `string` | `"ubuntu"` | no |
| subnet\_main\_cidr | n/a | `string` | `"192.168.0.0/24"` | no |
| swarm\_manager\_count | n/a | `number` | `1` | no |
| swarm\_manager\_name | n/a | `string` | `"manager"` | no |
| swarm\_name | n/a | `any` | n/a | yes |
| swarm\_worker\_count | n/a | `number` | `1` | no |
| swarm\_worker\_name | n/a | `string` | `"worker"` | no |
| vpc\_cidr | n/a | `string` | `"192.168.0.0/24"` | no |
| worker\_instance\_type | Worker instance type | `string` | `"t2.micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_dns\_name | DNS name of the provisioned AWS EFS |
| swarm\_manager\_ips | The manager nodes public ipv4 adresses |
| swarm\_manager\_ips\_private | The manager nodes private ipv4 adresses |
| swarm\_worker\_ips | The worker nodes public ipv4 adresses |
| swarm\_worker\_ips\_private | The worker nodes private ipv4 adresses |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
