resource "aws_lb" "external-alb" {
  name               = "custom-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.pub-alb-security_groups-id]
  subnets            = [var.pub-sub1,var.pub-sub2]

  tags = {
    name    = "custom-alb"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = var.FE-TG
  }
}
