# 🌐  Infraestrutura Kubernetes + EKS com Terraform - Fase 3
[![Terraform](https://img.shields.io/badge/Terraform-Infrastructure_as_Code-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EKS-green?logo=amazon-aws)](https://aws.amazon.com/s3/)
[![AWS](https://img.shields.io/badge/AWS-S3-orange?logo=amazon-aws)](https://aws.amazon.com/s3/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-Automation-black?logo=githubactions)](https://github.com/thomaserick/gerenciador-oficina-core-fase-2/actions/workflows/pipeline.yml)

Este repositório tem como objetivo **provisionar a infraestrutura de cluster EKS** na AWS, 
utilizando **Terraform** e pipelines automatizados via **GitHub Actions**.

## 📋 Índice

- [Descrição do Propósito](#-descrição-do-propósito)
- [Tecnologias](#️-tecnologias)- 
- [Visão Geral da Arquitetura](#️-visão-geral-da-arquitetura)
- [Passos para Execução e Deploy](#-passos-para-execução-e-deploy)
- [Pipeline Automatizado (GitHub Actions)](#️-pipeline-automatizado-github-actions)
- [Repositórios Relacionados — Fase 3](#--repositórios-relacionados--fase-3)


## 🧩 Descrição do Propósito


---

## 🛠️ Tecnologias 

- **Terraform** - Gerenciador de Infraestrutura IaC
- **AWS** - Provedor de infraestrutura
- **AWS S3 + DynamoDB** - Armazena o `terraform.tfstate` e gerencia *locks*
- **GitHub Actions** - Automação CI/CD
- **GitHub** - Controle de versão
---

## 🏗️ Visão Geral da Arquitetura


### 📁 Estrutura

```plaintext
infra-rds-postgress/
├── modules/          
│   ├── s3/                 # Criação de Bucket no S3
│   ├── vpc/                # Criação da VPC, subnets e rotas
│   ├── eks/                # Configuração do cluster EKS
│   └── eks-iam-roles/      # Criação de roles e polices para o EKS
├── main.tf                 # Arquivo principal que integra os módulos para o ambiente de produção
├── variables.tf            # variáveis principais
├── outputs.tf              # outputs (endpoint, etc.)
├── backend.tf              # configuração do backend remoto
```
---

## 🚀 Passos para Execução e Deploy

### 🔧 1. Pré-requisitos
- Terraform instalado 
- Conta AWS com permissões para criar recursos EKS,EC2, S3, VPC.
- Terraform ≥ **v1.13.0**
- GitHub Actions configurado com os secrets:
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
- Criar um bucket S3 para o backend remoto do Terraform e alterar o arquivo `backend.tf` com 
os nomes corretos ou remover o `backend.tf` para usar o backend local.

---

### 🧠 2. Configuração local

```bash

cd infra-rds-postgres
terraform init
terraform plan
terraform apply
```

## ⚙️ Pipeline Automatizado (GitHub Actions)

🚀 terraform.yml
- Executa após o merge na branch main.
    - terraform init
    - terraform validate
    - terraform plan -input=false -out=tfplan
    - terraform apply -auto-approve tfplan

💣 terraform-destroy.yml
- Pode ser rodado manualmente via workflow_dispatch.
- Executa terraform destroy com confirmação automática.

---

## 🔗 Repositórios Relacionados — Fase 3

A arquitetura do **Gerenciador de Oficina — Fase 3** é composta por múltiplos módulos independentes, cada um versionado em um repositório separado para facilitar a manutenção e o CI/CD.

| Módulo | Descrição | Repositório                                                                                                             |
|:-------|:-----------|:------------------------------------------------------------------------------------------------------------------------|
| 🧱 **Core Application** | Aplicação principal responsável pelas regras de negócio, APIs REST e integração com os demais módulos. | [gerenciador-oficina-core-fase-3](https://github.com/thomaserick/gerenciador-oficina-core-fase-3)                       |
| ⚡ **Lambda Functions** | Conjunto de funções *serverless* para processamento assíncrono, notificações e automações event-driven. | [gerenciador-oficina-lambda-fase-3](https://github.com/thomaserick/gerenciador-oficina-lambda-fase-3)       |
| ☸️ **Kubernetes Infrastructure** | Infraestrutura da aplicação no Kubernetes, incluindo manifests, deployments, ingress e autoscaling. | [gerenciador-oficina-k8s-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-k8s-infra-fase-3) |
| 🗄️ **Database Infrastructure** | Infraestrutura do banco de dados gerenciado (RDS PostgreSQL), versionada e automatizada via Terraform. | [gerenciador-oficina-db-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-db-infra-fase-3)  |

> 🔍 Cada repositório é autônomo, mas integra-se ao **Core** por meio de pipelines e configurações declarativas (Terraform e CI/CD).


