module "web_private_access" {
  source      = "git@github.com:vamegh/terraform-aws-security-groups.git"
  name        = "${local.tag_name}_private_access"
  description = "Web Internal Private Network Port Access"
  vpc_id      = data.aws_vpc.mgmt.id

  allow_rules = {
    ingress_rules = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "${local.tag_name}_ssh_private_ingress"
        type        = "ingress_cidr_blocks"
        allow       = local.all_cidr_blocks
      }
    ],
    egress_rules  = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "${local.tag_name}_global_egress"
        type        = "egress_cidr_blocks"
        allow       = [
          local.global_public_subnet]
      }
    ]
  }
  tags        = merge(
  module.web_tags.tags,
  {
    Name = "${local.tag_name}_private_access"
  }
  )
}

module "web_lb_access" {
  source      = "git@github.com:vamegh/terraform-aws-security-groups.git"
  name        = "${local.tag_name}_web_lb_access"
  description = "Web Load Balancer Access"
  vpc_id      = data.aws_vpc.mgmt.id

  allow_rules = {
    ingress_rules = [
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "${local.tag_name}_global_lb_https_ingress"
        type        = "ingress_cidr_blocks"
        allow       = concat(local.all_cidr_blocks, [local.global_public_subnet])
      },
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        description = "${local.tag_name}_lb_http_ingress"
        type        = "ingress_cidr_blocks"
        allow       = local.all_cidr_blocks
      }
    ],
    egress_rules  = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        description = "${local.tag_name}_global_lb_egress"
        type        = "egress_cidr_blocks"
        allow       = [
          local.global_public_subnet]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "${local.tag_name}_lb_https_egress"
        type        = "egress_cidr_blocks"
        allow       = local.all_cidr_blocks
      },
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        description = "${local.tag_name}_lb_http_egress"
        type        = "egress_cidr_blocks"
        allow       = local.all_cidr_blocks
      }
    ]
  }

  tags = merge(
  module.web_tags.tags,
  {
    Name = "${local.tag_name}_load_balancer_access"
  }
  )
}

module "wfh_access" {
  source      = "git@github.com:vamegh/terraform-aws-security-groups.git"
  name        = "${local.tag_name}_wfh_user_access"
  description = "Work From Home Users Access"
  vpc_id      = data.aws_vpc.mgmt.id

  allow_rules = {
    ingress_rules = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        description = "wfh_users_to_lb_https_ingress"
        type        = "ingress_cidr_blocks"
        allow       = local.wfh_cidr_list
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "wfh_users_to_bastion_ssh_ingress"
        type        = "ingress_cidr_blocks"
        allow       = local.wfh_cidr_list
      }
    ],
    egress_rules  = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        description = "lb_https_to_wfh_users_egress"
        type        = "egress_cidr_blocks"
        allow       = local.wfh_cidr_list
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "bastion_ssh_to_wfh_users_egress"
        type        = "egress_cidr_blocks"
        allow       = local.wfh_cidr_list
      }
    ]
  }

  tags = merge(
  module.web_tags.tags,
  {
    Name = "${local.tag_name}_wfh_access"
  }
  )
}
