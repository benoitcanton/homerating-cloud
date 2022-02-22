/*
* Artifact registry
* https://cloud.google.com/artifact-registry
*/

resource "google_artifact_registry_repository" "homerating_docker_registry" {
  provider = google-beta

  location = local.region
  repository_id = "homerating-docker-repository"
  format = "DOCKER"
}