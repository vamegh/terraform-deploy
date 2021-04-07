terraform {
  required_version = ">= 0.12"

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "role_packer-build" {
  source        = "git@github.com:vamegh/terraform-aws-iam-role.git"
  name          = "packer-build"
  allow_service = "ec2.amazonaws.com"

  policy_file = [
    "policies/packer-build.json",
  ]

  policy_managed = [
    "SecretsManagerReadWrite",
    "AmazonEC2ReadOnlyAccess",
    "AmazonRoute53ReadOnlyAccess",
    "AmazonS3ReadOnlyAccess",
  ]
}

module "role_jenkins-agent" {
  source        = "git@github.com:vamegh/terraform-aws-iam-role.git"
  name          = "jenkins-agent"
  allow_service = "ec2.amazonaws.com"

  policy_file = [
    "policies/jenkins-agent.json",
  ]

  policy_managed = [
    "SecretsManagerReadWrite",
    "AdministratorAccess",
  ]
}
