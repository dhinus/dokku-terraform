# dokku-terraform AWS module

This module will create a new Dokku instance in an _existing_ AWS VPC.

For paranoid security, the instance is only reachable from the private network,
while the apps will be reachable on port 80 through an ELB load balancer.

To deploy new apps, you either SSH through the Bastion, or (better) you create a
Jenkins instance in the same subnet and let Jenkins push the apps to Dokku.

(More relaxed security settings would probably avoid some headaches, I am
considering updating this in the future.)

## Required Variables

* `name` - This will be used to tag resources on AWS
* `key_name` - Name of existing Key Pair on EC2. This key will get admin access
  to the Dokku instance.
* `private_key` - Path to local private key for `key_name`
* `hostname` - Your base hostname. Apps will be deployed to
  `app_name.${var.hostname}`.
* `zone_id` - ID of existing Route 53 Hosted Zone
* `vpc_id` - ID of existing AWS VPC
* `public_subnet_id` - ID of existing public subnet in the VPC
* `private_subnet_id` - ID of existing private subnet in the VPC
* `private_subnet_cidr` - CIDR of existing private subnet in the VPC (e.g.
  "10.0.0.0/8"). Machines in this subnet will be allowed to connect to the Dokku
  instance on port 22.
* `bastion_sec_group_id` - Security Group for Bastion instance in the VPC
* `bastion_host`, `bastion_port`, `bastion_user`, `bastion_private_key` - Used
  for [Provisioner Connection](https://www.terraform.io/docs/provisioners/connection.html)

## Optional Variables

* `instance_type` - Defaults to `t2.micro`
* `allowed_cidr_blocks` - Whitelist of public IPs allowed to access the Dokku
  apps on port 80. Defaults to "0.0.0.0/0" (all the interwebs)

## Usage example

```
module "dokku" {
  source = "github.com/dhinus/dokku-terraform//aws"

  name = "dokku-terraform"
  hostname = "my_base_hostname.example.com"
  key_name = "ec2_key_name"
  private_key = "~/.ssh/dokku.pem"
  zone_id = "route_53_zone_id"
  vpc_id = "vpc-12345678"
  public_subnet_id = "subnet-12345678"
  private_subnet_id = "subnet-12345678"
  private_subnet_cidr = "10.0.0.0/8"
  bastion_sec_group_id = "sg-12345678"
  bastion_host = "bastion.example.com"
  bastion_port = "2222"
  bastion_user = "bastion-username"
  bastion_private_key = "~/.ssh/id_rsa"
}
```
