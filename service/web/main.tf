terraform {
  required_version = ">= 0.12"

  backend "s3" {
  }
}

provider "aws" {
  region = var.region
}

module "web_tags" {
  source         = "git@github.com:vamegh/terraform-aws-tags.git"
  account_name   = var.account_name
  application    = var.application
  business_owner = var.business_owner
  cost_center    = var.cost_center
  documentation  = var.documentation
  environment    = var.environment
  project        = var.project
  service        = var.service
  name           = var.name
  sub_env        = var.sub_environment
}

module "web_asg_tags" {
  source          = "git@github.com:vamegh/terraform-aws-tags.git"
  name            = "${local.name_tag}_asg"
  set_key_as_list = true
  extra_tags      = module.web_tags.tags

  additional_tag_maps = {
    propagate_at_launch = "true"
  }
}

module "bastion_asg_tags" {
  source          = "git@github.com:vamegh/terraform-aws-tags.git"
  name            = "${local.name_tag}_bastion_asg"
  set_key_as_list = true
  extra_tags      = module.web_tags.tags

  additional_tag_maps = {
    propagate_at_launch = "true"
  }
}
