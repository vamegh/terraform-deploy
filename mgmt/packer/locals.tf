locals {
  public_cidr_block = cidrsubnet(var.cidr, 1, 0)
  name = format("%s-%s-%s", var.name, var.service, var.project)
  tag_name = format("%s_%s_%s", var.name, var.service, var.project)
}
