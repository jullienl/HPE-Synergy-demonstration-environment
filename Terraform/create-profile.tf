
provider "oneview" {
  ov_domain = "Local"
  ov_username = "Administrator"
  ov_password = "password"
  ov_endpoint = "https://192.168.56.101"
  ov_sslverify = false
  ov_apiversion = 1800
  ov_ifmatch = "*"
}
 
// Get Server Hardware
data "oneview_server_hardware" "server_hardware" {
  name = "Synergy-Encl-1, bay 3"
}

// Get Server Profile Template
data "oneview_server_profile_template" "server_profile_template" {
  name = "HPE Synergy 660 Gen9 with Local Boot and SAN Storage for Windows Template"
}

// Create Server Profile from Server Profile Template
resource "oneview_server_profile" "server_profile" {
  name          = "Profile-4"
  template      = "${data.oneview_server_profile_template.server_profile_template.name}"
  hardware_name = "${data.oneview_server_hardware.server_hardware.name}"
  type          = "ServerProfileV12"
  power_state = "on"
}

