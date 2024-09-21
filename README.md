# bmb.database

[![Terraform build](https://github.com/soat-fiap/bmb.database/actions/workflows/terraform.yaml/badge.svg?branch=main)](https://github.com/soat-fiap/bmb.database/actions/workflows/terraform.yaml)

## Project Overview

This project contains the database schema and related files for the BMB application. The schema is defined using SQL scripts and managed with Terraform.

## Folder Structure

```
/bmb.database/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── scripts/
    ├── create_tables.sql
    ├── insert_data.sql
    └── update_schema.sql
```

## Dependencies
- [VPC](https://github.com/soat-fiap/bmb.infra)

## Getting Started

To get started with this project, ensure you have Terraform installed. Then, initialize and apply the Terraform configuration:

```sh
terraform init
terraform apply
```


## ERD

```mermaid
 erDiagram
    Customers {
        char(36) Id
        varchar(11) Cpf
        varchar(100) Name
        varchar(100) Email
    }
    
    Products {
        char(36) Id
        varchar(100) Name
        varchar(200) Description
        int Category
        decimal(10) Price
        varchar(1000) Images
    }
    
   Orders {
        char(36) Id
        char(36) CustomerId
        char(36) PaymentId
        int Status
        datetime Created
        datetime Updated
        varchar(7) TrackingCode
    }
    
    OrderItems {
        char(36) OrderId
        char(36) ProductId
        varchar(200) ProductName
        decimal UnitPrice
        int Quantity
    }
    
    Payments {
        char(36) Id
        char(36) OrderId
        int Status
        datetime Created
        datetime Updated
        int PaymentType
        varchar(36) ExternalReference
        decimal(10) Amount
    }
    
    Customers ||--o{ Orders : "has"
    Orders ||--|{ OrderItems : "contains"
    Products ||--o{ OrderItems : "included in"
    Orders ||--o| Payments : "paid with"
```

## This repo on the infrastructure

![Architecture Diagram](aws-infra-phase-3.png)