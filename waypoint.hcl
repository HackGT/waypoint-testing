project = "example-nodejs-ingress"

app "example-nodejs-ingress" {
  labels = {
    "service" = "example-nodejs-ingress",
    "env"     = "dev"
  }

  build {
    use "docker" {
      disable_entrypoint = true
    }
    
    registry {
      use "docker" {
        image = "gcr.io/hackgt-cluster/example-nodejs-ingress"
        tag   = "1.0.0"
        local = false
      }
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
        path_type = "Prefix"
        path      = "/"
      }
    }
  }
}
