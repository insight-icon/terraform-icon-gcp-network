resource "google_service_account" "prep_sg" {
  count = local.prep_enabled ? 1 : 0

  account_id  = "${var.vpc_name}-${var.prep_sg_name}"
  description = "${var.prep_sg_name} service account"

}

resource "google_compute_firewall" "prep_sg_ssh" {
  count = local.bastion_enabled && ! local.prep_enabled ? 0 : 1

  name                    = "${var.vpc_name}-${var.prep_sg_name}-ssh"
  network                 = module.public-vpc.network_name
  description             = "${var.prep_sg_name} SSH access from corporate IP"
  direction               = "INGRESS"
  source_ranges           = var.corporate_ip == "" ? ["0.0.0.0/0"] : ["${var.corporate_ip}/32"]
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
    "22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "prep_sg_bastion_ssh" {
  count = local.bastion_enabled && local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-ssh"
  network                 = module.private-vpc.network_name
  description             = "${var.prep_sg_name} SSH access via bastion host"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.bastion_sg[*].email
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
    "22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "prep_sg_mon" {
  count = local.monitoring_enabled && local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-monitoring"
  network                 = module.private-vpc.network_name
  description             = "${var.logging_sg_name} node exporter"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.monitoring_sg[*].email
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
      "9100",
    "9323"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "prep_sg_hids" {
  count = local.hids_enabled && local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-hids"
  network                 = module.private-vpc.network_name
  description             = "${var.prep_sg_name} HIDS"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.monitoring_sg[*].email
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
      "1514",
    "1515"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "prep_sg_consul" {
  count = local.consul_enabled && local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-consul"
  network                 = module.private-vpc.network_name
  description             = "${var.prep_sg_name} Consul ports"
  direction               = "INGRESS"
  source_service_accounts = google_service_account.consul_sg[*].email
  target_service_accounts = google_service_account.prep_sg[*].email

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

resource "google_compute_firewall" "prep_sg_p2p" {
  count = local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-p2p"
  network                 = module.public-vpc.network_name
  description             = "${var.prep_sg_name} P2P ports"
  direction               = "INGRESS"
  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
    "7100"]
    protocol = "tcp"
  }
}


resource "google_compute_firewall" "prep_sg_api" {
  count = local.prep_enabled ? 1 : 0

  name                    = "${var.vpc_name}-${var.prep_sg_name}-api"
  network                 = module.public-vpc.network_name
  description             = "${var.prep_sg_name} API ports"
  direction               = "INGRESS"
  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = google_service_account.prep_sg[*].email

  allow {
    ports = [
    "9000"]
    protocol = "tcp"
  }
}
