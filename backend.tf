terraform {
  backend "s3" {
    bucket  = "webserver-tfstate-001"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
