provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

provider "aws" {
  profile = "terraform"
  alias   = "use1"
  region  = "us-east-1"
}
