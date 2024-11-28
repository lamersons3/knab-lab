resource "aws_security_group" "docker-host-sg" {
  name        = "knab-lab-docker-host-sg"
  description = "Security group for EC2 instance in private subnet"
  vpc_id      = aws_vpc.knab_vpc.id

  ingress {
    description              = "Allow traffic from ALB on ports 8080-8090"
    from_port                = 8080
    to_port                  = 8090
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
    # source_security_group_id = aws_security_group.alb_sg.id
  }

    ingress {
    description              = "Allow ssh"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
    # source_security_group_id = aws_security_group.alb_sg.id
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "knab-lab-docker-host-sg" })
}

resource "aws_security_group" "lb_sg" {
  name        = "lb-security-group"
  description = "Allow HTTPS traffic"
  vpc_id      = aws_vpc.knab_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "knab-lab-lb-sg" })
}