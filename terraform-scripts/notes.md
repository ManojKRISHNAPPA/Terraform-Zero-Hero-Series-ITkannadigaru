## this is the official doc:  
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

# Install Terraform on Ubuntu
---

## 1. Installtion-script
```bash
#!/bin/bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y
```

## VSCODE package:
- https://code.visualstudio.com/

## Terraform Pluggin:
- https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform


## AWS cli installion on ubuntu:
```bash
snap install aws-cli --classic
```

```
root@ip-172-31-45-192:~/Terraform-Zero-Hero-Series-ITkannadigaru/03-ec2-basic# aws configure
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: us-west-2
Default output format [None]: json
```


## AWS uses IANA protocol numbers:

Protocol	Number
TCP	         6
UDP	         17
ICMP       	 1
ALL	         -1

## Architecture of Any Terraform project:
![alt text](image.png)
