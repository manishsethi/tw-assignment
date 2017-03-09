# TW_Assignment


This is the code to automate the mediawiki deployment on centos on AWS.

# Key points

  - In this case, we are using terraform to build infra on AWS, so you are required to export access/secret keys as follows

```sh
    export TF_VAR_aws_secret_key=""
    export TF_VAR_aws_access_key=""
```

  - In case of provision, we are using chef and you can use them by uploading cookbooks to chef server and then executing below knife command, you can bootstrap the node.
```sh
knife bootstrap <ec2-machine-ip-address>  --ssh-user centos -i <path-to-pem-key> -r <run_list> -N <node-name> --sudo --use-sudo-password -y
```
