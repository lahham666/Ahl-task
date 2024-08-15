This devops assessment task  was developed for Tucows to be sent by ahl logics
This Terraform module deploys a 2-tier application architecture on AWS, consisting of API and database servers. It adheres to best practices for VPC design, security, and operational efficiency. The deployment includes logging and alerting capabilities for monitoring and troubleshooting.

the terraform include 
8 files of resoures creation 
provider.tf
This file defines the Terraform providers used to interact with AWS services
db-resources.tf
This file defines the resources of creation of RDS 
ec2-resources.tf
this files defines the resources of creation of ec2 and LoadBalancer
remote-state.tf
this files store the tfstate in S3
security-group.tf
this files defines the Security group the allowed port and the incoming and outcoming traffic
variables.tf
vpc.tf
this files defines the structure of the vpc by 2 public subnet and 2 private subnet and private subnet for RDS and and load balancer to round robin the traffic into web server in public subnet 
cloudtrail.tf
implment cloudtrail and cloudwatch to monitior and logging the websever and api calls happen in the infrastructure


  Usage
 1 -  glone the repo 
 2 -  Navigate to the module directory:
 3 -  Configure variables: Update the variables.tf file with your desired values
 4-   Initialize Terraform: by command terraform init 
 5-   Plan the deployment terraform plan 
 6    Apply the changes  terraform apply

all infrastructure was deploy into eu-west-1 (ireland) region  
there are terraformplanresults.txt that display the full output of terraform plan command 

 feel free to reach out incase of any inquiries 
 


