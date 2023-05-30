variable "aws_user" {
    type = string
    default = "hamza"
    description = "user to user access keys for.. user must be saved in credentials file"
}

variable "aws_region" {
    type = string
    default = "us-east-2"
    description = "region to deploy resources to"
}

variable "credentials_file_path" {
    type= string
    default = "C:\\Users\\Asus\\.aws\\credentials"
    description = "file path containing access keys"
}

variable "web_server_ami" {
    type = string
    default = "ami-008dc7c58d3db0798"
    description = "ami to use for the web server ec2 machines"
}

variable "subscriber_emails" {
  type    = list(string)
  default = ["hamzausmani021@gmail.com"]
  description = "people whom email will be sent to "
}

variable "subscriber_mobile" {
    type=   list(string)
    default =   ["+923322411710"]
    description = "contacts who will receive message"
}
variable "db_engine" {
    type= string
    default = "mysql"
    description = "sql flavor to be used"
}
variable "identifier" {
    type= string
    default = "myrdsinstance"
    description = "identifier for the created database"
}

variable "db_instance_type" {
    type= string
    default = "db.t2.micro"
    description = "instance type e.g db.t2.micro"

}
variable "db_username" {
    type= string
    default = "user"
    description = "username for the database"
}
variable "db_password" {
    type = string
    default = "password"
    description = "password for the database"
}

