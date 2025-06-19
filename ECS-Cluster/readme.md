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
        subgraph Requisição do Cliente
            A[Navegador do Usuário] --> B[Internet]
            B --> C[Internet Gateway (IGW)]
            C --> D[Subnet Pública (rota 0.0.0.0/0)]
            D --> E[ALB/NLB]
        end

        subgraph Distribuição para ECS
            E --> F[Target Group]
            F --> G[Tarefas ECS (em subnets públicas ou privadas)]
        end

    %% Comentários de apoio
    classDef comment fill=#fff,stroke=none,font-size:12px,color=#666;
    X1["IGW = ponto de entrada/saída para tráfego público"]:::comment
    X2["Subnet precisa da rota 0.0.0.0/0 → IGW"]:::comment
    X3["ALB usa o Target Group, não a tabela de rotas"]:::comment

    X1 -.-> C
    X2 -.-> D
    X3 -.-> F
```

## 🔍 Por Que Usamos o DNS do Load Balancer?
### Abstração de Infraestrutura

O IGW só sabe entregar tráfego para IPs públicos das subnets, mas não para serviços específicos.

O ALB/NLB esconde a complexidade: seu DNS aponta para IPs rotacionados (por trás dele estão as subnets com rotas para o IGW).

### Escalabilidade e Alta Disponibilidade

O DNS do ALB/NLB balanceia automaticamente entre múltiplas subnets públicas (ex: us-east-1a, us-east-1b), enquanto o IGW só enxerga subnets individuais.

### Gerenciamento de Ciclo de Vida

Se você substituir instâncias/containers, o DNS do ALB permanece o mesmo, enquanto os IPs internos mudam.
```mermaid
flowchart LR
    A[Usuário] -- "meu-alb-1234.elb.amazonaws.com" --> B[DNS → IPs Públicos do ALB]
    B --> C[IGW]
    C --> D[Tabela de Rotas da Subnet]
    D --> E[ALB]
    E --> F[ECS]