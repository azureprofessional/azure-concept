# Intersite network connectivity – integrate Azure in the Corporate Network – the Hub VNET

You can connect your on-premises network to a virtual network using any combination of the following options:

  - **Point-to-site virtual private network (VPN):** Established between a virtual network and a single PC in your network. Each PC that wants to establish connectivity with a virtual network must configure its connection independently. This connection type is great if you're just getting started with Azure, or for developers, because it requires little or no changes to your existing network. The connection uses the SSTP protocol to provide encrypted communication over the Internet between the PC and a virtual network. The latency for a point-to-site VPN is unpredictable, since the traffic traverses the Internet.

  - **Site-to-site VPN:** Established between your VPN device and an Azure VPN Gateway deployed in a virtual network. This connection type enables any on-premises resource you authorize to access a virtual network. The connection is an IPSec/IKE VPN that provides encrypted communication over the Internet between your on-premises device and the Azure VPN gateway. The latency for a site-to-site connection is unpredictable, since the traffic traverses the Internet.

  - **Azure ExpressRoute:** Established between your network and Azure, through an ExpressRoute partner. This connection is private. Traffic does not traverse the Internet. The latency for an ExpressRoute connection is predictable, since traffic doesn't traverse the Internet.
  
  - **Azure Virtual Network Peering:** Virtual network peering enables you to seamlessly connect Azure virtual networks. Once peered, the virtual networks appear as one, for connectivity purposes. The traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, much like traffic is routed between virtual machines in the same virtual network, through private IP addresses only. (https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview) 

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

<table>
<thead>
<tr class="header">
<th>SKU</th>
<th>S2S/VNet-to-VNet<br />
Tunnels</th>
<th>P2S<br />
Connections</th>
<th>Aggregate<br />
Throughput Benchmark</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>VpnGw1</td>
<td>Max. 30</td>
<td>Max. 128</td>
<td>650 Mbps</td>
</tr>
<tr class="even">
<td>VpnGw2</td>
<td>Max. 30</td>
<td>Max. 128</td>
<td>1 Gbps</td>
</tr>
<tr class="odd">
<td>VpnGw3</td>
<td>Max. 30</td>
<td>Max. 128</td>
<td>1.25 Gbps</td>
</tr>
<tr class="even">
<td>Basic</td>
<td>Max. 10</td>
<td>Max. 128</td>
<td>100 Mbps</td>
</tr>
</tbody>
</table>

## Site-to-Site and Multi-Site

### Site-to-Site

