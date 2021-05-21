resource "aws_security_group" "security_group" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
  tags = merge(
          var.default_tags,
          {
              name = format("%s", var.sg_name)
          }
  )
}

#for CIDR
resource "aws_security_group_rule" "ingress_rules_withCIDR" {
  count = length(var.sg_ingress_rules_cidr)

  type              = "ingress"
  from_port         = split(",", var.sg_ingress_rules_cidr[count.index])[0]
  to_port           = split(",", var.sg_ingress_rules_cidr[count.index])[1]
  protocol          = split(",", var.sg_ingress_rules_cidr[count.index])[2]
  security_group_id = aws_security_group.security_group.id
  cidr_blocks = [split(",", var.sg_ingress_rules_cidr[count.index])[3]]
  description = split(",", var.sg_ingress_rules_cidr[count.index])[4]
}
resource "aws_security_group_rule" "egress_rules_withCIDR" {
  count = length(var.sg_egress_rules_cidr)

  type              = "egress"
  from_port         = split(",", var.sg_egress_rules_cidr[count.index])[0]
  to_port           = split(",", var.sg_egress_rules_cidr[count.index])[1]
  protocol          = split(",", var.sg_egress_rules_cidr[count.index])[2]
  security_group_id = aws_security_group.security_group.id
  cidr_blocks = [split(",", var.sg_egress_rules_cidr[count.index])[3]]
  description = split(",", var.sg_egress_rules_cidr[count.index])[4]
}

#for security group ID
resource "aws_security_group_rule" "ingress_rules_withSGID" {
  count = length(var.sg_ingress_rules_sgid)

  type                      = "ingress"
  from_port                 = split(",", var.sg_ingress_rules_sgid[count.index])[0]
  to_port                   = split(",", var.sg_ingress_rules_sgid[count.index])[1]
  protocol                  = split(",", var.sg_ingress_rules_sgid[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  source_security_group_id  = split(",", var.sg_ingress_rules_sgid[count.index])[3]
  description               = split(",", var.sg_ingress_rules_sgid[count.index])[4]

}

resource "aws_security_group_rule" "egress_rules_withSGID" {
  count = length(var.sg_egress_rules_sgid)

  type                      = "egress"
  from_port                 = split(",", var.sg_egress_rules_sgid[count.index])[0]
  to_port                   = split(",", var.sg_egress_rules_sgid[count.index])[1]
  protocol                  = split(",", var.sg_egress_rules_sgid[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  source_security_group_id  = split(",", var.sg_egress_rules_sgid[count.index])[3]
  description               = split(",", var.sg_egress_rules_sgid[count.index])[4]
}

#for security group with prefix ids
resource "aws_security_group_rule" "ingress_rules_withprefixid" {
  count = length(var.sg_ingress_rules_prefixid)

  type                      = "ingress"
  from_port                 = split(",", var.sg_ingress_rules_prefixid[count.index])[0]
  to_port                   = split(",", var.sg_ingress_rules_prefixid[count.index])[1]
  protocol                  = split(",", var.sg_ingress_rules_prefixid[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  prefix_list_ids           = [split(",", var.sg_ingress_rules_prefixid[count.index])[3]]
  description               = split(",", var.sg_ingress_rules_prefixid[count.index])[4]

}

resource "aws_security_group_rule" "egress_rules_withprefixid" {
  count = length(var.sg_egress_rules_prefixid)

  type              = "egress"
  from_port                 = split(",", var.sg_egress_rules_prefixid[count.index])[0]
  to_port                   = split(",", var.sg_egress_rules_prefixid[count.index])[1]
  protocol                  = split(",", var.sg_egress_rules_prefixid[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  prefix_list_ids           = [split(",", var.sg_egress_rules_prefixid[count.index])[3]]
  description               = split(",", var.sg_egress_rules_prefixid[count.index])[4]
}

#for self attached
resource "aws_security_group_rule" "ingress_rules_withSelf" {
  count = length(var.sg_ingress_rules_self)

  type                      = "ingress"
  from_port                 = split(",", var.sg_ingress_rules_self[count.index])[0]
  to_port                   = split(",", var.sg_ingress_rules_self[count.index])[1]
  protocol                  = split(",", var.sg_ingress_rules_self[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  self                      = split(",", var.sg_ingress_rules_self[count.index])[3]
  description               = split(",", var.sg_ingress_rules_self[count.index])[4]

}

resource "aws_security_group_rule" "egress_rules_withSelf" {
  count = length(var.sg_egress_rules_self)

  type                      = "egress"
  from_port                 = split(",", var.sg_egress_rules_self[count.index])[0]
  to_port                   = split(",", var.sg_egress_rules_self[count.index])[1]
  protocol                  = split(",", var.sg_egress_rules_self[count.index])[2]
  security_group_id         = aws_security_group.security_group.id
  self                      = split(",", var.sg_egress_rules_self[count.index])[3]
  description               = split(",", var.sg_egress_rules_self[count.index])[4]
}