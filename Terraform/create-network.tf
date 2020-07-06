
provider "oneview" {
  ov_domain = "Local"
  ov_username = "Administrator"
  ov_password = "password"
  ov_endpoint = "https://192.168.56.101"
  ov_sslverify = false
  ov_apiversion = 1600
  ov_ifmatch = "*"
}

// 1 - IMPORTING RESOURCE FIRST

resource "oneview_network_set" "network_set" { 
}

resource "oneview_logical_interconnect_group" "logical_interconnect_group" {
}

resource "oneview_logical_interconnect" "logical_interconnect"{
}


// 2 - ADDING THE NEW NETWORK 

// CREATION OF ETHERNET NETWORK
# resource "oneview_ethernet_network" "ethernet_network" {
# 	name = "Prod_60"
# 	type = "ethernet-networkV4"
# 	vlan_id = 60
# }

# // ADDING NEW NETWORK URI TO LOGICAL INTERCONNECT GROUP UPLINK SET URIS
# resource "oneview_logical_interconnect_group" "logical_interconnect_group" {
# 	type = "logical-interconnect-groupV8"
#   interconnect_bay_set = 3
#   enclosure_indexes = [1, 2, 3]
# 	redundancy_type = "HighlyAvailable"
# 	name = "LIG-FlexFabric"
# 	internal_network_uris = [""] 
#   interconnect_map_entry_template = [{
# 	  enclosure_index = 1
# 	  bay_number = 3
# 	  interconnect_type_name = "Virtual Connect SE 40Gb F8 Module for Synergy"
# 	 },
# 	 {
# 	  enclosure_index = 2
# 	  bay_number = 6
# 	  interconnect_type_name = "Virtual Connect SE 40Gb F8 Module for Synergy"
# 	 },
# 	 {
# 	  enclosure_index = 2
# 	  bay_number = 3
# 	  interconnect_type_name = "Synergy 20Gb Interconnect Link Module"
# 	 },
# 	 {
# 	  enclosure_index = 3
# 	  bay_number = 3
# 	  interconnect_type_name = "Synergy 20Gb Interconnect Link Module"
# 	 },
# 	 {
# 	  enclosure_index = 1
# 	  bay_number = 6
# 	  interconnect_type_name = "Synergy 20Gb Interconnect Link Module"
# 	 },
# 	 {
# 	  enclosure_index = 3
# 	  bay_number = 6
# 	  interconnect_type_name = "Synergy 20Gb Interconnect Link Module"
# 	 }]
#   uplink_set = [{
# 		network_type = "Ethernet"
# 		network_uris =  ["${oneview_network_set.network_set.network_uris}", "${oneview_ethernet_network.ethernet_network.uri}"]
#     name = "Prod"
# 	}]
	
# }

# // PERFORMING UPDATE FROM GROUP ON LOGICAL INTERCONNECT TO BRING BACK IT TO CONSISTENT STATE 
# resource "oneview_logical_interconnect" "logical_interconnect" {
# 	update_type = "updateComplianceById"
# 	depends_on = ["oneview_logical_interconnect_group.logical_interconnect_group"]
# }

# variable "uris" {
#   default = ["$${oneview_network_set.network_set.network_uris}"]
# }

# // ADDING THE NEW NETWORK TO THE NETWORK SET  
# resource "oneview_network_set" "network_set" {
#   name = "Prod"
#   native_network_uri = ""
#   type = "network-setV5"
#   network_uris = ["${var.uris}", "${oneview_ethernet_network.ethernet_network.uri}"]
#   depends_on = ["oneview_ethernet_network.ethernet_network"]
# }