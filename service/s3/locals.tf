locals {
  name                 = format("%s-%s", var.project, var.service)
  name_tag             = format("%s_%s", var.project, var.service)
  tag_name             = format("%s_%s", var.project, var.service)
  account              = lookup(var.accounts, "ev9")
}
