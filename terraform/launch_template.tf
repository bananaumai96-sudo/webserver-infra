# --- 起動テンプレート作成 ---
resource "aws_launch_template" "webserver" {
  name_prefix            = "webserver-"
  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.network.security_group_ec2_id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.root_volume_type
      delete_on_termination = true
      encrypted             = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_cloudwatch_profile.name
  }

  user_data = base64encode(local.ec2_user_data)
  tags      = merge(local.common_tags, { Name = "webserver" })
  tag_specifications {
    resource_type = "volume"
    tags = merge(local.common_tags, {
      Name = "webserver-ebs"
    })

  }
}
