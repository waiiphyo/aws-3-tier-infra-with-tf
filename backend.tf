# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "wtfstate"
    key = "state/terraform.tfstate"
    region = "us-east-1"
    profile = "waiphyo-prod-profile"
    
  }
}