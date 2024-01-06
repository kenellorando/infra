resource "google_compute_instance" "cadence" {
  boot_disk {
    auto_delete = true
    device_name = "cadence"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20231213a"
      size  = 12
      type  = "pd-standard"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = true
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-small"
  name         = "cadence"

  network_interface {
    access_config {
      network_tier = "STANDARD"
      nat_ip = google_compute_address.cadence.address
    }

    subnetwork = "projects/kenellorando-484bc/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = false
    # on_host_maintenance = "MIGRATE"
    preemptible         = true
    provisioning_model  = "SPOT"
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = true
    enable_vtpm                 = true
  }

  zone = "us-central1-a"

  metadata = {
    ssh-keys = <<EOF
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFBKgbzzAvu3+V8xg1zVLhkgFuHHi/wOLpW4D6WFnFF2 kenellorando@gmail.com
    EOF
  }


  tags = ["http-server"]
}

resource "google_compute_address" "cadence" {
  name   = "cadence-static-ipv4"
  region = "us-central1"
  network_tier = "STANDARD"
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = "default"  # You may need to change the network name based on your setup

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["http-server"]
}
