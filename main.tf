resource "google_compute_network" "vpc_network" {
  name = "web-db-network"
}

resource "google_compute_firewall" "default" {
  name    = "allow-http-ssh"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

resource "google_compute_instance" "web_server" {
  name         = "web-server-instance"
  machine_type = var.machine_type
  zone         = var.zone
  tags = ["web"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10  # Minimum size, Free Tier provides 30 GB of standard persistent disk
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral public IP
    }
  
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "Hello, World from $(hostname)!" | sudo tee /var/www/html/index.html
  EOF
}

resource "google_sql_database_instance" "db_instance" {
  name             = "mysql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"  # Free Tier eligible
  }

  root_password = var.db_password
}

resource "google_sql_database" "database" {
  name     = "app_database"
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "app_user" {
  name     = "app_user"
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
}