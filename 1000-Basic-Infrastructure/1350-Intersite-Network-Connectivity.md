# Intersite network connectivity – integrate Azure in the Corporate Network – the Hub VNET

You can connect your on-premises network to a virtual network using any combination of the following options:

  - **Point-to-site virtual private network (VPN):** Established between a virtual network and a single PC in your network. Each PC that wants to establish connectivity with a virtual network must configure its connection independently. This connection type is great if you're just getting started with Azure, or for developers, because it requires little or no changes to your existing network. The connection uses the SSTP protocol to provide encrypted communication over the Internet between the PC and a virtual network. The latency for a point-to-site VPN is unpredictable, since the traffic traverses the Internet.
  - **Site-to-site VPN:** Established between your VPN device and an Azure VPN Gateway deployed in a virtual network. This connection type enables any on-premises resource you authorize to access a virtual network. The connection is an IPSec/IKE VPN that provides encrypted communication over the Internet between your on-premises device and the Azure VPN gateway. The latency for a site-to-site connection is unpredictable, since the traffic traverses the Internet.
  - **Azure ExpressRoute:** Established between your network and Azure, through an ExpressRoute partner. This connection is private. Traffic does not traverse the Internet. The latency for an ExpressRoute connection is predictable, since traffic doesn't traverse the Internet.
  - **Azure Virtual Network Peering:** Virtual network peering enables you to seamlessly connect Azure virtual networks. Once peered, the virtual networks appear as one, for connectivity purposes. The traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, much like traffic is routed between virtual machines in the same virtual network, through private IP addresses only. 

Source: https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview

## VPN Gateway

A VPN gateway is a type of virtual network gateway that sends encrypted traffic across a public connection to an on-premises location. You can also use VPN gateways to send encrypted traffic between Azure virtual networks over the Microsoft network. To send encrypted network traffic between your Azure virtual network and your on-premises site, you must create a VPN gateway for your virtual network.

Each virtual network can have only one VPN gateway, however, you can create multiple connections to the same VPN gateway. An example of this is a Multi-Site connection configuration. When you create multiple connections to the same VPN gateway, all VPN tunnels, including Point-to-Site VPNs, share the bandwidth that is available for the gateway.

### Configuring a VPN Gateway

A VPN gateway connection relies on multiple resources that are configured with specific settings. Most of the resources can be configured separately, although they must be configured in a certain order in some cases.

Gateway types

Each virtual network can only have one virtual network gateway of each type. When you are creating a virtual network gateway, you must make sure that the gateway type is correct for your configuration.

The available values for -GatewayType are:

  - Vpn

  - ExpressRoute

### Planning 

