data "aws_ssm_parameter" "ssh_pass" {
  name = "${var.env}.ssh.pass"
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex = "devops-practice-with-ansible-my-local-image"
  owners = ["self"]

} #since we are moving to container and k8s , we have deleted the ami's that we created and also the snapshots
