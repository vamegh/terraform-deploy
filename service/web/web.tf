resource "aws_route53_record" "entry" {
  zone_id = data.aws_route53_zone.ev9.zone_id
  name    = "redDeer"
  type    = "A"

  alias {
    name                   = module.web_lb.alb_dns_name
    zone_id                = module.web_lb.alb_zone_id
    evaluate_target_health = true
  }
}

module "acm_cert" {
  #source                   = "git@github.com:vamegh/terraform-aws-acm-certs.git"
  #validation_record_ttl    = "60"
  #dns_zone_id              = data.aws_route53_zone.ev9.zone_id
  source                    = "terraform-aws-modules/acm/aws"
  version                   = "~> v2.0"
  create_certificate        = true
  validate_certificate      = true
  wait_for_validation       = true
  zone_id                   = data.aws_route53_zone.ev9.zone_id
  dns_ttl                   = "60"
  validation_method         = "DNS"
  domain_name               = local.dns_hostname

  subject_alternative_names = [
    "${format("%s.%s", var.name, data.aws_route53_zone.ev9.name)}",
  ]

  tags = merge(
  module.web_tags.tags,
  {
    Name = "${local.tag_name}_lb_acm"
  })
}

module "web_lb" {
  source = "git@github.com:vamegh/terraform-aws-alb.git"
  name   = "${local.name}-lb"

  lb_app_port           = var.lb_app_port
  vpc_id                = data.aws_vpc.mgmt.id
  enable_https_listener = true
  enable_jnlp_listener  = var.enable_jnlp_listener
  jnlp_listener_port    = var.jnlp_listener_port
  target_type           = var.target_type
  idle_timeout          = var.idle_timeout

  public_subnet_ids = data.aws_subnet_ids.public.ids

  security_group_ids = [
    module.web_private_access.sg_id,
    module.web_lb_access.sg_id,
    module.wfh_access.sg_id
  ]

  #acm_cert_arn = module.acm_cert.cert_arn
  acm_cert_arn = module.acm_cert.this_acm_certificate_arn

  ## enable sticky sessions using lb_cookie
  enable_stickiness = var.enable_stickiness
  cookie_duration   = var.cookie_duration

  ## health checks for main alb target
  enable_main_health    = var.enable_main_health
  main_interval_health  = var.main_interval_health
  main_path_health      = var.main_path_health
  main_port_health      = var.main_port_health
  main_protocol_health  = var.main_protocol_health
  main_timeout_health   = var.main_timeout_health
  main_threshold_health = var.main_threshold_health
  main_unhealthy_health = var.main_unhealthy_health
  main_matcher          = var.main_matcher

  ## health checks for jnlp alb target
  enable_jnlp_health    = var.enable_jnlp_health
  jnlp_interval_health  = var.jnlp_interval_health
  jnlp_path_health      = var.jnlp_path_health
  jnlp_port_health      = var.jnlp_port_health
  jnlp_protocol_health  = var.jnlp_protocol_health
  jnlp_timeout_health   = var.jnlp_timeout_health
  jnlp_threshold_health = var.jnlp_threshold_health
  jnlp_unhealthy_health = var.jnlp_unhealthy_health
  jnlp_matcher          = var.jnlp_matcher

  ## Deregistration delays for main and jnlp alb targets
  main_dereg_delay = var.main_dereg_delay
  jnlp_dereg_delay = var.jnlp_dereg_delay

  tags = merge(
  module.web_tags.tags,
  {
    Name = "${local.tag_name}_load_balancer"
  })
}

module "web_asg" {
  source = "git@github.com:vamegh/terraform-aws-lc-asg.git"
  name   = "${local.name}-asg"

  ami_image_id      = data.aws_ami.web.id
  ami_instance_type = var.ami_instance_type
  cbd               = "false"

  ami_iam_profile_id = var.web_iam_profile_id
  asg_min_size       = var.asg_min_size
  asg_max_size       = var.asg_max_size
  desired_capacity   = var.desired_cap

  load_balancer_arns = [
    module.web_lb.jnlp_target_group_arn,
    module.web_lb.main_target_group_arn,
  ]

  force_delete              = var.force_delete
  spot_price                = var.spot_price
  health_check_grace_period = var.health_check_grace_period

  security_group_ids = [
    module.web_private_access.sg_id,
    module.web_lb_access.sg_id,
    module.wfh_access.sg_id,
  ]

  # subnet_ids = data.aws_subnet_ids.private.ids
  subnet_ids = data.aws_subnet_ids.public.ids

  tags = module.web_asg_tags.tags_as_list
}

