# variable "github_token" {
#   type      = string
#   sensitive = true
# }

# Configure the GitHub Provider
provider "github" {
    token = var.github_token

}

resource "github_repository" "demo" {
    name        = "demo"
    description = "My awesome repository"
    visibility = "private"  # or "public"
}



