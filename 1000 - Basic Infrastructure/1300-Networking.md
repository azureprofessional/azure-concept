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
