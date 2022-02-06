output "my-ip" {
  value = "${aws_instance.web.public_ip}"
}