variable "name" {}
variable "key_name" {}
variable "private_key" {}

variable "hostname" {}
variable "zone_id" {}

variable "vpc_id" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "private_subnet_cidr" {}
variable "bastion_sec_group_id" {}

variable "bastion_host" {}
variable "bastion_port" {}
variable "bastion_user" {}
variable "bastion_private_key" {}

variable "instance_type" {
  default = "t2.micro"
}
variable "allowed_cidr_blocks" {
  default = "0.0.0.0/0"
}
