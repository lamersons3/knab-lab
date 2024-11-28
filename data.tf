data "aws_ec2_transit_gateway" "knab-lab-transit-gateway" {
  filter {
    name   = "tag:Name"
    values = ["knab-lab-transit-gateway"]
  }
}
data "aws_s3_bucket" "knab-lab-terraform-state" {
  bucket = "knab-lab-terraform-state"
}

data "aws_dynamodb_table" "knab-lab-terraform-locks" {
  name = "knab-lab-terraform-locks"
}