|                              | **Point-to-Site**                                                                            | **Site-to-Site**                                                                                        | **ExpressRoute**                                                                                                                     |
| ---------------------------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Azure Supported Services** | Cloud Services and Virtual Machines                                                          | Cloud Services and Virtual Machines                                                                     | [Services list](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-faqs#supported-services)                            |
| **Typical Bandwidths**       | Typically \< 100 Mbps aggregate                                                              | Typically \< 1 Gbps aggregate                                                                           | 50 Mbps, 100 Mbps, 200 Mbps, 500 Mbps, 1 Gbps, 2 Gbps, 5 Gbps, 10 Gbps                                                               |
| **Protocols Supported**      | Secure Sockets Tunneling Protocol (SSTP)                                                     | IPsec                                                                                                   | Direct connection over VLANs, NSP's VPN technologies (MPLS, VPLS,...)                                                                |
| **Routing**                  | RouteBased (dynamic)                                                                         | We support PolicyBased (static routing) and RouteBased (dynamic routing VPN)                            | BGP                                                                                                                                  |
| **Connection resiliency**    | active-passive                                                                               | active-passive or active-active                                                                         | active-active                                                                                                                        |
| **Typical use case**         | Prototyping, dev / test / lab scenarios for cloud services and virtual machines              | Dev / test / lab scenarios and small scale production workloads for cloud services and virtual machines | Access to all Azure services (validated list), Enterprise-class and mission critical workloads, Backup, Big Data, Azure as a DR site |
| **SLA**                      | [SLA](https://azure.microsoft.com/support/legal/sla/)                                        | [SLA](https://azure.microsoft.com/support/legal/sla/)                                                   | [SLA](https://azure.microsoft.com/support/legal/sla/)                                                                                |
| **Pricing**                  | [Pricing](https://azure.microsoft.com/pricing/details/vpn-gateway/)                          | [Pricing](https://azure.microsoft.com/pricing/details/vpn-gateway/)                                     | [Pricing](https://azure.microsoft.com/pricing/details/expressroute/)                                                                 |
| **Technical Documentation**  | [VPN Gateway Documentation](https://azure.microsoft.com/documentation/services/vpn-gateway/) | [VPN Gateway Documentation](https://azure.microsoft.com/documentation/services/vpn-gateway/)            | [ExpressRoute Documentation](https://azure.microsoft.com/documentation/services/expressroute/)                                       |
| **FAQ**                      | [VPN Gateway FAQ](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vpn-faq)    | [VPN Gateway FAQ](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vpn-faq)               | [ExpressRoute FAQ](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-faqs)                                            |

For SLA, Pricing and technical documentation see: <https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways>

### Gateway SKUs

The new VPN gateway SKUs streamline the feature sets offered on the gateways:

**SKU	Features**
*Basic*
Route-based VPN: 10 tunnels for S2S/connections; no RADIUS authentication for P2S; no IKEv2 for P2S
Policy-based VPN: (IKEv1): 1 S2S/connection tunnel; no P2S

*VpnGw1, VpnGw2, and VpnGw3*
Route-based VPN: up to 30 tunnels (*), P2S, BGP, active-active, custom IPsec/IKE policy, ExpressRoute/VPN coexistence

The Basic SKU is considered a legacy SKU. The Basic SKU has certain feature limitations. You can't resize a gateway that uses a Basic SKU to one of the new gateway SKUs, you must instead change to a new SKU, which involves deleting and recreating your VPN gateway.

Source: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku

## Site-to-Site and Multi-Site

### Site-to-Site

![](..//media/image16.png)
A Site-to-Site (S2S) VPN gateway connection is a connection over IPsec/IKE (IKEv1 or IKEv2) VPN tunnel. S2S connections can be used for cross-premises and hybrid configurations. A S2S connection requires a VPN device located on-premises that has a public IP address assigned to it and is not located behind a NAT.

### Multi-Site

![](..//media/image17.png)
This type of connection is a variation of the Site-to-Site connection. You create more than one VPN connection from your virtual network gateway, typically connecting to multiple on-premises sites. When working with multiple connections, you must use a RouteBased VPN type . Because each virtual network can only have one VPN gateway, all connections through the gateway share the available bandwidth. This is often called a "multi-site" connection.

Source: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#s2smulti

## Point-to-Site

A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer. A P2S connection is established by starting it from the client computer. This solution is useful for telecommuters who want to connect to Azure VNets from a remote location, such as from home or a conference. P2S VPN is also a useful solution to use instead of S2S VPN when you have only a few clients that need to connect to a VNet.

Unlike S2S connections, P2S connections do not require an on-premises public-facing IP address or a VPN device. P2S connections can be used with S2S connections through the same VPN gateway, as long as all the configuration requirements for both connections are compatible.

Source: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#P2S

![](..//media/image18.png)

## Express Route

Microsoft Azure ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection facilitated by a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure, Office 365, and CRM Online.

ExpressRoute connections do not go over the public Internet. This allows ExpressRoute connections to offer more reliability, faster speeds, lower latencies, and higher security than typical connections over the Internet.

An ExpressRoute connection does not use a VPN gateway, although it does use a virtual network gateway as part of its required configuration. In an ExpressRoute connection, the virtual network gateway is configured with the gateway type 'ExpressRoute', rather than 'Vpn'.

### What is Azure ExpressRoute?

When talking about ExpressRoute, in most cases an ExpressRoute circuit is referenced. An ExpressRoute circuit represents the logical connection between your on-premises infrastructure and Microsoft cloud services through a connectivity provider. So when thinking about using Azure ExpressRoute, it is important to be aware that there is always a connectivity provider involved. You need to consider this when it comes to overall costs of ExpressRoute.

It is possible to order multiple ExpressRoute circuits. Each circuit can be in the same or different regions, and can be connected to on premises through different connectivity providers. A circuit has a fixed bandwidth and is mapped to exactly one connectivity provider and one peering location (e.g. West Europe).

#### Common scenarios

There obviously exist a variety of reasons to implement ExpressRoute. The following scenarios are probably the most common ones:

- Storage, backup and recovery
- BI and big data (working with big amounts of data in the cloud)
- Hybrid apps (e.g. app in the cloud and database on premise)

Unlike Site-to-Site VPN which only works for IaaS, Azure ExpressRoute can be used with various other public services (e.g. Websites, IoT, Backup, database services).

#### Encryption of traffic

Although ExpressRoute is a private connection, traffic flowing over the network is **not encrypted**. Encryption in transit can be achieved by encrypting traffic flowing over the connection.

If you wish to encrypt your traffic over ExpressRoute, you have three options:

- Application level encryption
- IPsec Site-to-Site VPN over ExpressRoute using Azure VPN Gateways. Check out ExpressRoute documentation for guidance about how to configure a site-to-site VPN over ExpressRoute Microsoft peering: https://docs.microsoft.com/en-gb/azure/expressroute/site-to-site-vpn-over-microsoft-peering
- Third-party appliance that performs encryption of traffic flowing over ExpressRoute. For example by deploying physical and/or virtual encryption devices on both sides (e.g. Fortinet, F5, Steelhead, etc)

Source: Stefan Johner: https://blog.jhnr.ch/2018/05/29/azure-expressroute-overview/ , 2018

### Connectivity Models

![](..//media/expressroute-connectivity-models-diagram.png) 

#### Co-located at a cloud exchange

If you are co-located in a facility with a cloud exchange, you can order virtual cross-connections to the Microsoft cloud through the co-location provider’s Ethernet exchange. Co-location providers can offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the co-location facility and the Microsoft cloud.

#### Point-to-point Ethernet connections
You can connect your on-premises datacenters/offices to the Microsoft cloud through point-to-point Ethernet links. Point-to-point Ethernet providers can offer Layer 2 connections, or managed Layer 3 connections between your site and the Microsoft cloud.

####  Any-to-any (IPVPN) networks
You can integrate your WAN with the Microsoft cloud. IPVPN providers (typically MPLS VPN) offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it look just like any other branch office. WAN providers typically offer managed Layer 3 connectivity. ExpressRoute capabilities and features are all identical across all of the above connectivity models.

Source: https://docs.microsoft.com/en-us/azure/expressroute/expressroute-connectivity-models

### ExpressRoute Providers

If you're looking for an ExpressRoute service-provider, we recommend visiting the following site, for an up-to-date list of each provider broken down by location: https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations-providers

### Bandwidth Options
You can an up-to-date list of the currently available bandwith options under the folowing site: https://docs.microsoft.com/en-gb/azure/expressroute/expressroute-introduction#bandwidth-options

[Recommendations]: # "start"

## Recommendations

To connect your on-premise location with your Hub-VNet in Azure, we recommend setting one VPN Connection (Site-2-Site) to Azure in main VNet “Company-VNet”, peer all VNets of the subscriptions with the main VNet, so all resources can communicate with each other. Secure traffic with NSGs. Keep the maximum available bandwidth in mind (1.25 GB with the VPN Gateway 3).

<https://docs.microsoft.com/en-us/azure/security/azure-security-network-security-best-practices>

| Recommendations   for cloud connectivity              ||
| ----------------------------------------------------- | ------------------------------------------------------------ |
| Optimize intranet   connectivity to your edge network | Over the years, many organizations have optimized intranet connectivity and   performance to applications running in on-premises datacenters. With   productivity and IT workloads running in the Microsoft cloud, additional   investment must ensure high-connectivity availability and that traffic   performance between your edge network and your intranet users is optimal. |
| Optimize   throughput at your edge network            | As more of your day-to-day productivity traffic travels to the cloud, you should   closely examine the set of systems at your edge network to ensure that they   are current, provide high availability, and have sufficient capacity to meet   peak loads. |
| For a high SLA use   ExpressRoute                     | Although you can utilize your current Internet connection from your edge network, traffic to and from Microsoft cloud services must share the pipe with other intranet traffic going to the Internet. In addition, your traffic to   Microsoft cloud services is subject to Internet traffic congestion. For a   high SLA and the best performance, use ExpressRoute, a dedicated WAN   connection between your network and Azure. ExpressRoute can leverage your   existing network provider for a dedicated connection. Resources connected by   ExpressRoute appear as if they are on your WAN, even for geographically   distributed organizations |
| Analyse your   current network                        | - Analyse your client   computers and optimize for network hardware, software drivers, protocol   settings, and Internet browsers.  <br />- Analyse your on-premises   network for traffic latency and optimal routing to the Internet edge device.  <br />- Analyse the capacity and   performance of your Internet edge device and optimize for higher levels of   traffic.  <br />- Analyse the latency   between your Internet edge device (such as your external firewall) and the   regional locations of the Microsoft cloud service to which you are   connecting.  <br />- Analyse the capacity and   utilization of your current Internet connection and add capacity if needed.   Alternately, add an ExpressRoute connection. |
| Plan and design   networking for Azure                | - Prepare your intranet for   Microsoft cloud services.  <br />- Optimize your Internet   bandwidth.  <br />- Determine the type of   VNet (cloud-only or cross-premises).  <br />- Determine the address   space of the VNet.<br />- Determine the subnets   within the VNet and the address spaces assigned to each.<br />- Determine the DNS server   configuration and the addresses of the DNS servers to assign to VMs in the   VNet.<br />- Determine the load   balancing configuration (Internet-facing or internal).<br />- Determine the use of   virtual appliances and user-defined routes.<br />- Determine how computers   from the Internet will connect to virtual machines.<br />- For multiple VNets,   determine the VNet-to-VNet connection topology.<br />- Determine the on-premises   connection to the VNet (S2S VPN or ExpressRoute).<br />- Determine the on-premises   VPN device or router.<br />- Add routes to make the   address space of the VNet reachable.<br />- For ExpressRoute, plan for the new connection with   your provider.<br />- Determine the Local Network address space for the   Azure gateway.  <br />- Configure on-premises DNS servers for DNS   replication with DNS servers hosted in Azure.  *Determine the use of forced tunneling and   user-defined routes. |

[Recommendations]: # "end"

## Azure Network Peering

### Overview
Virtual network peering enables you to seamlessly connect Azure virtual networks. Once peered, the virtual networks appear as one, for connectivity purposes. The traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, much like traffic is routed between virtual machines in the same virtual network, through private IP addresses only. Azure supports:

  - VNet peering - connecting VNets within the same Azure region
  - Global VNet peering - connecting VNets across Azure regions

The benefits of using virtual network peering, whether local or global, include:

  - Network traffic between peered virtual networks is private. Traffic between the virtual networks is kept on the Microsoft backbone network. No public Internet, gateways, or encryption is required in the communication between the virtual networks.
  - A low-latency, high-bandwidth connection between resources in different virtual networks.
  - The ability for resources in one virtual network to communicate with resources in a different virtual network, once the virtual networks are peered.
  - The ability to transfer data across Azure subscriptions, deployment models, and across Azure regions.
  - The ability to peer virtual networks created through the Azure Resource Manager. 
  - No downtime to resources in either virtual network when creating the peering, or after the peering is created.

### Requirements and Constraints

  - **You can peer virtual networks in the same region, or different regions**. The following constraints do **not** apply when both virtual networks are in the same region, but do apply when the virtual networks are globally peered:
    
      - The virtual networks can exist in any Azure public cloud region, but not in Azure national clouds.
      
      - Resources in one virtual network cannot communicate with the IP address of an Azure internal load balancer in the peered virtual network. The load balancer and the resources that communicate with it must be in the same virtual network.
      
      - **You cannot use remote gateways or allow gateway transit**. To use remote gateways or allow gateway transit, both virtual networks in the peering must exist in the same region.
      
      - Communication across globally peered virtual networks through the following VM types is not supported: **High performance compute and GPU**. This includes H, NC, NV, NCv2, NCv3, and ND series VMs.

  - The virtual networks can be in **the same, or different subscriptions**. If you don't already have an AD tenant, you can quickly create one. You can use a VPN Gateway to connect two virtual networks that exist in different subscriptions that are associated to different Active Directory tenants.

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

### Connectivity

After virtual networks are peered, resources in either virtual network can directly connect with resources in the peered virtual network.

The network latency between virtual machines in peered virtual networks in the same region is the same as the latency within a single virtual network. The network throughput is based on the bandwidth that's allowed for the virtual machine, proportionate to its size. There isn't any additional restriction on bandwidth within the peering.

The traffic between virtual machines in peered virtual networks is routed directly through the Microsoft backbone infrastructure, not through a gateway or over the public Internet.

### Service chaining
You can configure user-defined routes that point to virtual machines in peered virtual networks as the next hop IP address, or to virtual network gateways, to enable service chaining. Service chaining enables you to direct traffic from one virtual network to a virtual appliance, or virtual network gateway, in a peered virtual network, through user-defined routes.

You can deploy hub-and-spoke networks, where the hub virtual network can host infrastructure components such as a network virtual appliance or VPN gateway. All the spoke virtual networks can then peer with the hub virtual network. Traffic can flow through network virtual appliances or VPN gateways in the hub virtual network.

Virtual network peering enables the next hop in a user-defined route to be the IP address of a virtual machine in the peered virtual network, or a VPN gateway. You cannot however, route between virtual networks with a user-defined route specifying an ExpressRoute gateway as the next hop type. 

### Pricing
There is a nominal charge for ingress and egress traffic that utilizes a virtual network peering connection.

Gateway transit is a peering property that enables a virtual network to utilize a VPN/ExpressRoute gateway in a peered virtual network for cross premises or VNet-to-VNet connectivity. Traffic passing through a remote gateway in this scenario is subject to VPN gateway charges or ExpressRoute gateway charges and does not incur VNet peering charges. For example, If VNetA has a VPN gateway for on-premises connectivity and VNetB is peered to VNetA with appropriate properties configured, traffic from VNetB to on-premises is only charged egress per VPN gateway pricing or ExpressRoute pricing. VNet peering charges do not apply.

The price for 100 GB in and/or out is currently (August 2019) $1 within the same region and $3.5 between regions.

## Protecting virtual networks

We recommend locking all Network resources to “CanNotDelete”.

## Network Security Groups

A network security group (NSG) contains a list of security rules that allow or deny network traffic to resources connected to Azure Virtual Networks (VNet). NSGs can be associated to subnets or individual network interfaces (NIC) attached to VMs (Resource Manager). When an NSG is associated to a subnet, the rules apply to all resources connected to the subnet. Traffic can further be restricted by also associating an NSG to a VM or NIC.

NSGs contain two sets of rules: Inbound and outbound. The priority for a rule must be unique within each set. All NSGs contain a set of default rules. The default rules cannot be deleted, but because they are assigned the lowest priority, they can be overridden by the rules that you create.

The default rules allow and disallow traffic as follows:

- **Virtual network:** Traffic originating and ending in a virtual network is allowed both in inbound and outbound directions.

- **Internet:** Outbound traffic is allowed, but inbound traffic is blocked.

- **Load balancer:** Allow Azure Load Balancer to probe the health of your VMs and role instances. If you override this rule, Azure Load Balancer health probes will fail which could cause impact to your service.

### Forced Tunneling

Recommended to enable for point-to-site connections.

## Application Security Groups (ASG)

### Network security micro segmentation

ASGs enable you to define fine-grained network security policies based on workloads, centralized on applications, instead of explicit IP addresses. Provides the capability to group VMs with monikers and secure applications by filtering traffic from trusted segments of your network.

Implementing granular security traffic controls improves isolation of workloads and protects them individually. If a breach occurs, this technique limits the potential impact of lateral exploration of your networks from hackers.

### Security definition simplified

With ASGs, filtering traffic based on applications patterns is simplified, using the following steps:

- Define your application groups, provide a moniker descriptive name that fits your architecture. You can use it for applications, workload types, systems, tiers, environments or any role.
- Define a single collection of rules using ASGs and Network Security Groups (NSG), you can apply a single NSG to your entire virtual network on all subnets. A single NSG gives you full visibility on your traffic policies, and a single place for management.
- Scale at your own pace. When you deploy VMs, make them members of the appropriate ASGs. If your VM is running multiple workloads, just assign multiple ASGs. Access is granted based on your workloads. No need to worry about security definition again. More importantly, you can implement a zero-trust model, limiting access to the application flows that are explicitly permitted.

### Single network security policy

ASGs introduce the ability to deploy multiple applications within the same subnet, and isolate traffic based on ASGs. With ASGs you can reduce the number of NSGs in your subscription. In some cases, you can use a single NSG for multiple subnets of your virtual network. ASGs enable you to centralize your configuration, providing the following benefits in dynamic environments:

- **Centralized NSG view:** All traffic policies in a single place. It’s easy to operate and manage changes. If you need to allow a new port to or from a group of VMs, you can make a change to a single rule.
- **Centralized logging:** In combination with NSG flow logs, a single configuration for logs has multiple advantages for traffic analysis.
- **Enforce policies:** If you need to deny specific traffic, you can add a security rule with high priority and enforce administrative rules.

### Filtering east-west traffic

With ASGs, you can isolate multiple workloads and provide additional levels of protection for your virtual network.

In the following illustration, multiple applications are deployed into the same virtual network. Based on the security rules described, workloads are isolated from each other. If a VM from one of the applications is compromised, lateral exploration is limited, minimizing the potential impact of an attacker.

In this example, let’s assume one of the web server VMs from application1 is compromised, the rest of the application will continue to be protected, even access to critical workloads like database servers will still be unreachable. This implementation provides multiple extra layers of security to your network, making this intrusion less harmful and easy to react on such events.

![EastWest Traffic Example](<../media/EastWest.png>)

### Filtering north-south traffic

In combination with additional features on NSG, you can also isolate your workloads from on premises and azure services in different scenarios.

In the following illustration, a relatively complex environment is configured for multiple workload types within a virtual network. By describing their security rules, applications have the correct set of policies applied on each VM. Similar to the previous example, if one of your branches is compromised, exploration within the virtual network is limited therefore minimizing the potential impact of an intruder.

In this example, let’s assume someone on one of your branches connected using VPN, compromise a workstation and has access to your network. Normally only a subset of your network is required for this branch, by isolating the rest of your network; all other applications will continue to be protected and unreachable. ASGs another layers of security to your entire network.

Another interesting scenario, assuming you have detected a breach on one of your web servers, a good idea would be to isolate the VM for investigation. With ASGs, you can easily assign a special group predefined for quarantine VMs on your first security policy. These VMs lose access providing an additional benefit to help you react and mitigate this treats.

![NorthSouth Traffic Example](<../media/NorthSouth.png>)

### Summary

Application Security Groups along with the latest improvements in NSGs, have brought multiple benefits on the network security area, such as a single management experience, increased limits on multiple dimensions, a great level of simplification, and a natural integration with your architecture, begin today and experience these capabilities on your virtual networks.

Source: <https://azure.microsoft.com/en-in/blog/applicationsecuritygroups/>

### Virtual network appliances

While Network Security Groups and User Defined Routing can provide a certain measure of network security at the network and transport layers of the OSI model, there are going to be situations where you’ll want or need to enable security at high levels of the stack. In such situations, we recommend that you deploy virtual network security appliances provided by Azure partners.

Azure network security appliances can deliver significantly enhanced levels of security over what is provided by network level controls. Some of the network security capabilities provided by virtual network security appliances include:

  - Firewalling

  - Intrusion detection/Intrusion Prevention

  - Vulnerability management

  - Application control

  - Network-based anomaly detection

  - Web filtering

  - Antivirus

  - Botnet protection

  - If you require a higher level of network security than you can obtain with network level access controls, then we recommend that you investigate and deploy Azure virtual network security appliances.

Sources: <https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways?toc=%2fazure%2fvirtual-network%2ftoc.json#diagrams>, <https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings>
