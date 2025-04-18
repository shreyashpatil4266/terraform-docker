terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "my-nginx-container"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
    ip       = "0.0.0.0" # Ensures it's bound to all interfaces including localhost
  }
}

