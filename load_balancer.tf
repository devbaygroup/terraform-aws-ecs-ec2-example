resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.domain_name
  }
}


#tfsec:ignore:aws-elb-alb-not-public
#tfsec:ignore:aws-elb-drop-invalid-headers
resource "aws_lb" "this" {
  name               = var.service_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_id]
  subnets            = var.subnet_id
}


resource "aws_alb_target_group" "this" {
  name        = var.service_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    port    = "traffic-port"
    path    = var.health_check_path
    matcher = "200-499"
  }
}


#tfsec:ignore:aws-elb-http-not-used
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.this.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


#tfsec:ignore:aws-elb-use-secure-tls-policy
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.this.id
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.id
  }

}
