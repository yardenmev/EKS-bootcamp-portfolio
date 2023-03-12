# Goals
- Retouch on all of the material.
- Boost professional self-confidence.
- Practice organized [git] work and time management and estimation of a large project with multiple tasks.


# Overview
The portfolio project should contain/demonstrate several aspects:
- Non-trivial CI/CD (i.e. with branches, logic, etc.).
- Public cloud based infrastructure.
- Microservice based deployment/architecture.
- GitOps.
- Logging & monitoring.


# Technology stack
- Containerization: Docker
- Docker image registry: ECR
- Source Code Management: GitLab, GitHub, Bitbucket, CodeBerg
- DataBase: MongoDB
- Scripting: Bash
- Infrastructure as Code - Terraform:
  - Cloud provider
  - Kubernetes provider (for Helm)
  - Helm provider (for Argo CD)
- Cloud - AWS:
  - Network (VPC, subnets)
  - ECR
  - Kubernetes (EKS)
- Kubernetes: AWS EKS
- Kubernetes package manager: Helm
- Ingress: Nginx ingress controller
- CI/CD: Jenkins
- GitOps: Argo CD
- Logging: EFK stack
- Monitoring: Prometheus and Grafana
- _(bonus)_ DNS & TLS: AWS Route 53 & AWS Certificate manager (in AWS) or Cert-manager (in Kubernetes)


---


# DevOps Portfolio details

## Git
Implement all work in *private* git repositories. Use a separate git repository for each of the following:
- [x] Application source (including Dockerfile & Jenkinsfile).
- [x] Infrastructure (Terraform).
- [x] GitOps manifests (YAML) and application Helm chart.

Branching (in application repository):
- `main` branch is for running releases.
- `feature/*` branches are for development.


## Development
source code for a To-do list application will be supplied to you in the accompanied zip file.


## Docker
- [X] Write a `Dockerfile` for building the application image.
- [X] Write a `docker-compose.yaml` file for running the application locally and for tests in CI (more below).


## Documentation
You should add a `README.md` for each of your repos (and update it as you proceed). This is a best practice and will also help when re-visiting and presenting.


## Cloud Infrastructure
- Provision the following cloud infrastructure using offical AWS Terraform modules:
  - [X] Private ECR repository for your application's Docker images.
  - [X] VPC with high availability (at least 3 [public] subnets, each in their own AZ).
  - [X] Kubernetes (EKS) cluster, composed of 3 `t3a.large` nodes, spanning all subnets in the VPC.
- [X] Configure S3 as a remote backend for your Terraform `.tfstate`.
- Use a Helm [Terraform] provider to create the initial Helm release of Argo CD via Terraform.
- Use variables for _your_ Terraform code (pass them to modules' input).


## CI/CD
Implement CI for the application using a multibranch pipeline and publish to image registry (ECR).

Stages:
1. [for `main` branch] Calculate and increment [minor] version number for Docker image tag and git tag. Use a Groovy or Bash script that fetches/lists the existing git tags, find the most advanced one, and stores the incremented value for use in following stages. Initially (when setting up git repo) manually push the tag `v1.0`.
2. [for any branch] Build Docker image - Docker tag should be version if on `main` branch and short Git commit hash if on other branches. Example image names: `todo:1.23`, `todo:b1e9a80`.
3. [for any branch] Test (`docker-compose up`, `curl ...`, `docker-compose down`) - write one test for each of the `/api*` routes (total of 4 cases). Remember to cleanup (and careful not to kill Jenkins container or your colleagues' containers!).
4. [for `main` branch] Git tag - Git tag with version (calculated in first stage), then push *tags* to the remote repository.
5. [for any branch] Publish - Push the newly built image to your image registry (`docker login ...`, `docker push ...`).
6. [for `main` branch] Deploy - Pull GitOps configuration repo, update image tag in `values.yaml`, then push for Argo CD to handle.
7. _(bonus)_ [for any branch] Report - send a report via e-mail or slack about the pipeline's result.


## Helm
- Write a Helm chart for the application.
- Allow all application configuration to be done via the chart's `values.yaml`.
- Include toggles for Ingress and ServiceMonitor resources in the `values.yaml`.
- Store it in the application repository, with "sane" default values (e.g. `service.type=ClusterIP`, `ingress.enabled=false`).
- _(bonus)_ Write an umbrella (parent) chart for both the application and database (dependencies).


## GitOps
- Implement GitOps based CD to the Kubernetes cluster.
- Provision/deploy all infrastructure cluster services using [Argo] Application resources:
  - Ingress controller.
  - EFK stack (logging).
  - Prometheus stack (monitoring).
  - _(bonus)_ Cert-manager (for TLS).


## Observability
- Deploy an EFK (logging) stack using Argo CD.
- Deploy a Prometheus stack (monitoring) stack using Argo CD.
- Create a Kibana dashboard displaying useful log insights from the application.
- Create a Grafana dashboard displaying useful metric insights from the application, cluster nodes and Ingress.


## Architecture
Draw two architecture diagrams of the cloud infrastructure and of the application & microservices within the Kubernetes cluster and their interaction with the CI/CD system.

Components to include in:
1. Diagram A: Cloud infrastructure:
   - [x] VPC.
   - [x] Subnets.
   - [x] EKS cluster and nodes.
   - [x] ECR.
2. Diagram B: Application and CI/CD interaction:
   - Developer machine.
   - SCM (git repositories).
   - CI server.
   - Docker image registry.
   - Kubernetes cluster.
   - GitOps server.
   - Application microservices (app & DB).


---


# Tips
- **Do NOT** proceed to bonuses unless you've completed *all* other tasks first.
- Work in an organized manner (commit messages etc.).
- Document your work as you proceed - make `README.md` files for each repo. These should also serve you when presenting in the exam/interview!
- Follow documentation & best practices.
- Drawing your architecture and design is very useful for thinking things through.
- Raise flags early, ask questions, request design reviews from your peers, mentors, helpers and instructor(s).
- Before presenting (in interview) make sure your services are up and running and the source code/configuration is clean and available to reference.