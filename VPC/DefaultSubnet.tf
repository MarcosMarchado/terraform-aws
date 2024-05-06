# São cinco IPs reservados por padrão: os quatro primeiros e o último.

# Por exemplo, em uma rede com o CIDR 10.0.0.0/24, teremos os seguintes IPs reservados:

# 10.0.0.0: Endereço da rede
# 10.0.0.1: Reservado para o roteador VPC
# 10.0.0.2: Reservado para o servidor de DNS
# 10.0.0.3: Reservado para uso futuro
# 10.0.0.255: Endereço de broadcast da rede. A AWS não suporta broadcasting em uma VPC, por isso o endereço é reservado

resource "aws_default_subnet" "default_us-east-1b" {
  availability_zone = "us-east-1b"

  tags = {
    Name = "Default subnet for us-east-1b"
  }
}

resource "aws_default_subnet" "default_us-east-1c" {
  availability_zone = "us-east-1c"

  tags = {
    Name = "Default subnet for us-east-1c"
  }
}