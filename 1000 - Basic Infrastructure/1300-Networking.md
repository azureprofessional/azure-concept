# Networking

## Virtual Network (VNet)

An Azure Virtual Network is bound within an Azure subscription and region. It is therefore not possible for multiple subscriptions to use the same Azure Virtual Network. The solution is to create separate Virtual Networks in each of the Azure subscriptions with each using a **different** IP address space.

**Resources can only be connected to a virtual network that exists in the same region and subscription the resource is in.**

You can connect virtual networks to each other by using:

  - **Virtual network peering:** The virtual networks must exist in the same Azure region. Bandwidth between resources in peered virtual networks is the same as if the resources were connected to the same virtual network.

  - **An Azure VPN Gateway:** The virtual networks can exist in the same, or different Azure regions. Bandwidth between resources in virtual networks connected through a VPN Gateway is limited by the bandwidth of the VPN Gateway.

Source: <https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview>

## Subnets

Each VNet can contain different subnets.

Each service is placed in a separate subnet.

## Network security group (NSG)

For isolation and traffic control, each Subnet is assigned with a network security group, where in- and outbound network connectivity can be controlled. For more specific control, NSG’s can be assigned to the network interface card (NIC) of a VM. As services are very separated between subnets, this is only recommended in special cases.

## Application security group (ASG)

Instead of NSG on the network interface card, ASG can be used. Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups. You can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform handles the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic.
With ASG, you can control the traffic without the need to assign an NSG to a NIC, with the full isolation of a NIC.

At the moment it's not possible to use ASG in different VNet to create a NSG rule. It's something that ar in planning (Uservoice).

Source: <https://docs.microsoft.com/en-us/azure/virtual-network/security-overview#application-security-groups>

## VNet Peering

Virtual network peering enables you to seamlessly connect two Azure virtual networks. Once peered, the virtual networks appear as one, for connectivity purposes. The traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, much like traffic is routed between virtual machines in the same virtual network, through private IP addresses only. Azure supports:

  - VNet peering - connecting VNets within the same Azure region

  - Global VNet peering - connecting VNets across Azure regions

The benefits of using virtual network peering, whether local or global, include:

  - Network traffic between peered virtual networks is private. Traffic between the virtual networks is kept on the Microsoft backbone network. No public Internet, gateways, or encryption is required in the communication between the virtual networks.
  - A low-latency, high-bandwidth connection between resources in different virtual networks.
  - The ability for resources in one virtual network to communicate with resources in a different virtual network, once the virtual networks are peered.
  - The ability to transfer data across Azure subscriptions, deployment models, and across Azure regions.
  - The ability to peer virtual networks created through the Azure Resource Manager or to peer one virtual network created through Resource Manager to a virtual network created through the classic deployment model. To learn more about Azure deployment models, see Understand Azure deployment models.
  - No downtime to resources in either virtual network when creating the peering, or after the peering is created.

Source: <https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-vnet-plan-design-arm>, <http://www.itprotoday.com/microsoft-azure/understand-virtual-network-sharing-across-subscriptions>

