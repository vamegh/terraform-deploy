variable "accounts" {
  type = map(string)
}

variable "availability_zone" {
  type = string
}

variable "region" {
  type = string
}


variable "account_name" {}
variable "application" {}
variable "business_owner" {}
variable "cost_center" {}
variable "documentation" {}
variable "environment" {}
variable "sub_environment" {}
variable "name" {}
variable "service" {}
variable "project" {}

variable "bucket_name" {
  type = string
}

variable "service_role" {
  type = string
}

variable "bucket_user" {
  type = string
}
