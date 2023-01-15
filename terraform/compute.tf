data "yandex_compute_image" "this" {
  name = "${var.image_name}-${var.image_tag}"
}

resource "yandex_compute_instance_group" "this" {
  name                = "my-instance-group"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.this.id}"
  depends_on          = [yandex_resourcemanager_folder_iam_binding.this]

  application_load_balancer {
    target_group_name = "my-target-group-name"
  }
  instance_template {
    platform_id = "standard-v1"
    resources {
        memory = var.resources.memory
        cores  = var.resources.cpu
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.this.id}"
        size     = var.resources.disk_size
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.this.id}"
      subnet_ids = [ for s in yandex_vpc_subnet.this: s.id ]
    }
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.scale_size
    }
  }

  allocation_policy {
    zones = tolist(var.az)
  }

  deploy_policy {
    max_unavailable = var.deploy_policy.max_unavailable
    max_creating    = var.deploy_policy.max_creating
    max_expansion   = var.deploy_policy.max_expansion
    max_deleting    = var.deploy_policy.max_deleting
  }
}