![](..//media/image16.png)
A Site-to-Site (S2S) VPN gateway connection is a connection over IPsec/IKE (IKEv1 or IKEv2) VPN tunnel. S2S connections can be used for cross-premises and hybrid configurations. A S2S connection requires a VPN device located on-premises that has a public IP address assigned to it and is not located behind a NAT.

### Multi-Site

![](..//media/image17.png)
This type of connection is a variation of the Site-to-Site connection. You create more than one VPN connection from your virtual network gateway, typically connecting to multiple on-premises sites. When working with multiple connections, you must use a RouteBased VPN type (known as a dynamic gateway when working with classic VNets). Because each virtual network can only have one VPN gateway, all connections through the gateway share the available bandwidth. This is often called a "multi-site" connection.

## Point-to-Site

A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer. A P2S connection is established by starting it from the client computer. This solution is useful for telecommuters who want to connect to Azure VNets from a remote location, such as from home or a conference. P2S VPN is also a useful solution to use instead of S2S VPN when you have only a few clients that need to connect to a VNet.

Unlike S2S connections, P2S connections do not require an on-premises public-facing IP address or a VPN device. P2S connections can be used with S2S connections through the same VPN gateway, as long as all the configuration requirements for both connections are compatible.

![](..//media/image18.png)

## VNet-to-VNet
![](..//media/image19.png) 

Connecting a virtual network to another virtual network (VNet-to-VNet) is similar to connecting a VNet to an on-premises site location. Both connectivity types use a VPN gateway to provide a secure tunnel using IPsec/IKE. You can even combine VNet-to-VNet communication with multi-site connection configurations. This lets you establish network topologies that combine cross-premises connectivity with inter-virtual network connectivity.

The VNets you connect can be:

  - in the same or different regions

  - in the same or different subscriptions

  - in the same or different deployment models

## Express Route

Microsoft Azure ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection facilitated by a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure, Office 365, and CRM Online. Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a co-location facility.

ExpressRoute connections do not go over the public Internet. This allows ExpressRoute connections to offer more reliability, faster speeds, lower latencies, and higher security than typical connections over the Internet.

An ExpressRoute connection does not use a VPN gateway, although it does use a virtual network gateway as part of its required configuration. In an ExpressRoute connection, the virtual network gateway is configured with the gateway type 'ExpressRoute', rather than 'Vpn'.

## Recommendations

To connect your on-premise location with your Hub-VNet in Azure, we recommend setting one VPN Connection (Site-2-Site) to Azure in main VNet “Company-VNet”, peer all VNets of the subscriptions with the main VNet, so all resources can communicate with each other. Secure traffic with NSGs. Keep the maximum available bandwidth in mind (1.25 GB with the VPN Gateway 3).

<https://docs.microsoft.com/en-us/azure/security/azure-security-network-security-best-practices>

<table>
<thead>
<tr class="header">
<th>Recommendations for cloud connectivity</th>
<th></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Optimize intranet connectivity to your edge network</td>
<td>Over the years, many organizations have optimized intranet connectivity and performance to applications running in on-premises datacenters. With productivity and IT workloads running in the Microsoft cloud, additional investment must ensure high-connectivity availability and that traffic performance between your edge network and your intranet users is optimal.</td>
</tr>
<tr class="even">
<td>Optimize throughput at your edge network</td>
<td>As more of your day-to-day productivity traffic travels to the cloud, you should closely examine the set of systems at your edge network to ensure that they are current, provide high availability, and have sufficient capacity to meet peak loads.</td>
</tr>
<tr class="odd">
<td>For a high SLA use ExpressRoute</td>
<td>Although you can utilize your current Internet connection from your edge network, traffic to and from Microsoft cloud services must share the pipe with other intranet traffic going to the Internet. In addition, your traffic to Microsoft cloud services is subject to Internet traffic congestion. For a high SLA and the best performance, use ExpressRoute, a dedicated WAN connection between your network and Azure. ExpressRoute can leverage your existing network provider for a dedicated connection. Resources connected by ExpressRoute appear as if they are on your WAN, even for geographically distributed organizations</td>
</tr>
<tr class="even">
<td>Analyze your current network</td>
<td><ul>
<li><p>Analyze your client computers and optimize for network hardware, software drivers, protocol settings, and Internet browsers.</p></li>
<li><p>Analyze your on-premises network for traffic latency and optimal routing to the Internet edge device.</p></li>
<li><p>Analyze the capacity and performance of your Internet edge device and optimize for higher levels of traffic.</p></li>
<li><p>Analyze the latency between your Internet edge device (such as your external firewall) and the regional locations of the Microsoft cloud service to which you are connecting.</p></li>
<li><p>Analyze the capacity and utilization of your current Internet connection and add capacity if needed. Alternately, add an ExpressRoute connection.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td>Plan and design networking for Azure</td>
<td><ul>
<li><p>Prepare your intranet for Microsoft cloud services.</p></li>
<li><p>Optimize your Internet bandwidth.</p></li>
<li><p>Determine the type of VNet (cloud-only or cross-premises).</p></li>
<li><p>Determine the address space of the VNet.</p></li>
<li><p>Determine the subnets within the VNet and the address spaces assigned to each.</p></li>
<li><p>Determine the DNS server configuration and the addresses of the DNS servers to assign to VMs in the VNet.</p></li>
<li><p>Determine the load balancing configuration (Internet-facing or internal).</p></li>
<li><p>Determine the use of virtual appliances and user-defined routes.</p></li>
<li><p>Determine how computers from the Internet will connect to virtual machines.</p></li>
<li><p>For multiple VNets, determine the VNet-to-VNet connection topology.</p></li>
<li><p>Determine the on-premises connection to the VNet (S2S VPN or ExpressRoute).</p></li>
<li><p>Determine the on-premises VPN device or router.</p></li>
<li><p>Add routes to make the address space of the VNet reachable.</p></li>
</ul>
<ul>
<li><p>For ExpressRoute, plan for the new connection with your provider.</p></li>
<li><p>Determine the Local Network address space for the Azure gateway.</p></li>
<li><p>Configure on-premises DNS servers for DNS replication with DNS servers hosted in Azure.</p></li>
<li><p>Determine the use of forced tunneling and user-defined routes.</p></li>
</ul></td>
</tr>
</tbody>
</table>

## Protecting virtual networks

We recommend locking all Network resources to “CanNotDelete” (see section 16.4).

### Network Security Groups

A network security group (NSG) contains a list of security rules that allow or deny network traffic to resources connected to Azure Virtual Networks (VNet). NSGs can be associated to subnets, individual VMs (classic), or individual network interfaces (NIC) attached to VMs (Resource Manager). When an NSG is associated to a subnet, the rules apply to all resources connected to the subnet. Traffic can further be restricted by also associating an NSG to a VM or NIC.

NSGs contain two sets of rules: Inbound and outbound. The priority for a rule must be unique within each set.

![NSG rule processing](..//media/image20.png)

All NSGs contain a set of default rules. The default rules cannot be deleted, but because they are assigned the lowest priority, they can be overridden by the rules that you create.

The default rules allow and disallow traffic as follows:

  - **Virtual network:** Traffic originating and ending in a virtual network is allowed both in inbound and outbound directions.

  - **Internet:** Outbound traffic is allowed, but inbound traffic is blocked.

  - **Load balancer:** Allow Azure Load Balancer to probe the health of your VMs and role instances. If you override this rule, Azure Load Balancer health probes will fail which could cause impact to your service.

### Forced tunneling

Recommended to enable for point-to-site connections.

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
