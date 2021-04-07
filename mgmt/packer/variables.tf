variable "accounts" {}

variable "region" {
}

variable "availability_zone" {
  type = string
}

variable "cidr" {
  type = string
}

variable "sub_env" {
  type = string
}

variable "name" {
  type = string
}

variable "service" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "business_owner" {
  type = string
}

variable "account_name" {
  type = string
}

variable "application" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "documentation" {
  type = string
}

variable "public_subnets" {
  type    = map(list(string))
}

