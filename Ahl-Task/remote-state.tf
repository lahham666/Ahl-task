terraform {
  backend "s3" {
    bucket = "ahl-assessment"
    key    = "infra/vpc/vpc.tfstate"
    region = "eu-west-1"
  }
}
