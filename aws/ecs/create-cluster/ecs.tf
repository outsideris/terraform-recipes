resource "aws_ecs_cluster" "example" {
  name = "your-cluster-name"
}

resource "aws_launch_configuration" "example" {
  name_prefix          = "${aws_ecs_cluster.example.name}-"
  image_id             = "${data.aws_ami.ecs_optimized.id}"
  instance_type        = "t2.micro"
  iam_instance_profile = "ecsInstanceRole"
  key_name             = "your-keypair-name"

  security_groups = [
    "your-security-group-you-will-attach",
  ]

  user_data     = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.example.name} > /etc/ecs/ecs.config"
  ebs_optimized = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 80
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "${aws_ecs_cluster.example.name}"
  availability_zones   = ["${data.aws_availability_zones.tokyo.names}"]
  launch_configuration = "${aws_launch_configuration.example.name}"

  vpc_zone_identifier = [
    "your-subnet-id-you-will-use",
  ]

  min_size         = "2"
  max_size         = "4"
  desired_capacity = "2"

  tag = [
    {
      key                 = "Name"
      value               = "ecs-${aws_ecs_cluster.example.name}"
      propagate_at_launch = true
    },
  ]
}
