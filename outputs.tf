output "web_server_ip" {
  description = "The public IP address of the web server"
  value       = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

output "db_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.db_instance.connection_name
}
