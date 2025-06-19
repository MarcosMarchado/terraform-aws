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
flowchart TD
    %% Requisição do Cliente
    A[Navegador do Usuário]
    B[Internet]
    C[Internet Gateway]
    D[Subnet Pública - rota 0.0.0.0/0]
    E[ALB / NLB]

    %% Distribuição para ECS
    F[Target Group]
    G[Tarefas ECS - subnets públicas ou privadas]

    %% Fluxo principal
    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G

    %% Anotações (sem estilização especial)
    C_note["IGW: ponto de entrada/saída para tráfego público"]
    D_note["Subnet precisa da rota 0.0.0.0/0 → IGW"]
    F_note["ALB usa o Target Group, não a tabela de rotas"]

    C_note --- C
    D_note --- D
    F_note --- F

```