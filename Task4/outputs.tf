output "vpc_network_id" {
  description = "ID созданной облачной сети VPC"
  value       = yandex_vpc_network.future_net.id
}

output "subnet_id" {
  description = "ID созданной подсети"
  value       = yandex_vpc_subnet.future_subnet.id
}

output "instance_id" {
  description = "ID развёрнутой виртуальной машины"
  value       = yandex_compute_instance.data_node.id
}

output "internal_ip_address" {
  description = "Внутренний IP-адрес ВМ в подсети"
  value       = yandex_compute_instance.data_node.network_interface[0].ip_address
}

output "external_ip_address" {
  description = "Публичный IP-адрес ВМ (NAT)"
  value       = yandex_compute_instance.data_node.network_interface[0].nat_ip_address
}