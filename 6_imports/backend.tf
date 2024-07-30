terraform {
  backend "s3" {
    bucket = "techstarter-marcel-iac"
    key    = "ec2-example/ec2-example.tfstate"
    region = "eu-central-1"
  }
}