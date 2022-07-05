resource "aws_spot_instance_request" "spot" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.main.id]
  wait_for_fulfillment   = true
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name

  tags = {
    Name = "${var.COMPONENT}-ami"
  }
}

resource "aws_ec2_tag" "name-tag" {
  resource_id = aws_spot_instance_request.spot.spot_instance_id
  key         = "Name"
  value       = "${var.COMPONENT}-ami"
}

