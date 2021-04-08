module "s3_bucket" {
  source      = "git@github.com:vamegh/terraform-aws-s3.git"
  name        = var.bucket_name
  enabled     = true
  allow_read  = ["arn:aws:iam::${local.account}:role/${var.service_role}", "arn:aws:iam::${local.account}:user/${var.bucket_user}"]
  allow_write = ["arn:aws:iam::${local.account}:user/${var.bucket_user}"]

  sqs_notification = "false"

  tags = merge(
    module.s3_tags.tags,
    {
      Name = "${local.tag_name}_web_bucket"
    }
  )

  enable_versioning = "true"
  bucket_owner_full_control = "false"
}
