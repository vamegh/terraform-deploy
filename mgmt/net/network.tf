module "mgmt_net_vpc" {
  source = "git@github.com:vamegh/terraform-aws-vpc.git"
  name               = "mgmt-${local.name}"
  cidr_block         = var.network_cidr
  single_nat_gateway = true

  subnets = [
    {
      name              = "private"
      type              = "private"
      availability_zone = {
        "${data.aws_availability_zones.available.names[0]}" = "${local.private_cidr_blocks[0]}"
        "${data.aws_availability_zones.available.names[1]}" = "${local.private_cidr_blocks[1]}"
        "${data.aws_availability_zones.available.names[2]}" = "${local.private_cidr_blocks[2]}"
      }

      tags = merge(
      module.net_tags.tags, {
        Name = "mgmt_${local.tag_name}_private_subnets"
      })
    },
    {
      name              = "public"
      type              = "public"
      map_public_ip_on_launch = true
      availability_zone = {
        "${data.aws_availability_zones.available.names[0]}" = "${local.public_cidr_blocks[0]}"
        "${data.aws_availability_zones.available.names[1]}" = "${local.public_cidr_blocks[1]}"
        "${data.aws_availability_zones.available.names[2]}" = "${local.public_cidr_blocks[2]}"
      }

      tags = merge(
      module.net_tags.tags, {
        Name = "mgmt_${local.tag_name}_public_subnets"
      })
    }
  ]

  tags = module.net_tags.tags
}
