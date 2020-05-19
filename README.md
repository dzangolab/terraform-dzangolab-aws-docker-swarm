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
| connect\_via\_private\_address | Whether connection to the servers should be made via the private ip address (true) or the public ip address (false) | `bool` | `false` | no |
| connection\_timeout | Timeout for connection to servers | `string` | `"2m"` | no |
| eip\_allocation\_id | The allocation ID of the Elastic IP address | `any` | n/a | yes |
| enable\_efs | Set to true in order to enable EFS | `bool` | `false` | no |
| enable\_gluster | Set to true in order to enable gluster | `bool` | `false` | no |
| env | The environment of the current deployment | `any` | n/a | yes |
| gluster\_volume\_size | Size of the gluster volume in gibibytes (GiB) | `number` | `1` | no |
| key\_pair\_name | The name for the key pair | `any` | n/a | yes |
| manager\_instance\_type | Manager instance type | `string` | `"t3a.large"` | no |
| manager\_volume\_delete\_on\_termination | Whether root volume should be destroyed on manager instance termination | `bool` | `true` | no |
| manager\_volume\_size | The size of root volume of manager instance in gibibytes (GiB). | `number` | `8` | no |
| manager\_volume\_type | The type of root volume of manager intances | `string` | `"gp2"` | no |
| private\_key\_path | SSH private key path for ssh connection. | `string` | `"~/.ssh/id_rsa"` | no |
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
| worker\_volume\_delete\_on\_termination | Whether root volume should be destroyed on worker instance termination | `bool` | `true` | no |
| worker\_volume\_size | The size of root volume of worker instance in gibibytes (GiB). | `number` | `8` | no |
| worker\_volume\_type | The type of root volume of worker intances | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_dns\_name | DNS name of the provisioned AWS EFS |
| swarm\_manager\_ips | The manager nodes public ipv4 adresses |
| swarm\_manager\_ips\_private | The manager nodes private ipv4 adresses |
| swarm\_worker\_ips | The worker nodes public ipv4 adresses |
| swarm\_worker\_ips\_private | The worker nodes private ipv4 adresses |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
