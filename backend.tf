terraform {
  backend "s3" {
    bucket         = "knab-lab-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "knab-lab-terraform-locks"
    encrypt        = false
  }
}
terraform {
  required_providers {
    godaddy = {
      source  = "n3integration/godaddy"
      version = "1.9.1"
    }
  }
}
