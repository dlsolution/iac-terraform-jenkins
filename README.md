# Provision the EKS cluster

```bash
terraform init
terraform plan
terraform apply
```

Output:
```bash
ec2_instance_publicip = [
  "44.234.123.1",
]
```

You can access jenkins by `http://ec2_instance_publicip:8080`
