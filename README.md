# Terraform Project Structure

The Terraform project is split into two parts:

1. **infra/:** This folder holds the code for cloud offerings like VPC, service account, and the GKE cluster.
2. **workloads/:** This folder holds all the Kubernetes manifests for deploying pods, services, and ingresses.

## Prerequisites

Install the following tools to execute the commands:

- Terraform
- Google Cloud CLI (`gcloud`)
- Kubernetes CLI (`kubectl`)

Export the google project id

- `export TF_VAR_project_id="<project_id>"` This is used for all the Terraform actions
- `export GOOGLE_PROJECT="<project_id>"` This again is used by Terraform for any api imports

## Set Up and Deployment

1. To apply the project, set up the Google credentials using `gcloud auth login` and change the `credential.json` file to the right path in `./Jar/infra/main.tf`.

2. Run `terraform init` from `infra/` to install the provider packages.

    ```bash
    cd infra/
    terraform init
    ```

3. Run `terraform plan` to visualize the changes that are supposed to happen and validate them across the Terraform modules.

    ```bash
    terraform plan
    ```

4. Finally, run `terraform apply` to apply the changes, which should create the infrastructure on your GCP console.

    ```bash
    terraform apply
    ```
5. # Terraform Project Structure

The Terraform project is split into two parts:

1. **infra/:** This folder holds the code for cloud offerings like VPC, service account, and the GKE cluster.
2. **workloads/:** This folder holds all the Kubernetes manifests for deploying pods, services, and ingresses.

## Prerequisites

Install the following tools to execute the commands:

- Terraform
- Google Cloud CLI (`gcloud`)
- Kubernetes CLI (`kubectl`)

## Set Up and Deployment

1. To apply the project, set up the Google credentials using `gcloud auth login` and change the `credential.json` file to the right path in `./Jar/infra/main.tf`.

2. Run `terraform init` from `infra/` to install the provider packages.

    ```bash
    cd infra/
    terraform init
    ```

3. Run `terraform plan` to visualize the changes that are supposed to happen and validate them across the Terraform modules.

    ```bash
    terraform plan
    ```

4. Finally, run `terraform apply` to apply the changes, which should create the infrastructure on your GCP console.

    ```bash
    terraform apply
    ```

5. Similar structure is followed for the Kubernetes workloads as well. The deployment manifests are in `workloads/deployments`.

6. Run the above three commands from `workloads/` to create the Kubernetes workloads in the GKE cluster.

    ```bash
    cd ../workloads/
    terraform init
    terraform plan
    terraform apply
    ```

Ensure you have the necessary permissions and configurations for the Google Cloud project.

```bash
gcloud auth login
