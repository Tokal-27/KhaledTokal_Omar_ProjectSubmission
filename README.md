# AWS Bedrock Knowledge Base with Aurora Serverless

This project sets up an AWS Bedrock Knowledge Base integrated with an Aurora Serverless PostgreSQL database. It also includes scripts for database setup and file upload to S3.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Project Structure](#project-structure)
4. [Deployment Steps](#deployment-steps)
5. [Using the Scripts](#using-the-scripts)
6. [Customization](#customization)
7. [Troubleshooting](#troubleshooting)

## Project Overview

This project consists of several components:

1. Stack 1 - Terraform configuration for creating:
   - A VPC
   - An Aurora Serverless PostgreSQL cluster
   - s3 Bucket to hold documents
   - Necessary IAM roles and policies

2. Stack 2 - Terraform configuration for creating:
   - A Bedrock Knowledge Base
   - Necessary IAM roles and policies

3. A set of SQL queries to prepare the Postgres database for vector storage
4. A Python script for uploading files to an s3 bucket

The goal is to create a Bedrock Knowledge Base that can leverage data stored in an Aurora Serverless database, with the ability to easily upload supporting documents to S3. This will allow us to ask the LLM for information from the documentation.

## Prerequisites

Before you begin, ensure you have the following:

- AWS CLI installed and configured with appropriate credentials
- Terraform installed (version 0.12 or later)
- Python 3.10 or later
- pip (Python package manager)

## Project Structure


<img width="606" height="432" alt="Screenshot from 2025-10-13 21-58-45" src="https://github.com/user-attachments/assets/462c9283-f25a-4577-a07e-9d3b1e1b132b" />



```
project-root/
│
├── stack1
|   ├── main.tf
|   ├── outputs.tf
|   └── variables.tf
|
├── stack2
|   ├── main.tf
|   ├── outputs.tf
|   └── variables.tf
|
├── modules/
│   ├── aurora_serverless/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── bedrock_kb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── scripts/
│   ├── aurora_sql.sql
│   └── upload_to_s3.py
│
├── spec-sheets/
│   └── machine_files.pdf
│
└── README.md
```

## Deployment Steps

1. Clone this repository to your local machine.

2. Navigate to the project Stack 1. This stack includes VPC, Aurora servlerless and S3

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Review and modify the Terraform variables in `main.tf` as needed, particularly:
   - AWS region
   - VPC CIDR block
   - Aurora Serverless configuration
   - s3 bucket

5. Deploy the infrastructure:
   ```
   terraform apply
   ```
   Review the planned changes and type "yes" to confirm.

6. After the Terraform deployment is complete, note the outputs, particularly the Aurora cluster endpoint.

7. Prepare the Aurora Postgres database. This is done by running the sql queries in the script/ folder. This can be done through Amazon RDS console and the Query Editor.

8. Navigate to the project Stack 2. This stack includes Bedrock Knowledgebase

9. Initialize Terraform:
   ```
   terraform init
   ```

10. Use the values outputs of the stack 1 to modify the values in `main.tf` as needed:
     - Bedrock Knowledgebase configuration

11. Deploy the infrastructure:
      ```
      terraform apply
      ```
      - Review the planned changes and type "yes" to confirm.


12. Upload pdf files to S3, place your files in the `spec-sheets` folder and run:
      ```
      python scripts/upload_to_s3.py
      ```
      - Make sure to update the S3 bucket name in the script before running.

13. Sync the data source in the knowledgebase to make it available to the LLM.

## Using the Scripts

### S3 Upload Script

The `upload_to_s3.py` script does the following:
- Uploads all files from the `spec-sheets` folder to a specified S3 bucket
- Maintains the folder structure in S3

To use it:
1. Update the `bucket_name` variable in the script with your S3 bucket name.
2. Optionally, update the `prefix` variable if you want to upload to a specific path in the bucket.
3. Run `python scripts/upload_to_s3.py`.

## Complete chat app

### Complete invoke model and knoweldge base code
- Open the bedrock_utils.py file and the following functions:
  - query_knowledge_base
  - generate_response

### Complete the prompt validation function
- Open the bedrock_utils.py file and the following function:
  - valid_prompt

  Hint: categorize the user prompt

## Troubleshooting

- If you encounter permissions issues, ensure your AWS credentials have the necessary permissions for creating all the resources.
- For database connection issues, check that the security group allows incoming connections on port 5432 from your IP address.
- If S3 uploads fail, verify that your AWS credentials have permission to write to the specified bucket.
- For any Terraform errors, ensure you're using a compatible version and that all module sources are correctly specified.

For more detailed troubleshooting, refer to the error messages and logs provided by Terraform and the Python scripts.

Screens 

Database properly configured for vector storage. 

<img width="1920" height="1080" alt="Database properly configured for vector storage" src="https://github.com/user-attachments/assets/c9e0c809-b612-4887-9199-01ebae5de4d2" />


Proper configuration and security settings

<img width="1920" height="1080" alt="Proper configuration and security settings" src="https://github.com/user-attachments/assets/b7b3b7b9-f271-4b7d-8c00-0615f8df43d4" />



Screenshot of deployed knowledge base interface

<img width="1920" height="1080" alt="Screenshot of deployed knowledge base interface" src="https://github.com/user-attachments/assets/e8d192e0-41e9-498c-a70f-1a5c1a00f7a0" />



Screenshot of successful data sync from the AWS console

<img width="1920" height="1080" alt="Screenshot of successful data sync from the AWS console" src="https://github.com/user-attachments/assets/74bb0eae-f6d7-4760-818b-0ec6609b1bc2" />


Screenshot showing the information of the bedrock_integration.bedrock_kb table by running the following query:


<img width="1920" height="1080" alt="Screenshot showing the information of the bedrock_integration bedrock_kb table by running the following query:
" src="https://github.com/user-attachments/assets/ae845307-504a-463f-82b6-4e7913be92a3" />



Stack1-terraform-output

<img width="812" height="556" alt="Stack1-terraform-output" src="https://github.com/user-attachments/assets/1a510347-ff70-4890-9c1e-2de6793dd99f" />



Stack2-terraform-output

<img width="812" height="266" alt="stack2-terraform-output" src="https://github.com/user-attachments/assets/24cbd27a-9e1a-49a7-8fa8-9c8ca7f8363b" />



Streamlit Deploy (Offline)

<img width="1920" height="1080" alt="Screenshot from 2025-10-13 21-23-59" src="https://github.com/user-attachments/assets/cbc716c9-243e-493c-a3c9-6638802fb956" />





## 📞 Contact

For questions or feedback, reach out to:
- GitHub Issues
- Email: Omar.tokal2020@gmail.com


---



