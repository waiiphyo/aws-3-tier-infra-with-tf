resource "aws_lb_target_group" "target_group" {
  name     = "tgp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid
  target_type = "instance"
  health_check {
    path    = "/"
    interval = 30
    port = 80
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    protocol = "HTTP"
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name             = "my-autoscaling-group"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2
  vpc_zone_identifier = [var.subnet1, var.subnet2]

  target_group_arns = [
    aws_lb_target_group.target_group.arn,
  ]
  launch_template {
    id      = var.template-id
    version = var.template-version
  }
}