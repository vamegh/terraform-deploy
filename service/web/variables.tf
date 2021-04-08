variable "availability_zone" {
  type = string
}
variable "region" {
  type = string
}

variable "account_name" {}
variable "application" {}
variable "business_owner" {}
variable "cost_center" {}
variable "documentation" {}
variable "environment" {}
variable "sub_environment" {}
variable "name" {}
variable "service" {}
variable "project" {}

variable "dns_zone_name" {}
variable "dns_master_zone" {}
variable "dns_private_zone_name" {}
variable "network_cidr" {}
variable "lb_app_port" {}
variable "spot_price" {}
variable "ami_instance_type" {}
variable "asg_min_size" {}
variable "asg_max_size" {}
variable "az_count" {}
variable "desired_cap" {}
variable "force_delete" {}
variable "target_type" {}

variable "health_check_grace_period" {}
variable "idle_timeout" {}
variable "enable_jnlp_listener" {}
variable "jnlp_listener_port" {}
variable "enable_stickiness" {}
variable "cookie_duration" {}

variable "enable_main_health" {}
variable "main_interval_health" {}
variable "main_path_health" {}
variable "main_port_health" {}
variable "main_protocol_health" {}
variable "main_timeout_health" {}
variable "main_threshold_health" {}
variable "main_unhealthy_health" {}
variable "main_matcher" {}
variable "main_dereg_delay" {}

variable "enable_jnlp_health" {}
variable "jnlp_interval_health" {}
variable "jnlp_path_health" {}
variable "jnlp_port_health" {}
variable "jnlp_protocol_health" {}
variable "jnlp_timeout_health" {}
variable "jnlp_threshold_health" {}
variable "jnlp_unhealthy_health" {}
variable "jnlp_matcher" {}
variable "jnlp_dereg_delay" {}

variable "jagent_spot_price" {}
variable "jagent_ami_instance_type" {}
variable "jagent_asg_min_size" {}
variable "jagent_asg_max_size" {}
variable "jagent_desired_cap" {}
variable "jagent_force_delete" {}
variable "jagent_health_check_grace_period" {}
variable "jagent_iam_profile_id" {}

variable "bastion_ami_instance_type" {}
variable "bastion_asg_min_size" {}
variable "bastion_asg_max_size" {}
variable "bastion_desired_cap" {}
variable "bastion_spot_price" {}
variable "bastion_force_delete" {}
variable "bastion_health_check_grace_period" {}
variable "bastion_associate_public_ip" {}

variable "accounts" {
  type = map(string)
}

variable "users" {
  description = "data structure to handle all user connection information"
  type = list(object({
    name = string
    pubkey_file = string
    access_ips = list(string)
  }))
}

variable "dns_lookup_tags" {
  type = map(string)
}

variable "public_subnets" {
  type = map(string)
}

variable "web_iam_profile_id" {
  type = string
}
