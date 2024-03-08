# Launch Template and Scaling group for Lighting

resource "aws_launch_template" "lighting_lt" {
  name_prefix            = "lighting-lt-"
  image_id               = "ami-0ee9d687eab0ed726"
  instance_type          = "t2.micro"
  key_name               = "MyKeyPair4"
  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Lighting Instance (AS)"
    }
  }
}

resource "aws_autoscaling_group" "lighting_asg" {
  launch_template {
    id      = aws_launch_template.lighting_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [var.lighting_tg_arn]
}

# ------------------------------------------------------------

# Launch Template and Scaling group for Heating

resource "aws_launch_template" "heating_lt" {
  name_prefix            = "heating-lt-"
  image_id               = "ami-082d40138a106ff58"
  instance_type          = "t2.micro"
  key_name               = "MyKeyPair4"
  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Heating Instance (AS)"
    }
  }
}

resource "aws_autoscaling_group" "heating_asg" {
  launch_template {
    id      = aws_launch_template.heating_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [var.heating_tg_arn]
}

# ------------------------------------------------------------

# Launch Template and Scaling group for Status

resource "aws_launch_template" "status_lt" {
  name_prefix            = "status-lt-"
  image_id               = "ami-0981bccc7ae95d796"
  instance_type          = "t2.micro"
  key_name               = "MyKeyPair4"
  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Status Instance (AS)"
    }
  }
}

resource "aws_autoscaling_group" "status_asg" {
  launch_template {
    id      = aws_launch_template.status_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [var.status_tg_arn]
}

# ------------------------------------------------------------

# Launch Template and Scaling group for Auth

resource "aws_launch_template" "auth_lt" {
  name_prefix            = "auth-lt-"
  image_id               = "ami-0b2a4711206951c46"
  instance_type          = "t2.micro"
  key_name               = "MyKeyPair4"
  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Auth Instance (AS)"
    }
  }
}

resource "aws_autoscaling_group" "auth_asg" {
  launch_template {
    id      = aws_launch_template.auth_lt.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [var.auth_tg_arn]
}

# ------------------------------------------------------------
