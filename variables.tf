variable "subnet_configs" {
  type = list(object({
    name           = string
    cidr_block     = string
    availability_zone = string
  }))

  default = [
    {
      name           = "Web"
      cidr_block     = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    },
    {
      name           = "App"
      cidr_block     = "10.0.2.0/24"
      availability_zone = "us-east-1a"
    },
    {
      name           = "DataBase"
      cidr_block     = "10.0.3.0/24"
      availability_zone = "us-east-1a"
    }
  ]
}
