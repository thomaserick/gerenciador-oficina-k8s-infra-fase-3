# 🌐 Infraestrutura Kubernetes + EKS com Terraform - Fase 3

[![Terraform](https://img.shields.io/badge/Terraform-Infrastructure_as_Code-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EKS-green?logo=amazon-aws)](https://aws.amazon.com/s3/)
[![AWS](https://img.shields.io/badge/AWS-S3-orange?logo=amazon-aws)](https://aws.amazon.com/s3/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-Automation-black?logo=githubactions)](https://github.com/thomaserick/gerenciador-oficina-core-fase-2/actions/workflows/pipeline.yml)

## 📋 Índice

- [Descrição do Propósito](#-descrição-do-propósito)
- [Tecnologias](#-tecnologias)
- [Visão Geral da Arquitetura](#-visão-geral-da-arquitetura)
- [Passos para Execução e Deploy](#-passos-para-execução-e-deploy)
- [Pipeline Automatizado (GitHub Actions)](#-pipeline-automatizado-github-actions)
- [Repositórios Relacionados — Fase 3](#-repositórios-relacionados--fase-3)

## 🧩 Descrição do Propósito

Este repositório tem como objetivo provisionar e gerenciar a infraestrutura Kubernetes (EKS) na AWS utilizando Terraform
de forma modular e reutilizável.
A estrutura foi desenhada para ambientes escaláveis, seguros e de fácil manutenção, garantindo boas práticas de IaC (
Infraestrutura como Código) e permitindo o deploy automatizado do cluster, redes e permissões.

O projeto é responsável pela criação de:

- **Cluster EKS** para execução de workloads Kubernetes;
- **VPC** dedicada com subnets públicas e privadas;
- **Node Groups** para execução de pods e workloads;
- **Acesso IAM** controlado via módulo eks-access-entry;
- **Bucket S3** para armazenamento de artefatos, logs ou state remoto.

---

## 🛠️ Tecnologias

- **Terraform** - Gerenciador de Infraestrutura IaC AWS (VPC, Subnets, IAM Roles, EKS, Node Group)
- **AWS** - Provedor de infraestrutura
- **AWS S3 + DynamoDB** - Armazena o `terraform.tfstate` e gerencia *locks*
- **AWS EKS** - Cluster Kubernetes gerenciado pela AWS
- **AWS VPC** - Define rede, subnets e rotas privadas/públicas para o cluster.
- **AWS IAM** - Controle de acesso e permissões seguras.
- **Kubernetes** - Orquestrador de containers
- **GitHub Actions** - Automação CI/CD
- **GitHub** - Controle de versão

---

## 🏗️ Visão Geral da Arquitetura

![Arquitetura EKS Terraform](docs/assets/diagrama.png)

### 📁 Estrutura

```plaintext
infra-eks/
├── modules/          
│   ├── s3/                 # Criação de Bucket no S3
│   ├── vpc/                # Criação da VPC, subnets e rotas
│   ├── eks/                # Configuração do cluster EKS
│   ├── eks-access-entry    # Configuração do acesso ao EKS via IAM
│   └── eks-node            # Criação do Node Group para o EKS
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
- Alterar as variáveis no arquivo `variables.tf` conforme necessário.
    - Importante: ajustar `user_name` para o usuário IAM que terá acesso ao cluster EKS.
- Criar um bucket S3 para o backend remoto do Terraform e alterar o arquivo `backend.tf` com
  os nomes corretos ou remover o `backend.tf` para usar o backend local.

---

### 🧠 2. Configuração local

```bash

cd infra-eks
terraform init
terraform plan
terraform apply
```

Isso criará automaticamente:

- S3 Bucket para armazenar o estado do Terraform
- A VPC com subnets públicas
- O Cluster EKS
- O Node Group (t3.small) com Auto Scaling
- As IAM Roles necessárias

### 3. Configurar acesso ao cluster

Após o terraform apply, execute:

```bash
aws eks update-kubeconfig --region us-east-1 --name gerenciador-oficina-core
kubectl get nodes
```

Você deve ver os nós com o status Ready.

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

A arquitetura do **Gerenciador de Oficina — Fase 3** é composta por múltiplos módulos independentes, cada um versionado
em um repositório separado para facilitar a manutenção e o CI/CD.

| Módulo                           | Descrição                                                                                               | Repositório                                                                                                 |
|:---------------------------------|:--------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------|
| 🧱 **Core Application**          | Aplicação principal responsável pelas regras de negócio, APIs REST e integração com os demais módulos.  | [gerenciador-oficina-core-fase-3](https://github.com/thomaserick/gerenciador-oficina-core-fase-3)           |
| ⚡ **Lambda Functions**           | Conjunto de funções *serverless* para processamento assíncrono, notificações e automações event-driven. | [gerenciador-oficina-lambda-fase-3](https://github.com/thomaserick/gerenciador-oficina-lambda-fase-3)       |
| ☸️ **Kubernetes Infrastructure** | Infraestrutura da aplicação no Kubernetes, incluindo manifests, deployments, ingress e autoscaling.     | [gerenciador-oficina-k8s-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-k8s-infra-fase-3) |
| 🗄️ **Database Infrastructure**  | Infraestrutura do banco de dados gerenciado (RDS PostgreSQL), versionada e automatizada via Terraform.  | [gerenciador-oficina-db-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-db-infra-fase-3)   |

> 🔍 Cada repositório é autônomo, mas integra-se ao **Core** por meio de pipelines e configurações declarativas (
> Terraform e CI/CD).


