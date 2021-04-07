provider "aws" {
  region = var.region
}

module "ev9-bootstrap" {
  source     = "git@github.com:vamegh/terraform-s3-backend.git"
  unique_id = var.name
}
