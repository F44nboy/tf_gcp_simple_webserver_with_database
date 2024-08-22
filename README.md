## How to Use This Configuration
Initialize Terraform: Run terraform init to initialize Terraform and download the necessary providers.
```bash
    terraform init
```

Create a Terraform Plan: Run terraform plan to see what resources will be created.

```bash
    terraform plan
```

Apply the Terraform Plan: Run terraform apply to create the resources on GCP. You will be prompted to confirm.

```bash
    terraform apply
```

View Outputs: After applying, you can see the outputs like the web server's IP address by running terraform output.
```bash
    terraform output
```
## Notes:
- Before you plan or apply create a .tfvars file and enter all the variables and values you need to run this code
- Make sure your Google Cloud credentials are properly set up in your environment, so Terraform can authenticate with GCP.
- The web server and the database instance are deployed in the same network, making it easy for the web server to communicate with the database securely.