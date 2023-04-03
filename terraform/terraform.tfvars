containers = ["images","docs"]
resource_grp_name = "rg-testing-tf-functions"
storage_acct_name = "staccount"
team_name = "devops"
vm_username = "ubuntu"
vm_password = "Lincoln2000!"
vnet_cidr = "10.80.112.0/22"

tas_storage_account_prefix="sttasdeployments"
opsmanager_vhd_uri = "https://opsmanagereastus.blob.core.windows.net/images/ops-manager-3.0.6-build.269.vhd"

platform_subnets =[
    {
      "name" = "management"
      "address_prefix" = "10.80.112.0/25"
      }, {
      "name" = "tas"
      "address_prefix" = "10.80.113.0/24"
      }, {
      "name" = "on_demand_services"
      "address_prefix" = "10.80.114.0/24"
      }, {
      "name" = "services"
      "address_prefix" = "10.80.115.0/24"
      }, {
      "name" = "concourse"
      "address_prefix" = "10.80.112.128/25"
    }
  ]
