resource "aws_instance" "docker-host" {
  ami           = "ami-017095afb82994ac7"
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.private_subnet.id
  private_ip    = var.ec2_private_ip
  user_data     = file("scripts/user-data.sh")
  tags          = merge(var.tags, { Name = "knab-lab-docker-host" })
  key_name      = "mike-k8s-thw"
  security_groups = [ aws_security_group.docker-host-sg.id ]
}
