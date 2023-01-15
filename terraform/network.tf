resource "yandex_vpc_network" "this" {
  name = "my-net"
}

resource "yandex_vpc_subnet" "this" {
  for_each = toset(var.az)
  name = "my-subnet-${each.value}"
  zone = each.value
  network_id = "${yandex_vpc_network.this.id}"
  v4_cidr_blocks = var.cidr_blocks[index(var.az, each.value)]
}