### Requirements and Constraints

  - **You can peer virtual networks in the same region, or different regions**. The following constraints do **not** apply when both virtual networks are in the same region, but do apply when the virtual networks are globally peered:
    
      - The virtual networks can exist in any Azure public cloud region, but not in Azure national clouds.
      
      - Resources in one virtual network cannot communicate with the IP address of an Azure internal load balancer in the peered virtual network. The load balancer and the resources that communicate with it must be in the same virtual network.
      
      - **You cannot use remote gateways or allow gateway transit**. To use remote gateways or allow gateway transit, both virtual networks in the peering must exist in the same region.
      
      - Communication across globally peered virtual networks through the following VM types is not supported: **High performance compute and GPU**. This includes H, NC, NV, NCv2, NCv3, and ND series VMs.

  - The virtual networks can be in **the same, or different subscriptions**. When you peer virtual networks in different subscriptions, **both subscriptions must be associated to the same Azure Active Directory tenant**. If you don't already have an AD tenant, you can quickly create one. You can use a VPN Gateway to connect two virtual networks that exist in different subscriptions that are associated to different Active Directory tenants.

  - The virtual networks you peer must have **non-overlapping IP address spaces**.

  - You **can't add address ranges to, or delete address ranges from a virtual network's address space once a virtual network is peered with another virtual network**. To add or remove address ranges, delete the peering, add or remove the address ranges, then re-create the peering. To add address ranges to, or remove address ranges from virtual networks, see Manage virtual networks.

  - When peering two virtual networks created through Resource Manager, a peering must be configured for each virtual network in the peering. You see one of the following types for peering status:
    
      - Initiated: When you create the peering to the second virtual network from the first virtual network, the peering status is Initiated.
      
      - Connected: When you create the peering from the second virtual network to the first virtual network, its peering status is Connected. If you view the peering status for the first virtual network, you see its status changed from Initiated to Connected. The peering is not successfully established until the peering status for both virtual network peerings is connected.

  - A peering is established between two virtual networks. **Peerings are not transitive.** If you create peerings between:
    
      - VirtualNetwork1 & VirtualNetwork2
      
      - VirtualNetwork2 & VirtualNetwork3
      
      **There is no peering between VirtualNetwork1 and VirtualNetwork3 through VirtualNetwork2.** If you want to create a virtual network peering between VirtualNetwork1 and VirtualNetwork3, you have to create a peering between VirtualNetwork1 and VirtualNetwork3.
      
  - You **can't resolve names in peered virtual networks** using default Azure name resolution. To resolve names in other virtual networks, you **must use Azure DNS** for private domains or a custom DNS server.

  - Resources in peered virtual networks in the same region can communicate with each other with the same bandwidth and latency as if they were in the same virtual network. Each virtual machine size has its own maximum network bandwidth however.

  - A virtual network can be peered to another virtual network, and also be connected to another virtual network with an Azure virtual network gateway. When virtual networks are connected through both peering and a gateway, traffic between the virtual networks flows through the peering configuration, rather than the gateway.

  - There is a nominal charge for ingress and egress traffic that utilizes a virtual network peering.

Source: <https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering#requirements-and-constraints>

## Hub-Spoke Architecture

The hub is a virtual network (VNet) in Azure that acts as a central point of connectivity to your on-premises network. The spokes are VNets that peer with the hub and can be used to isolate workloads. Traffic flows between the on-premises datacenter and the hub through an ExpressRoute or VPN gateway connection.

The architecture consists of the following components.

  - **On-premises network.** A private local-area network running within an organization.

  - VPN device. A device or service that provides external connectivity to the on-premises network. The VPN device may be a hardware device, or a software solution such as the Routing and Remote Access Service (RRAS) in Windows Server 2012. For a list of supported VPN appliances and information on configuring selected VPN appliances for connecting to Azure, see About VPN devices for Site-to-Site VPN Gateway connections.

  - **VPN virtual network gateway or ExpressRoute gateway.** The virtual network gateway enables the VNet to connect to the VPN device, or ExpressRoute circuit, used for connectivity with your on-premises network. For more information, see Connect an on-premises network to a Microsoft Azure virtual network.

  - **Hub VNet.** Azure VNet used as the hub in the hub-spoke topology. The hub is the central point of connectivity to your on-premises network, and a place to host services that can be consumed by the different workloads hosted in the spoke VNets.

  - **Gateway subnet.** The virtual network gateways are held in the same subnet.

  - **Spoke VNets.** One or more Azure VNets that are used as spokes in the hub-spoke topology. Spokes can be used to isolate workloads in their own VNets, managed separately from other spokes. Each workload might include multiple tiers, with multiple subnets connected through Azure load balancers. For more information about the application infrastructure, see Running Windows VM workloads and Running Linux VM workloads.

  - **VNet peering.** Two VNets in the same Azure region can be connected using a peering connection. Peering connections are non-transitive, low latency connections between VNets. Once peered, the VNets exchange traffic by using the Azure backbone, without the need for a router. In a hub-spoke network topology, you use VNet peering to connect the hub to each spoke.

We recommend defining a logical structure of the private address spaces, that can be used in Azure. It is important to keep in mind, that each address space must be flexible for other resources but not overlap with other private address spaces of other VNets or locally used private address spaces. Adress Spaces cannot be changed in peered VNets – the Virtual Networks must be unpeered to add or remove additional address spaces, and then again be peered.

Source: <https://docs.microsoft.com/en-us/office365/enterprise/designing-networking-for-microsoft-azure-iaas>
