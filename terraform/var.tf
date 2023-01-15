variable "az" {
  type = list(string)
  default = [ 
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
   ]
}

variable "cidr_blocks" {
  type = list(list(string))
  default = [
    ["10.10.0.0/24"],
    ["10.11.0.0/24"],
    ["10.12.0.0/24"]
  ]
  description = "CIDR"
}

variable "resources" {
  type = object({
    cpu       = number
    memory    = number
    disk_size = number
  })
  default = {
    cpu       = 2
    memory    = 4
    disk_size = 10
  }
  description = "Resources for VM"
}

variable "scale_size" {
  type = number
  description = "Scale size"
  default = 3
}

variable "deploy_policy" {
  type = object({
    max_unavailable = number
    max_creating   = number
    max_expansion  = number
    max_deleting   = number
  })
  default = {
    max_creating   = 2
    max_deleting   = 2
    max_expansion  = 2
    max_unavailable = 2
  }
  description = "Numbers for Deploy policy"
}

variable "folder_id" {
  type = string
  description = "get from YC_FOLDER_ID: -var folder_id=$YC_FOLDER_ID"
}

variable "image_name" {
  type = string
  default = "nginx"
  description = "Name of image"
}

variable "image_tag" {
  type = number
  description = "Tag of image"
}