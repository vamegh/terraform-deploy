data "aws_availability_zones" "available" {
}

data "aws_ami" "web" {
  most_recent = true

  filter {
    name = "tag:ami_role"

    values = [
      "${var.service}-base*",
    ]
  }

  filter {
    name = "tag:release_status"

    values = [
      "release",
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm",
    ]
  }

  owners = [
    "self",
  ]
}

data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name = "tag:ami_role"

    values = [
      "core-ubuntu-base*",
    ]
  }

  filter {
    name = "tag:release_status"

    values = [
      "release",
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm",
    ]
  }

  owners = [
    "self",
  ]
}

data "aws_vpc" "mgmt" {
  filter {
    name = "state"

    values = [
      "available",
    ]
  }

  filter {
    name = "tag:Application"

    values = [
      "vpc",
    ]
  }

  filter {
    name = "tag:Service"

    values = [
      "networking",
    ]
  }

  filter {
    name = "tag:Project"

    values = [
      var.project,
    ]
  }

  filter {
    name = "tag:Sub-Environment"

    values = [
      "mgmt",
    ]
  }

  filter {
    name = "tag:Source-Environment"

    values = [
      var.environment,
    ]
  }
}

data "aws_route53_zone" "ev9" {
  name = var.dns_zone_name
}


data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.mgmt.id
  filter {
    name   = "state"
    values = [
      "available",
    ]
  }

  filter {
    name   = "tag:Application"
    values = [
      "vpc",
    ]
  }

  filter {
    name   = "tag:Service"
    values = [
      "networking",
    ]
  }

  filter {
    name = "tag:Project"

    values = [
      var.project,
    ]
  }

  filter {
    name   = "tag:Sub-Environment"
    values = [
      "mgmt",
    ]
  }

  filter {
    name   = "tag:Source-Environment"
    values = [
      var.environment,
    ]
  }

  filter {
    name   = "tag:Name"
    values = [
      "mgmt_net_redDeer_public_subnets"
    ]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.mgmt.id
  filter {
    name   = "state"
    values = [
      "available",
    ]
  }

  filter {
    name   = "tag:Application"
    values = [
      "vpc",
    ]
  }

  filter {
    name   = "tag:Service"
    values = [
      "networking",
    ]
  }

  filter {
    name = "tag:Project"

    values = [
      var.project,
    ]
  }

  filter {
    name   = "tag:Sub-Environment"
    values = [
      "mgmt",
    ]
  }

  filter {
    name   = "tag:Source-Environment"
    values = [
      var.environment,
    ]
  }

  filter {
    name   = "tag:Name"
    values = [
      "mgmt_net_redDeer_private_subnets"
    ]
  }
}

data "aws_subnet" "private" {
  count = length(data.aws_subnet_ids.private.ids)
  id    = tolist(data.aws_subnet_ids.private.ids)[count.index]
}

data "aws_subnet" "public" {
  count = length(data.aws_subnet_ids.public.ids)
  id    = tolist(data.aws_subnet_ids.public.ids)[count.index]
}
