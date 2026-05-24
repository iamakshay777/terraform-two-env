# terraform-two-env

A minimal multi-environment Terraform project. One reusable `ec2` module
called by two environments (dev + prod) with different inputs.

```
terraform-two-env/
├── modules/
│   └── ec2/                # the only module — creates SG + EC2 (no SSH key)
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── provider.tf
    │   └── terraform.tfvars   # dev values
    └── prod/
        ├── main.tf
        ├── variables.tf
        ├── provider.tf
        └── terraform.tfvars   # prod values
```

## Design choices

- The `ec2` module auto-discovers your **default VPC + default subnet** via
  `data` sources. You do NOT need a separate `network` module or pass
  `vpc_id` / `subnet_id`.
- The module does **NOT create or use any SSH key**. The instance exposes
  HTTP (port 80) only. To get a shell on the box, use **AWS Systems Manager
  Session Manager** or the **EC2 Instance Connect** browser console.

## Before you run

1. Have AWS credentials configured: `aws configure` or
   `export AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=...`

## Deploy dev

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

After apply, `terraform output web_url` gives you a URL to open in your browser.

## Deploy prod

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## Destroy

```bash
cd environments/dev    # or prod
terraform destroy
```

## Notes

- Each environment has its OWN state file. Dev and prod are isolated; an
  `apply` in dev cannot affect prod.
- This project uses LOCAL state. For team use, configure an S3 backend in
  `provider.tf` (see Terraform docs).
- The `.gitignore` excludes `*.tfvars` and state files from git.
