variable "do_token" {
    type = string
    description = "DigitalOcean access token"
    sensitive = true
}

variable ssh_key {
    type = string
    description = "Path to private ssh key"
    sensitive = true
}

variable user_name {
    type = string
    description = "User name for non-root user"
}