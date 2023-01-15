output "yandex_alb_load_balancer_external_ip" {
  value = "${yandex_alb_load_balancer.this.listener.*.endpoint.0.address.0.external_ipv4_address.0.address[0]}"
}

output "instance_group_from_image" {
  value = "${var.image_name}-${var.image_tag}"
}