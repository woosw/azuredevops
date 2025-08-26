locals {
  # 1) 리전 표준화 (공백 제거 + 소문자)
  location_norm = lower(replace(var.location, " ", ""))

  # 2) 리전 → 짧은 코드 매핑
  loc_code_map = {
    koreacentral = "krc"
    koreasouth   = "krs"
    eastus       = "eus"
    westus       = "wus"
    westeurope   = "weu"
    japaneast    = "jpe"
    southeastasia= "sea"
  }
  loc_code = lookup(local.loc_code_map, local.location_norm, substr(local.location_norm, 0, 3))

 # 3) 표준 네이밍 규칙들
  #    원하시는 규칙으로 마음껏 바꾸세요.
  rg_name   = format("rg-%s-%s",   var.env, var.service)                 # rg-dev-metiq
  vnet_name = format("vnet-%s-%s-%s", var.service, local.loc_code, var.env)  # vnet-metiq-krc-dev

  # (선택) 길이 제한 가드 (Azure 리소스별 제한 상이)
  rg_name_safe   = substr(local.rg_name,   0, 90)  # RG 이름은 최대 90자
  vnet_name_safe = substr(local.vnet_name, 0, 64)  # VNet 이름은 최대 64자
}