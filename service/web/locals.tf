locals {
  name                 = format("%s-%s", var.project, var.service)
  name_tag             = format("%s_%s", var.project, var.service)
  tag_name             = format("%s_%s", var.project, var.service)
  global_public_subnet = var.public_subnets["global"]
  dns_hostname         = format("%s.%s", var.name, var.dns_zone_name)

  all_cidr_blocks = flatten([
    data.aws_subnet.private.*.cidr_block,
    data.aws_subnet.public.*.cidr_block])

  wfh_cidr_list       = flatten([for user in var.users: user.access_ips if user.access_ips != []])
}
