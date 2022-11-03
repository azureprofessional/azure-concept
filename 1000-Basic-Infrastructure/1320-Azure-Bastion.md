Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal, or via the native SSH or RDP client already installed on your local computer. The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly from the Azure portal over TLS. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

## <a name="key"></a>Key benefits

|Benefit    |Description|
|-----------|-----------|
|RDP and SSH through the Azure portal|You can get to the RDP and SSH session directly in the Azure portal using a single-click seamless experience.|
|Remote Session over TLS and firewall traversal for RDP/SSH|Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device. Your RDP/SSH session is over TLS on port 443. This enables the traffic to traverse firewalls more securely.|
|No Public IP address required on the Azure VM| Azure Bastion opens the RDP/SSH connection to your Azure VM by using the private IP address on your VM. You don't need a public IP address on your virtual machine.|
|No hassle of managing Network Security Groups (NSGs)| You don't need to apply any NSGs to the Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only. This removes the hassle of managing NSGs each time you need to securely connect to your virtual machines. For more information about NSGs, see [Network Security Groups](../virtual-network/network-security-groups-overview.md#security-rules).|
|No need to manage a separate bastion host on a VM |Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity.|
|Protection against port scanning|Your VMs are protected against port scanning by rogue and malicious users because you don't need to expose the VMs to the internet.|
|Hardening in one place only|Azure Bastion sits at the perimeter of your virtual network, so you don’t need to worry about hardening each of the VMs in your virtual network.|
|Protection against zero-day exploits |The Azure platform protects against zero-day exploits by keeping the Azure Bastion hardened and always up to date for you.|

## <a name="sku"></a>SKUs

Azure Bastion has two available SKUs, Basic and Standard. For more information, including how to upgrade a SKU, see the [Configuration settings](configuration-settings.md#skus) article.

The following table shows features and corresponding SKUs.

| Feature | Basic SKU | Standard SKU |
|---|---|---|
| Connect to target VMs in peered virtual networks | [Yes](../articles/bastion/vnet-peering.md) |  [Yes](../articles/bastion/vnet-peering.md)|
| Access Linux VM Private Keys in Azure Key Vault (AKV) | Yes | Yes |
| Connect to Linux VM using SSH | [Yes](../articles/bastion/bastion-connect-vm-ssh-linux.md) | [Yes](../articles/bastion/bastion-connect-vm-ssh-linux.md)|
| Connect to Windows VM using RDP | [Yes](../articles/bastion/bastion-connect-vm-rdp-windows.md) | [Yes](../articles/bastion/bastion-connect-vm-rdp-windows.md)|
| Kerberos authentication | [Yes](../articles/bastion/kerberos-authentication-portal.md) |[Yes](../articles/bastion/kerberos-authentication-portal.md)|
| VM audio output | Yes | Yes |
| Connect to VMs using a native client | No | [Yes](../articles/bastion/connect-native-client-windows.md)|
| Connect to VMs via IP address | No | [Yes](../articles/bastion/connect-ip-address.md)
| Host scaling |  No  | [Yes](../articles/bastion/configuration-settings.md#instance) |
| Specify custom inbound port | No | [Yes](../articles/bastion/configuration-settings.md#ports)|
| Connect to Linux VM using RDP |  No | [Yes](../articles/bastion/bastion-connect-vm-rdp-linux.md)|
| Connect to Windows VM using SSH |  No  | [Yes](../articles/bastion/bastion-connect-vm-ssh-windows.md)|
| Upload or download files |  No  | [Yes](../articles/bastion/vm-upload-download-native.md)|
| Disable copy/paste (web-based clients) |  No  | Yes |

Source: https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/bastion/bastion-overview.md?plain=1
