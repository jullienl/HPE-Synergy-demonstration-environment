from hpOneView.oneview_client import OneViewClient
from pprint import pprint
import json

lig_name = "LIG-FlexFabric"
uplinkset_name = "Prod"
networkset_name = "Prod"

config = {
    "ip": "192.168.56.101",
    "api_version": 1600,
    "credentials": {
        "userName": "Administrator",
        "password": "password"
    }
}

oneview_client = OneViewClient(config)

ethernet_networks = oneview_client.ethernet_networks
network_sets = oneview_client.network_sets

# Creating Ethernet network

options_ethernet = {
    "name": "RHEL Prod",
    "vlanId": 50,
    "ethernetNetworkType": "Tagged",
    "purpose": "General",
    "smartLink": False,
    "privateNetwork": False,
    "connectionTemplateUri": None,
}

ethernet_network = ethernet_networks.create(options_ethernet)

print("Created ethernet-networks '%s' successfully.\n  uri = '%s' " 
  % ( ethernet_network.data['name'] , ethernet_network.data['uri'] ) )

# Get RHEL Prod network URI & name

ethernet_network_uri = ethernet_network.data['uri']
ethernet_network_name = options_ethernet['name']

logical_interconnect_groups  = oneview_client.logical_interconnect_groups

# Get logical interconnect group by name
lig = logical_interconnect_groups.get_by_name(lig_name)
lig_response = lig.data

#help(oneview_client.logical_interconnect_groups)

for uplink in lig_response['uplinkSets']:
    if uplink['name'] == uplinkset_name :
        new_uplinkset_Prod_networkuris = uplink['networkUris'] + [ethernet_network_uri]
        # pprint(uplink['networkUris'])
        # pprint(new_uplinkset_Prod_networkuris)
        uplink['networkUris'] = new_uplinkset_Prod_networkuris

lig_to_update = lig_response.copy()

#print(json.dumps(lig_to_update['uplinkSets'], indent=4))

# Update a logical interconnect group
print("Updating logical interconnect group '%s' " % (lig_name))
lig.update(lig_to_update)
print("Number of networks configured in the uplink set '%s' is now %s " % ( uplinkset_name , str(len(new_uplinkset_Prod_networkuris))   ))

# Updating the LI from the LIG
logical_interconnect_name = "LE-Synergy-Local-LIG-FlexFabric"
logical_interconnects = oneview_client.logical_interconnects
logical_interconnect = logical_interconnects.get_by_name(logical_interconnect_name)

# Return the logical interconnect to a consistent state
print("Return the logical interconnect to a consistent state")
logical_interconnect_updated = logical_interconnect.update_compliance()
print("  Done. The current consistency state is {consistencyStatus}.".format(**logical_interconnect_updated))


# Adding new network to Network Set
network_sets = oneview_client.network_sets
network_set = network_sets.get_by_name(networkset_name)
networkset_networkUris = (network_set.data)['networkUris']
new_networkset_networkUris = networkset_networkUris + [ethernet_network_uri]
network_set_update = {'networkUris': new_networkset_networkUris}
network_set = network_set.update(network_set_update)

print("Updated network set '%s' successfully! \n" % (networkset_name))
