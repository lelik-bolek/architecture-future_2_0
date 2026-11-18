terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.130"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# Получение актуального ID образа Ubuntu 22.04 LTS
data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# 1. Облачная сеть (VPC)
resource "yandex_vpc_network" "future_net" {
  name        = var.network_name
  description = "Изолированная сеть платформы данных Будущее 2.0"
}

# 2. Подсеть в выбранной зоне доступности
resource "yandex_vpc_subnet" "future_subnet" {
  name           = var.subnet_name
  description    = "Подсеть для узлов обработки данных и адаптеров"
  zone           = var.zone
  network_id     = yandex_vpc_network.future_net.id
  v4_cidr_blocks = var.subnet_cidr
}

# 3. Загрузочный SSD-диск
resource "yandex_compute_disk" "data_node_disk" {
  name     = "${var.vm_name}-boot-disk"
  type     = var.disk_type
  zone     = var.zone
  image_id = data.yandex_compute_image.ubuntu.id
  size     = var.disk_size
}

# 4. Виртуальная машина (Compute Instance) с включённым NAT
resource "yandex_compute_instance" "data_node" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = 100
  }

  boot_disk {
    disk_id = yandex_compute_disk.data_node_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.future_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand(var.ssh_public_key_path))}"
  }
}