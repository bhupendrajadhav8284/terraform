locals {
    common_tags = {
        Team = "security_team"
        creation_date = formatdate("DD MM YYYY",timestamp())
    }
}
resource "aws_security_group" "sg" {
    name = "secgrp-${count.index + 1}"
    count = 2
    tags = merge(local.common_tags) 
        
   
}   

# resource "aws_security_group" "sg2" {
#     name = "secgrp2"

#     tags = {
        
#         Team = var.common_tag["Team"]
        
#     }
# }