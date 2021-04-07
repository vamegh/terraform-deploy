locals {
  global_public_subnet = var.public_subnets.global

  public_cidr_blocks = [
    cidrsubnet(var.network_cidr, 7, 1),
    cidrsubnet(var.network_cidr, 7, 2),
    cidrsubnet(var.network_cidr, 7, 3),
  ]

  private_cidr_blocks = [
    cidrsubnet(var.network_cidr, 7, 4),
    cidrsubnet(var.network_cidr, 7, 5),
    cidrsubnet(var.network_cidr, 7, 6),
  ]

  name = format("%s-%s", var.name, var.project)
  tag_name = format("%s_%s", var.name, var.project)
}
