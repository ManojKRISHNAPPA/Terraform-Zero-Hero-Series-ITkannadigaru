terraform {
  required_version = "1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
        source = "hashicorp/random"
    }

    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.60.0"
    }

  }
}

provider "aws" {
  region = "us-west-2"
}

provider "azurerm" {
  features {
   
  }
}