resource "yandex_alb_http_router" "this" {
  name = "my-http-router"
}

resource "yandex_alb_backend_group" "this" {
  name = "my-backend-group"

  http_backend {
    name             = "my-http-backend"
    weight           = 1
    port             = 80
    target_group_ids = ["${yandex_compute_instance_group.this.application_load_balancer.0.target_group_id}"]
    # load_balancing_config {
    #   panic_treshold = 50
    # }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
    # http2 = "true"
  }
}

resource "yandex_alb_virtual_host" "this" {
  name           = "my-app-lb-virthost"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "my-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout = "3s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name = "my-app-lb"

  network_id = yandex_vpc_network.this.id

  allocation_policy {
    # fuck knows how to make a cycle here
    location {
        zone_id   = var.az[0]
        subnet_id = yandex_vpc_subnet.this[var.az[0]].id
    }
    location {
        zone_id   = var.az[1]
        subnet_id = yandex_vpc_subnet.this[var.az[1]].id
    }
    location {
        zone_id   = var.az[2]
        subnet_id = yandex_vpc_subnet.this[var.az[2]].id
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}