terraform {
  backend "s3" {
    bucket  = "jcde-terraform-state-01"
    key     = "terraform/test-abl/tfstate"
    region  = "ap-southeast-1"
  }
}