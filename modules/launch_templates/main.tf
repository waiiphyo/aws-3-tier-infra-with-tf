data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash
sudo apt update -y 
sudo apt install apache2 -y 
echo "hello world from $(hostname)" > /var/www/html/index.html
sudo systemctl enabled apache2 
sudo systemctl start apache2
EOF
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_launch_template" "launch_template" {
  name          = "launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "wp-test"
  network_interfaces {
    device_index    = 0
    security_groups = [var.sg-id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-ec2"
    }
  }
  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}