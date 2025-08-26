variable "name" {
  description = "리소스 그룹 이름"
  type        = string
}

variable "location" {
  description = "리전 (예: Korea Central)"
  type        = string
}

variable "tags" {
  description = "태그"
  type        = map(string)
  default     = {}
}

variable "enable_lock" {
  description = "RG 잠금 사용 여부"
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "잠금 수준: CanNotDelete | ReadOnly"
  type        = string
  default     = "CanNotDelete"
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "lock_level 은 CanNotDelete 또는 ReadOnly 여야 합니다."
  }
}

variable "lock_name" {
  type        = string
  default     = null
}

variable "lock_notes" {
  type        = string
  default     = null
}