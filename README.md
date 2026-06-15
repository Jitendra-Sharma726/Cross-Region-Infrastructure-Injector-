# Cross-Region-Infrastructure-Injector-

Project Description – Cross-Region Infrastructure Injector

This project demonstrates a real-world multi-region cloud deployment workflow where infrastructure resources are provisioned in different geographic regions and their dynamically generated identifiers are automatically injected into application configuration files. The solution combines Terraform for infrastructure provisioning and Ansible for configuration management, creating a seamless Infrastructure-as-Code (IaC) pipeline.

Project Objectives
Provision cloud resources across multiple regions.
Export dynamically generated infrastructure identifiers (ARNs).
Automate configuration generation for region-specific applications.
Eliminate manual copying of cloud resource information.
Demonstrate integration between Terraform outputs and Ansible templating.
Business Scenario

Global applications often deploy resources close to users to reduce latency and improve performance.

For example:

Applications running in the United States should use US-based storage resources.
Applications running in Europe should use EU-based storage resources.

Since cloud resources generate unique identifiers (ARNs) at deployment time, manually updating application configuration files is inefficient and error-prone. This project automates that entire process.

Workflow Overview
1. Provision Multi-Region Infrastructure (Terraform)

Terraform creates two S3 buckets in different regions:

US Storage Bucket
global-app-us-data
Created using the default AWS provider.
Represents storage infrastructure for US applications.
EU Storage Bucket
global-app-eu-data
Created using the aliased provider:
provider = aws.europe
Represents storage infrastructure for European applications.
2. Export Infrastructure Metadata

After provisioning the buckets, Terraform extracts their ARNs and generates a JSON file:

outputs.json

Example structure:

{
  "us_bucket_arn": "arn:aws:s3:::global-app-us-data",
  "eu_bucket_arn": "arn:aws:s3:::global-app-eu-data"
}

This file acts as the bridge between Terraform and Ansible.

3. Load Infrastructure Outputs (Ansible)

Ansible reads the generated JSON file using:

ansible.builtin.include_vars

The contents are loaded into a variable namespace:

tf.us_bucket_arn
tf.eu_bucket_arn

This allows infrastructure information to be consumed dynamically.

4. Generate Region-Specific Configurations

Using a Jinja2 template, Ansible creates two application configuration files.

US Configuration
config/us-app.conf

Example:

[Storage]
Region=US-East
BucketARN=arn:aws:s3:::global-app-us-data
EU Configuration
config/eu-app.conf

Example:

[Storage]
Region=EU-West
BucketARN=arn:aws:s3:::global-app-eu-data

Each application receives the correct storage endpoint automatically.

Technologies Used
Terraform
Infrastructure as Code (IaC)
Multi-region resource provisioning
Provider aliases
Resource output generation
JSON data export
Ansible
Configuration management
Variable injection
JSON data consumption
Jinja2 templating
AWS S3 (Moto Emulator)
Object storage simulation
Multi-region deployment testing
Safe local cloud environment
DevOps Concepts Demonstrated
Infrastructure as Code (IaC)
Multi-Region Deployments
Cross-Tool Integration
Configuration Management
Dynamic Templating
Cloud Resource Discovery
Terraform Outputs
Ansible Variable Injection
Environment-Specific Configuration
Automated Deployment Pipelines
Expected Outcome

After executing the workflow:

Terraform creates S3 buckets in US and EU regions.
Bucket ARNs are exported to outputs.json.
Ansible reads the exported data automatically.
Region-specific application configuration files are generated.
Applications receive the correct storage resource information without manual intervention.
Business Value

This project models an enterprise-grade deployment pattern where cloud infrastructure and application configurations are tightly integrated. By automatically exporting infrastructure metadata and injecting it into application configuration files, organizations can deploy globally distributed applications faster, reduce configuration errors, and maintain consistency across regions. The result is a scalable, automated, and production-ready DevOps workflow.
