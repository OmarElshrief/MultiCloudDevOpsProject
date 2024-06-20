#         Provider 
region = "us-east-1"

#         Vpc         
cidr-block = "10.0.0.0/16"
vpc-tag = "Project"

#         Subnet 
sub = {
  "public-subnet" = {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    name              = "public-Sub"
  }
}

#    Security Group   
cidr-SG = ["0.0.0.0/0"]



#   Internet Gateway  
internet-gateway = "Project-IGW"


#     Route Table    
cidr-rt    = "0.0.0.0/0"
tag_public = "public RT"


#         EC2         
type-ec2 = "t2.large"
key-pair = "Terr-Aws"



#     CloudWatch      
email = "omarmagdy045@gmail.com"
time  = "300" # it's 300 sec = 5 mins



#      S3 Bucket   
name_bucket   = "omar-bt"
region_bucket = "us-east-1"





