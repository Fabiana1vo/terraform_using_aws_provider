# 📚 Estudo Terraform com Provider AWS

Repositório dedicado ao meu aprendizado sobre **Terraform**, focado no uso de **providers AWS** para provisionamento de infraestrutura como código (IaC).

---

## 📖 Sobre

Este repositório contém anotações, exemplos de código e materiais de estudo relacionados ao **Terraform**, utilizando **AWS como provider**. A ideia é organizar o aprendizado de forma prática, com códigos testáveis e anotações para consulta futura.

---

## 🎯 Objetivos

- [ ] Entender os conceitos principais de **Terraform**
- [ ] Compreender o funcionamento de providers, com foco em **AWS**
- [ ] Realizar exemplos práticos de provisionamento de recursos na AWS
- [ ] Documentar dúvidas, boas práticas e aprendizados
- [ ] Criar um projeto final para validar os conhecimentos adquiridos

---


## 🛠️ Tecnologias e Ferramentas

- **Terraform** — versão 1.8.0
- **AWS CLI** — versão 2.x
- **Visual Studio Code** — com extensões Terraform
- **Outros recursos utilizados:** AWS Free Tier

---

## 📌 Anotações Importantes

> 📝 Links e materiais úteis para estudo e consulta.

- [Documentação Oficial do Terraform](https://developer.hashicorp.com/terraform/docs)
- [Documentação do Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Cheatsheet Terraform](https://github.com/antonbabenko/terraform-best-practices)

---

## 🚀 Como Executar

Para testar os exemplos de código:

```bash
# Inicializar o diretório do Terraform
terraform init

# Validar os arquivos .tf
terraform validate

# Visualizar o plano de execução
terraform plan

# Aplicar a infraestrutura
terraform apply

# Destruir a infraestrutura provisionada
terraform destroy
