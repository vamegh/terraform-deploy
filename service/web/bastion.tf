module "web_bastion_asg" {
  source = "git@github.com:vamegh/terraform-aws-lc-asg.git"
  name   = "web-bastion-asg"

  ami_image_id      = data.aws_ami.bastion.id
  ami_instance_type = var.bastion_ami_instance_type
  cbd               = false

  ami_iam_profile_id        = ""
  asg_min_size              = var.bastion_asg_min_size
  asg_max_size              = var.bastion_asg_max_size
  desired_capacity          = var.bastion_desired_cap
  load_balancer_arns        = []
  force_delete              = var.bastion_force_delete
  spot_price                = var.bastion_spot_price
  health_check_grace_period = var.bastion_health_check_grace_period
  associate_public_ip       = var.bastion_associate_public_ip

  security_group_ids = [
    module.web_private_access.sg_id,
    module.wfh_access.sg_id
  ]

  subnet_ids = data.aws_subnet_ids.public.ids

  tags = module.bastion_asg_tags.tags_as_list
}
