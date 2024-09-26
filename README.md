# EC2 to EKS Migration by CloudOps

[cloudops-services.com](http://cloudops-services.com)  
Free for personal and commercial use under the MIT license (cloudops-services.com/license)

This project walks through the process of migrating an application from an EC2 instance to EKS (Elastic Kubernetes Service) using Terraform to manage infrastructure as code. You will:

- Set up EC2 infrastructure.
- Deploy the application on EC2 using PM2.
- Create an EKS cluster.
- Dockerize and deploy the application to EKS.
- Migrate any necessary data.
- Tear down the EC2 infrastructure.

Hope you find this guide helpful :)

**AJ**  
admin@cloudops-services.com | @cloudops

---

## Requirements:

- **AWS CLI** (configured with appropriate credentials).
- **Terraform**.
- **kubectl**.
- **Docker**.

---

## Steps:

### 1. EC2 Infrastructure Setup and Application Deployment

Navigate to the EC2 infrastructure directory and apply the Terraform configuration to create an EC2 instance:

```bash
cd infraestructure/ec2_infrastructure
terraform init
terraform apply
```

Once the instance is created, connect via SSH:

```bash
ssh -i "path/to/key.pem" ec2-user@<ec2_public_ip>
```
Check the application status:

```bash
pm2 status
pm2 logs ml-demo-app
```

### 2. Dockerize the Application

Clone this repository:

```bash
git clone https://github.com/cloudops-services/EC2-Application-ML-Demo.git
```

Build the Docker image and push it to ECR:

```bash
docker build -t ml-demo-app .
docker tag ml-demo-app:latest <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/ml-demo-app:latest
docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/ml-demo-app:latest
```

### 3. EKS Cluster Setup

Navigate to the EKS infrastructure directory:

```bash
cd ../eks_infrastructure
terraform init
terraform apply
```

Configure kubectl to interact with the EKS cluster:

```bash
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
```

Check that kubectl is configured correctly:

```bash
kubectl get nodes
```

### 4. Deploy the Application to EKS

Move to deployments directory

```bash
cd deployments
```

Apply the files:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

Verify the application and service:

```bash
kubectl get pods
kubectl get svc ml-demo-app-service
```

### 5. Data Migration (If Needed)

To transfer data from EC2 to EKS:

Export data from the EC2 instance:

```bash
scp -i "path/to/key.pem" ec2-user@<ec2_public_ip>:/path/to/data ./local-directory/
```

Import the data into EKS or S3 as needed.

### 6. Tear Down EC2 Infrastructure

Navigate back to the EC2 infrastructure directory:

```bash
cd ../ec2_infrastructure
```

Destroy the EC2 resources:

```bash
terraform destroy
```
