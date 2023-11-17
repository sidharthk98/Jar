resource "google_service_account" "cluster_admin_sa" {
  account_id   = "gke-cluster-sa"
  project = var.project_id
  display_name = "gke-cluster-role-sa"
}

resource "google_project_iam_member" "cluster_role_policy" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}
resource "google_project_iam_member" "container_cluster_admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}
resource "google_project_iam_member" "container_developer" {
  project = var.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}
resource "google_project_iam_member" "iam_service_account_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}
resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}
resource "google_project_iam_member" "compute_security_admin" {
  project = var.project_id
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:${google_service_account.cluster_admin_sa.email}"
}