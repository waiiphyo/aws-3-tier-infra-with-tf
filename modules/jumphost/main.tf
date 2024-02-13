resource "aws_instance" "instance1" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet
  key_name = "wp-test"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg]

  tags = {
    Name = var.instance_name
  }
}