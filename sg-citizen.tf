resource "google_service_account" "citizen_sg" {
  count = local.citizen_enabled ? 1 : 0

  account_id  = "${var.vpc_name}-${var.citizen_sg_name}"
  description = "${var.citizen_sg_name} service account"
}

resource "google_compute_firewall" "citizen_sg_ssh" {
  count = var.bastion_enabled && local.citizen_enabled ? 0 : 1

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-ssh"
  network                 = module.public-vpc.network_name
  description             = "${var.citizen_sg_name} SSH access from corporate IP"
  direction               = "INGRESS"
  source_ranges           = var.corporate_ip == "" ? ["0.0.0.0/0"] : ["${var.corporate_ip}/32"]
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
    "22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "citizen_sg_bastion_ssh" {
  count = var.bastion_enabled && local.citizen_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-ssh"
  network                 = module.private-vpc.network_name
  description             = "${var.citizen_sg_name} SSH access via bastion host"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.bastion_sg[*].email
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
    "22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "citizen_sg_mon" {
  count = var.monitoring_enabled && local.citizen_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-monitoring"
  network                 = module.private-vpc.network_name
  description             = "${var.logging_sg_name} node exporter"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.monitoring_sg[*].email
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
      "9100",
    "9323"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "citizen_sg_hids" {
  count = var.hids_enabled && local.citizen_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-hids"
  network                 = module.private-vpc.network_name
  description             = "${var.citizen_sg_name} HIDS"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.monitoring_sg[*].email
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
      "1514",
    "1515"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "citizen_sg_consul" {
  count = var.consul_enabled && local.citizen_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-consul"
  network                 = module.private-vpc.network_name
  description             = "${var.citizen_sg_name} Consul ports"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.consul_sg[*].email
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
      "8600",
      "8500",
      "8301",
    "8302"]
    protocol = "tcp"
  }

  allow {
    ports = [
      "8600",
      "8301",
    "8302"]
    protocol = "udp"
  }
}

resource "google_compute_firewall" "citizen_sg_api" {
  count = local.citizen_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.citizen_sg_name}-api"
  network                 = module.public-vpc.network_name
  description             = "${var.citizen_sg_name} API ports"
  direction               = "INGRESS"
  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = google_service_account.citizen_sg[*].email

  allow {
    ports = [
    "9000"]
    protocol = "tcp"
  }
}