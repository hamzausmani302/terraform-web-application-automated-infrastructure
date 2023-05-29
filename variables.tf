variable "web_server_ami" {
    type = string
    default = "ami-07c433cc0a3274562"
}

variable "subscriber_emails" {
  type    = list(string)
  default = ["hamzausmani021@gmail.com"]
}

variable "subscriber_mobile" {
    type=   list(string)
    default =   ["+923322411710"]
}
