variable "image_tag" {
  type = string
}

variable "YC_FOLDER_ID" {
    type = string
    default = env("YC_FOLDER_ID")
  }

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

source "yandex" "nginx" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "WTF image"
  image_family        = "ubuntu-2204-lts"
  image_name          = "nginx-${var.image_tag}"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-hdd"
  zone                = "${var.YC_ZONE}"

}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    use_proxy     = false
    playbook_file = "playbook.yml"
  }
}