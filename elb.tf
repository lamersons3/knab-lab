resource "aws_elb" "knab_lab_lb" {
  name               = "knab-lab-lb"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet.id]

  listener {
    instance_port      = 8080
    instance_protocol  = "HTTP"
    lb_port            = 443
    lb_protocol        = "HTTPS"
    ssl_certificate_id = var.ssl_cert_arn
  }

  health_check {
    target              = "HTTP:8080/"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, { Name = "knab-lab-lb" })
}

resource "aws_elb_attachment" "knab_lab_lb_attachment" {
  elb      = aws_elb.knab_lab_lb.id
  instance = aws_instance.docker-host.id
}