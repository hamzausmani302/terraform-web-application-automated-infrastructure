resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [
    aws_autoscaling_group.scaling_group.name
  ]
    
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.autoscaling_notifications.arn
  
}


resource "aws_sns_topic" "autoscaling_notifications" {
  name = "autoscaling-notifications"
#   depends_on = [aws_autoscaling_group.scalar.id]
}

resource "aws_sns_topic_subscription" "target" {
  for_each  = toset(["hamzausmani021@gmail.com"])       # to variablize
  topic_arn = aws_sns_topic.autoscaling_notifications.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_sns_topic_subscription" "target_sms" {
  for_each  = toset(["+923322411710"])       # to variablize
  topic_arn = aws_sns_topic.autoscaling_notifications.arn
  protocol  = "sms"
  endpoint  = each.value
}
