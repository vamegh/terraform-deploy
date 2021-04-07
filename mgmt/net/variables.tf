variable "region" {
  type = string
}

variable "network_cidr" {
  type = string
}

variable "account_name" {}
variable "application" {}
variable "business_owner" {}
variable "environment" {}
variable "sub_environment" {}
variable "name" {}
variable "service" {}
variable "project" {}

variable "accounts" {
  type = map(string)
}

variable "public_subnets" {
  type = map(string)
}
