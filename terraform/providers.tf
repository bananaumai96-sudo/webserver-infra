# --- provider指定 ---
# デフォルトは東京リージョンを指定
# バージニア北部はWAFを作成するため

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  } 
}

provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

provider "aws" {
  profile = "terraform"
  alias   = "use1"
  region  = "us-east-1"
}
