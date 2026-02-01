variable "vpc_cidr" {
    description = "cidr block for vpc"
    default = "10.0.0.0/16"
    
}

variable "pubsub1_cidr" {
  default = "10.0.1.0/24"

}

variable "privatesub1_cidr" {
    default = "10.0.2.0/24"
  
}