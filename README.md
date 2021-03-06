# terraform-icon-gcp-network

![open-issues](https://img.shields.io/github/issues-raw/insight-icon/terraform-icon-gcp-network?style=for-the-badge)
![open-pr](https://img.shields.io/github/issues-pr-raw/insight-icon/terraform-icon-gcp-network?style=for-the-badge)
[![build-status](https://img.shields.io/circleci/build/github/insight-icon/terraform-icon-gcp-network?style=for-the-badge)](https://circleci.com/gh/insight-icon/terraform-icon-gcp-network)

## Features

This module sets up VPCs, DNS zones, and firewall rules for running icon infrastructure on GCP.

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
  source = "github.com/insight-icon/terraform-icon-gcp-network"
}
```
## Examples

- [defaults](https://github.com/insight-icon/terraform-icon-gcp-network/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| cloudflare | n/a |
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| all\_enabled | Bool to enable all the security groups | `bool` | `false` | no |
| azs | List of availability zones | `list(string)` | `[]` | no |
| bastion\_enabled | Boolean to enable a bastion host.  All ssh traffic restricted to bastion | `bool` | `false` | no |
| bastion\_sg\_name | Name for the bastion security group | `string` | `"bastion-sg"` | no |
| cidr | The cidr range for network | `string` | `"10.0.0.0/16"` | no |
| citizen\_enabled | Boolean to for application api for citizen group traffic | `bool` | `false` | no |
| citizen\_sg\_name | Name for the citizen security group | `string` | `"citizen-sg"` | no |
| cloudflare\_enable | Bool to enable dns subdomain from cloudflare | `bool` | `false` | no |
| consul\_enabled | Boolean to allow consul traffic | `bool` | `false` | no |
| consul\_sg\_name | Name for the consult security group | `string` | `"consul-sg"` | no |
| corporate\_ip | The corporate IP you want to restrict ssh traffic to | `string` | `""` | no |
| create\_internal\_domain | Boolean to create an internal split horizon DNS | `bool` | `false` | no |
| create\_public\_regional\_subdomain | Boolean to create regional subdomain - ie us-east-1.example.com | `bool` | `false` | no |
| environment | The environment | `string` | `""` | no |
| hids\_enabled | Boolean to enable intrusion detection systems traffic | `bool` | `false` | no |
| hids\_sg\_name | Name for the HIDS security group | `string` | `"hids-sg"` | no |
| internal\_tld | The top level domain for the internal DNS | `string` | `"internal"` | no |
| k8s\_enabled | Boolean to enable k8s | `bool` | `false` | no |
| k8s\_sg\_name | Name for the HIDS security group | `string` | `"k8s-sg"` | no |
| logging\_enabled | Boolean to allow logging related traffic | `bool` | `false` | no |
| logging\_sg\_name | Name for the logging security group | `string` | `"logging-sg"` | no |
| monitoring\_enabled | Boolean to for prometheus related traffic | `bool` | `false` | no |
| monitoring\_sg\_name | Name for the monitoring security group | `string` | `"monitoring-sg"` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| num\_azs | The number of AZs to deploy into | `number` | `0` | no |
| owner | n/a | `string` | `""` | no |
| prep\_enabled | Boolean to allow P-Rep related traffic | `bool` | `false` | no |
| prep\_sg\_name | Name for the prep security group | `string` | `"prep-sg"` | no |
| project | The GCP project name | `string` | n/a | yes |
| region | The GCP region | `string` | n/a | yes |
| root\_domain\_name | The public domain | `string` | `""` | no |
| sentry\_enabled | Boolean to allow sentry related traffic | `bool` | `false` | no |
| sentry\_sg\_name | Name for the public node security group | `string` | `"sentry-sg"` | no |
| stage | The stage of the deployment | `string` | `""` | no |
| vault\_enabled | Boolean to allow vault related traffic | `bool` | `false` | no |
| vault\_sg\_name | Name for the vault security group | `string` | `"vault-sg"` | no |
| vpc\_name | The name of the VPC | `string` | `"icon"` | no |
| zone\_id | The zone ID to configure as the root zoon - ie subdomain.example.com's zone ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| azs | Availability zones |
| bastion\_security\_group\_id | UID of the service account for the bastion host |
| consul\_security\_group\_id | UID of the service account for the Consul servers |
| hids\_security\_group\_id | UID of the service account for the HIDS group |
| internal\_tld | The name of the internal domain |
| logging\_security\_group\_id | UID of the service account for the logging group |
| monitoring\_security\_group\_id | UID of the service account for the monitoring group |
| private\_subnets | The IDs of the private subnets |
| private\_subnets\_cidr\_blocks | CIDR ranges for the private subnets |
| private\_subnets\_names | The names of the public subnets |
| private\_vpc\_id | The ID of the private VPC |
| private\_vpc\_name | The name of the private VPC |
| public\_regional\_domain | The public regional domain |
| public\_subnet\_cidr\_blocks | CIDR ranges for the public subnets |
| public\_subnets | The IDs of the public subnets |
| public\_subnets\_names | The names of the public subnets |
| public\_vpc\_id | The ID of the public VPC |
| public\_vpc\_name | The name of the public VPC |
| root\_domain\_name | The name of the root domain |
| sentry\_security\_group\_id | UID of the service account for the sentry group |
| vault\_security\_group\_id | UID of the service account for the vault group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-icon](https://github.com/insight-icon)

## Credits

- [Richard Mah](https://github.com/shinyfoil)

## License

Apache 2 Licensed. See LICENSE for full details.