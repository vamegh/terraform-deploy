module "packer_vpc" {
    source = "git@github.com:vamegh/terraform-aws-vpc.git"
    name = "mgmt-${local.name}"
    cidr_block = var.cidr
    single_nat_gateway = true

    subnets = [
    {
      name              = "public"
      type              = "public"
      map_public_ip_on_launch = true
      availability_zone = {
        "${var.availability_zone}" = "${local.public_cidr_block}"
      }
      tags = merge(
      module.packer_tags.tags,
      {
        Name = "mgmt_${local.tag_name}_vpc_and_subnets"
      }
      )
    }
  ]
}


module "packer_public_sg" {
  source      = "git@github.com:vamegh/terraform-aws-security-groups.git"
  name        = "${local.name}-public-sg"
  description = "Security group for packer builds"
  vpc_id      = module.packer_vpc.vpc_id

  allow_rules = {
    ingress_rules = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "global_ssh_ingress_access"
        type        = "ingress_cidr_blocks"
        allow       = var.public_subnets.global
      }
    ],
    egress_rules  = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "global_egress_access"
        type        = "egress_cidr_blocks"
        allow       = var.public_subnets.global
      }
    ]
  }

  tags = merge(
  module.packer_tags.tags,
  {
    Name = "${local.tag_name}_global_ssh_access"
  }
  )
}

