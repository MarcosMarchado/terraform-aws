resource "aws_security_group" "launch-template-sg" {
  name        = "launch-template-sg"
  description = "Permite a conexao de saida somente"
  vpc_id      = "vpc-095ef5fef694db460"

  tags = {
    Name = "SG para saida"
  }
}

resource "aws_security_group_rule" "lb_to_ec2_ingress" {
  #cidr_blocks      =  "0.0.0.0/0" -- (Opcional) Lista de blocos CIDR. Não pode ser especificado com ou .source_security_group_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = aws_security_group.launch-template-sg.id
  #Permite definir a origem do acesso
  source_security_group_id = aws_security_group.ec2-load-balancer-sg.id 
}

### Testando
resource "aws_security_group_rule" "lb_to_ec2_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = aws_security_group.launch-template-sg.id
  #Permite definir a origem/destino do acesso
  #Na linha 30 estou falando que toda saída será para o security group do load balancer
  source_security_group_id = aws_security_group.ec2-load-balancer-sg.id 
}

# resource "aws_vpc_security_group_egress_rule" "egress-rule-launch-template" {
#   security_group_id = aws_security_group.launch-template-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
#   description       = "Regras de saida para o launch template EC2"
# }

# resource "aws_vpc_security_group_ingress_rule" "WEB-ingress-rule-launch-template" {
#   security_group_id = aws_security_group.launch-template-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "TCP"
#   to_port           = 80
#   description       = "Conexao WEB entrada"
#   #Permite que essa regra só seja acessada pela o source de referencia
#   referenced_security_group_id = aws_security_group.ec2-load-balancer-sg.id 
# }

