project = "example-nodejs-ingress"

app "example-nodejs-ingress" {
  labels = {
    "service" = "example-nodejs-ingress",
    "env"     = "dev"
  }

  build {
    use "docker-pull" {
      image = "docker.io/hackgt/waypoint-testing"
      tag   = "latest"
      disable_entrypoint = true
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      ingress "http" {
        annotations = {
          "kubernetes.io/ingress.class" = "nginx"
          "kubernetes.io/tls-acme" = "true"
        }

        path_type = "ImplementationSpecific"
        host = "yoyoyo.hack.gt"

        tls {
          hosts = ["yoyoyo.hack.gt"]
          secret_name = "prod-tls"
        }
      }
    }
  }
}
