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
| ami | Ubuntu Server 18.04 LTS AMI | `string` | `"ami-09a4a9ce71ff3f20b"` | no |
| availability\_zone | The availability zone in which to create EC2 instances | `string` | `"ap-southeast-1a"` | no |
| connection\_timeout | Timeout for connection to servers | `string` | `"2m"` | no |
| eip\_allocation\_id | The allocation ID of the Elastic IP address | `any` | n/a | yes |
| enable\_efs | Set to true in order to enable EFS | `bool` | `false` | no |
| enable\_gluster | Set to true in order to enable gluster | `bool` | `false` | no |
| env | The environment of the current deployment | `any` | n/a | yes |
| gluster\_volume\_size | Size of the gluster volume | `number` | `1` | no |
| key\_pair\_name | The name for the key pair | `any` | n/a | yes |
| key\_path | SSH public key path for key pair | `string` | `"~/.ssh/id_rsa.pub"` | no |
| manager\_instance\_type | Manager instance type | `string` | `"t3a.large"` | no |
| ssh\_public\_keys | SSH public keys to add to instances | `string` | `""` | no |
| ssh\_user | User for logging into nodes (ansible) | `string` | `"ubuntu"` | no |
| subnet\_main\_cidr | n/a | `string` | `"192.168.0.0/24"` | no |
| swarm\_manager\_count | Number of manager nodes | `number` | `1` | no |
| swarm\_manager\_name | Name to use for naming manager nodes | `string` | `"manager"` | no |
| swarm\_name | n/a | `any` | n/a | yes |
| swarm\_worker\_count | Number of worker nodes | `number` | `1` | no |
| swarm\_worker\_name | Name to use for naming worker nodes | `string` | `"worker"` | no |
| vpc\_cidr | n/a | `string` | `"192.168.0.0/24"` | no |
| worker\_instance\_type | Worker instance type | `string` | `"t3a.large"` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_dns\_name | DNS name of the provisioned AWS EFS |
| swarm\_manager\_ips | The manager nodes public ipv4 adresses |
| swarm\_manager\_ips\_private | The manager nodes private ipv4 adresses |
| swarm\_worker\_ips | The worker nodes public ipv4 adresses |
| swarm\_worker\_ips\_private | The worker nodes private ipv4 adresses |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
