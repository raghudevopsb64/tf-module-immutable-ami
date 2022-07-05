resource "aws_instance" "ami" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "${var.COMPONENT}-ami"
  }
}


