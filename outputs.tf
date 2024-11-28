output "vpc_id" {
  value       = aws_vpc.knab_vpc.id
}

output "aws_lb_dns_name" {
  value       = aws_elb.knab_lab_lb.dns_name
}
