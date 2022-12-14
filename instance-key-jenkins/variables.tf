variable "vpc_id" {}
variable "subnet_cidr" {}
variable "az" {}
variable "name" {}
variable "ami" {}
variable "instance" {}
variable "inst-key" {
  type        = string
  default     = "inst-key"
  description = "Key-pair generated by Terraform"
}