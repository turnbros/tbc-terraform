resource "kubernetes_deployment" "rust_deployment" {
  metadata {
    name      = local.server_name
    namespace = var.tenant_namespace
    labels = merge({
      "app.kubernetes.io/name" : local.server_name,
      "cloud.turnbros.app/tenant" : var.tenant_name
    }, local.labels)
  }
  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.server_name,
        "cloud.turnbros.app/tenant" : var.tenant_name
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name" : local.server_name,
          "cloud.turnbros.app/tenant" : var.tenant_name
        }, local.labels)
      }
      spec {
        automount_service_account_token = false
        container {
          name              = local.server_name
          image             = local.image
          image_pull_policy = local.image_pull_policy

          resources {
            requests = {
              cpu    = local.cpu_request
              memory = local.memory_request
            }
            limits = {
              cpu    = local.cpu_limit
              memory = local.memory_limit
            }
          }

          env {
            name  = "RUST_SERVER_STARTUP_ARGUMENTS"
            value = var.rust_server_startup_arguments
          }
          env {
            name  = "RUST_SERVER_IDENTITY"
            value = var.rust_server_identity
          }
          env {
            name  = "RUST_SERVER_SEED"
            value = local.rust_server_seed
          }
          env {
            name  = "RUST_SERVER_WORLDSIZE"
            value = var.rust_server_worldsize
          }
          env {
            name  = "RUST_SERVER_NAME"
            value = var.rust_server_name
          }
          env {
            name  = "RUST_SERVER_MAXPLAYERS"
            value = var.rust_server_maxplayers
          }
          env {
            name  = "RUST_SERVER_DESCRIPTION"
            value = var.rust_server_description
          }
          env {
            name  = "RUST_SERVER_URL"
            value = var.rust_server_url
          }
          env {
            name  = "RUST_SERVER_BANNER_URL"
            value = var.rust_server_banner_url
          }
          env {
            name  = "RUST_SERVER_SAVE_INTERVAL"
            value = var.rust_server_save_interval
          }
          env {
            name  = "RUST_RCON_WEB"
            value = var.rust_rcon_web
          }
          env {
            name = "RUST_RCON_PASSWORD"
            value_from {
              secret_key_ref {
                key  = kubernetes_secret.rcon_password.metadata.0.name
                name = "rcon_password"
              }
            }
          }
          env {
            name  = "RUST_BRANCH"
            value = var.rust_branch
          }
          env {
            name  = "RUST_UPDATE_CHECKING"
            value = var.rust_update_checking
          }
          env {
            name  = "RUST_UPDATE_BRANCH"
            value = var.rust_update_branch
          }
          env {
            name  = "RUST_START_MODE"
            value = local.rust_start_mode
          }
          env {
            name  = "RUST_OXIDE_ENABLED"
            value = local.rust_oxide_enabled
          }
          env {
            name  = "RUST_OXIDE_UPDATE_ON_BOOT"
            value = local.rust_oxide_update_on_boot
          }

          env {
            name  = "RUST_SERVER_PORT"
            value = var.rust_server_port
          }

          env {
            name  = "RUST_RCON_PORT"
            value = var.rust_rcon_port
          }

          env {
            name  = "RUST_APP_PORT"
            value = var.rust_app_port
          }

          port {
            name           = "server-port"
            container_port = var.rust_server_port
          }

          port {
            name           = "rcon-port"
            container_port = var.rust_rcon_port
          }
          port {
            name           = "app-port"
            container_port = var.rust_app_port
          }

          #liveness_probe {
          #  initial_delay_seconds = 600
          #  tcp_socket {
          #    port = var.rust_rcon_port
          #  }
          #}
          #
          #readiness_probe {
          #  initial_delay_seconds = 600
          #  tcp_socket {
          #    port = var.rust_rcon_port
          #  }
          #}
        }
      }
    }
  }
}