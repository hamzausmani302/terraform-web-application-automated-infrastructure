# terraform-web-application-automated-infrastructure
An automation project for provisioning the given infrastructure for AWS.

![image](https://github.com/hamzausmani302/terraform-web-application-automated-infrastructure/assets/37268659/9f828d8c-2745-4270-a2b8-d08b9cda3a7b)


## Goal was to implement an infrastructure which provides security and high availability as well as fault tolerance.
  1. Bastion server privides the single point access to application server instances
  2. Auto scaling is set up to provide fault tolerance and ELB to provide high availabiility.
  3. Security groups are configured seperately on each componennt.
 
 
 
 ## Files
 
 provider.tf   -  specifies regions and availlability zones
 main.tf    -     specifies vpc, subnets and route tables
 instances.tf    -   al work related to auto-scaing and instances 
 security-groups.tf     -   all security groups and present here
 db.tf    -    creation of database and db subnet group
 elb.tf    -   resources related to elastic load balancer
 nat-gateway   -   resources related to nat gateway
 sns.tf     -   all work related to notifications
 variables.tf   -   all user variables
 outputs.tf     -   looging resource outptus
 
 
 
 ## How to run
 
 Setup access keys in ~/.ssh creadentials file
 
 ```bash
  terraform plan
  terraform apply
```
