### Requisição do Cliente
`Usuário (navegador) → Internet → Internet Gateway (IGW) → Subnet pública (rota 0.0.0.0/0) → ALB/NLB`

>O IGW é o único ponto de entrada/saída para tráfego público em uma VPC (AWS Docs).

### Roteamento para o ALB/NLB
`Internet Gateway (IGW) → Subnet pública (rota 0.0.0.0/0) → ALB/NLB`

>A tabela de rotas da subnet precisa conter a rota 0.0.0.0/0 → igw para permitir que o ALB receba tráfego externo. (Fonte: AWS Docs)

### Distribuição para ECS
`ALB/NLB → Target Group → Tarefas ECS (em subnets públicas ou privadas)`

>O ALB utiliza o registro no Target Group (não a tabela de rotas) para encaminhar requisições às tarefas ECS. (Fonte: AWS ECS Docs)


## Esquema

```mermaid
---
config:
  theme: neo
---
flowchart TD
    A["Navegador do Usuário"] --> B["Internet"]
    B --> C["Internet Gateway"]
    C --> D["Subnet Pública - rota 0.0.0.0/0"]
    D --> E["ALB / NLB"]
    E --> F["Target Group"]
    F --> G["Tarefas ECS - subnets públicas ou privadas"]
    C_note["IGW: ponto de entrada/saída para tráfego público"] --- C
    D_note["Subnet precisa da rota 0.0.0.0/0 → IGW"] --- D
    F_note["ALB usa o Target Group, não a tabela de rotas"] --- F
     C_note:::Rose
     C_note:::Peach
     D_note:::Rose
     D_note:::Peach
     F_note:::Peach
    classDef Rose stroke-width:1px, stroke-dasharray:none, stroke:#FF5978, fill:#FFDFE5, color:#8E2236
    classDef Peach stroke-width:1px, stroke-dasharray:none, stroke:#FBB35A, fill:#FFEFDB, color:#8F632D
```