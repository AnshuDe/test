provider "azurerm" {
  features{}
  
}

data "azurerm_kubernetes_cluster" "example" {

  name    = "webAKScluster"

  resource_group_name = "Terraform-resourcegrp"

}


provider "kubernetes" {

  # version = "<=2.0.1"

  host = data.azurerm_kubernetes_cluster.example.kube_config[0].host
  client_certificate = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].client_certificate)
  client_key = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].client_key)

  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate)

}

resource "kubernetes_secret" "example" {

  metadata {

    name = "docker-cfg"

  }

  type = "kubernetes.io/dockerconfigjson"

  data = {

    ".dockerconfigjson" = jsonencode({

      auths = {

        "azureregistery02.azurecr.io" = {

          "username" = "azureregistery02"

          "password" = "/MQJGfVBUzzZ5ayvHB64Z38lC5TLHkpHbW+Nq+TJ9N+ACRAMMny6"

          "email"    = "edwinkullu94@gmail.com"

          "auth"     = base64encode("azureregistery02:/MQJGfVBUzzZ5ayvHB64Z38lC5TLHkpHbW+Nq+TJ9N+ACRAMMny6")

        }

      }

    })

  }

}





resource "kubernetes_deployment" "webapp" {

  metadata {

    name      = "webapp"

    namespace = "myapp"

    labels = {

      app = "webapp"

    }

  }


  spec {

    replicas = 1

    selector {

      match_labels = {

        app = "webapp"

      }

    }


    template {

      metadata {

        labels = {

          app = "webapp"

        }

      }


      spec {

        image_pull_secrets {

          name = kubernetes_secret.example.metadata[0].name

        }

        container {

          image = "azureregistery02.azurecr.io/webapp:20230612_043344"

          name  = "webapp"

          port {

            container_port = 80

          }


          resources {

            limits = {

              cpu    = "0.5"

              memory = "512Mi"

            }

            requests = {

              cpu    = "250m"

              memory = "50Mi"

            }

          }

        }

      }



    }

  }

}