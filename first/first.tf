# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Create a container
resource "docker_container" "bar" {
  image   = "${docker_image.ubuntu.latest}"
  name    = "bar"
  command = ["/bin/sh", "-c", "while true; do echo My Message $RANDOM; sleep 10; done;"]

  ports {
    internal = 22
    external = 2222
  }
}

resource "docker_image" "ubuntu" {
  # name = "ubuntu:latest"
  name = "docker-ansible:latest"
}

# # Create an Nginx container
# resource "docker_container" "nginx" {
#   image = "${docker_image.nginx.latest}"
#   name  = "enginecks"


#   ports {
#     internal = 80
#     external = 80
#   }
# }


# resource "docker_image" "nginx" {
#   name = "nginx:latest"
# }

