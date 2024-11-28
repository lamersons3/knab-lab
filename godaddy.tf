# resource "godaddy_domain_record" "knab_lab_godaddy_cname" {
#   domain = "mikez.online"

#   record {
#     name = "knab-lab"
#     type = "CNAME"
#     data = aws_elb.knab_lab_lb.dns_name
#     ttl  = 1800
#   }
# }