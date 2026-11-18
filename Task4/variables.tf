variable "token" {
  description = "IAM-токен или OAuth-токен для доступа к Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Идентификатор облака (Cloud ID) в Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога (Folder ID) в Yandex Cloud"
  type        = string
}

variable "zone" {
  description = "Зона доступности Yandex Cloud"
  type        = string
  default     = "ru-central1-a"
}

variable "network_name" {
  description = "Имя создаваемой облачной сети (VPC)"
  type        = string
  default     = "future-2-0-vpc"
}

variable "subnet_name" {
  description = "Имя создаваемой подсети"
  type        = string
  default     = "future-2-0-subnet-a"
}

variable "subnet_cidr" {
  description = "IPv4 CIDR-блок подсети"
  type        = list(string)
  default     = ["10.10.0.0/24"]
}

variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
  default     = "future-data-node-01"
}

variable "vm_cores" {
  description = "Количество виртуальных ядер CPU (vCPU)"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Объём оперативной памяти (ГБ)"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Размер загрузочного диска (ГБ)"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Тип сетевого диска (network-ssd или network-hdd)"
  type        = string
  default     = "network-ssd"
}

variable "image_family" {
  description = "Семейство образов ОС"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "ssh_user" {
  description = "Имя пользователя ОС для подключения по SSH"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}