# TW_Assignment


This is the code to automate the mediawiki deployment on centos on AWS.

# Key points

  - In this case, we are using terraform to build infra on AWS, so you are required to export access/secret keys as follows

```sh
    export TF_VAR_aws_secret_key=""
    export TF_VAR_aws_access_key=""
```
