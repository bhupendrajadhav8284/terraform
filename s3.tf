# resource "aws_s3_bucket" "example" {
#   bucket = "test.bhupendra.com"

# #   tags = {
# #     Name        = "My bucket"
# #     Environment = "Dev"
# #   }
# }


resource "aws_s3_bucket" "example1" {
    bucket = "terraform-20260113172307206500000010"


    tags = {
        Name = "bhupendra1"
    }

    
}

resource "aws_s3_bucket" "example2" {
    bucket = "terraform-20260113172307206500000020"


    tags = {
        Name = "bhupendra2"
    }
    
    
    
}   