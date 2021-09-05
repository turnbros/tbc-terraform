###################################
### Infrastructure Remote State ###
###################################
# image_pull_secret
# bucket_access_key
# bucket_secret_key
# bucket_host
# bucket_name
# bucket_server_data_prefix

variable "tenant_name" {
  type = string
}
variable "tenant_namespace" {
  type = string
}
variable "cluster_firewall_api_secret_name" {
  type    = string
  default = "opnsense-device-secret"
}
variable "cluster_firewall_api_secret_namespace" {
  type = string
  default = "default"
}
variable "cluster_firewall_external_interface" {
  type = list(string)
  default = ['wan']
}
variable "cluster_firewall_alias" {
  type    = string
  default = "arroyo-cluster-nodes"
}
variable "rust_server_port" {
  type = number
}
variable "rust_rcon_port" {
  type = number
}

variable "rust_app_port" {
  type = number
}

# RUST_SERVER_NAME
variable "rust_server_name" {
  type        = string
  description = "The publicly visible server name"
  default     = "Rust Server [DOCKER]"
}

# RUST_SERVER_STARTUP_ARGUMENTS
variable "rust_server_startup_arguments" {
  type        = string
  description = ""
  default     = "-batchmode -load -nographics +server.secure 1"
}

# RUST_SERVER_IDENTITY
variable "rust_server_identity" {
  type        = string
  description = "Mainly used for the name of the save directory"
  default     = "docker"
}

# RUST_SERVER_SEED
variable "rust_server_seed" {
  type        = number
  description = "The server map seed, must be an integer"
  default     = null
}

# RUST_SERVER_WORLDSIZE
variable "rust_server_worldsize" {
  type        = number
  description = "The map size, must be an integer"
  default     = 4500
}

# RUST_SERVER_MAXPLAYERS
variable "rust_server_maxplayers" {
  type        = number
  description = "Maximum players on the server, must be an integer"
  default     = 100
}

# RUST_SERVER_DESCRIPTION
variable "rust_server_description" {
  type        = string
  description = "The publicly visible server description"
  default     = "This is a Rust server running inside a Docker container!"
}

# RUST_SERVER_URL
variable "rust_server_url" {
  type        = string
  description = "The publicly visible server website"
  default     = "https://hub.docker.com/r/didstopia/rust-server/"
}

# RUST_SERVER_BANNER_URL
variable "rust_server_banner_url" {
  type        = string
  description = "The publicly visible server banner image URL"
  default     = ""
}

# RUST_SERVER_SAVE_INTERVAL
variable "rust_server_save_interval" {
  type        = number
  description = "Amount of seconds between automatic saves."
  default     = 600
}

# RUST_RCON_WEB
variable "rust_rcon_web" {
  type        = number
  description = "Set to 1 or 0 to enable or disable the web-based RCON server"
  default     = 1
}

# RUST_BRANCH
variable "rust_branch" {
  type        = string
  description = "Sets the branch argument to use, eg. set to `-beta prerelease` for the prerelease branch"
  default     = "public"
}

# RUST_UPDATE_CHECKING
variable "rust_update_checking" {
  type        = number
  description = "Set to 1 to enable fully automatic update checking, notifying players and restarting to install updates"
  default     = 0
}

# RUST_UPDATE_BRANCH
variable "rust_update_branch" {
  type        = string
  description = "Set to match the branch that you want to use for updating, ie. `prerelease` or `public`, but do not specify arguments like `-beta`"
  default     = "public"
}
