# Azure Virtual Machines

## Overview

Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer. 

An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it.

Azure virtual machines can be used in various ways. Some examples are:

- **Development and test** – Azure VMs offer a quick and easy way to create a computer with specific configurations required to code and test an application.
- **Applications in the cloud** – Because demand for your application can fluctuate, it might make economic sense to run it on a VM in Azure. You pay for extra VMs when you need them and shut them down when you don’t.
- **Extended datacenter** – Virtual machines in an Azure virtual network can easily be connected to your organization’s network.

The number of VMs that your application uses can scale up and out to whatever is required to meet your needs.

## Azure Virtual Machines
### Types and Sizes

Azure VMs are available in several different types and sizes. These sizes define the resources available to the VM, like vCPU and Memory, but also what limitations the machine is subjected to, like the amount of NICs or data disks assignable to the VM.

To cover the broad range of possible applications virtual machines can be used for, Azure offers a wide amount of possible VM-sizes to its consumers. Each size offers a different arrangement of resources and limitations. 
The following table sorts the available VM-sizes in six categories and provides a short explanation on what the intended application-purpose is for the given category.

| Type                     | Sizes                                                  | Description                                                                                                                                                                                     |
|--------------------------|--------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [General  purpose](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general)         | B, Dsv3, Dv3, DSv2, Dv2, Av2, DC                       | Balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers.                                                              |
| [Compute optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-compute)        | Fsv2                                                   | High CPU-to-memory ratio. Good for medium traffic web servers, network appliances, batch processes, and application servers.                                                                    |
| [Memory optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-memory)         | Esv3, Ev3, Mv2, M, DSv2, Dv2                           | High memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics.                                                                               |
| [Storage optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-storage)        | Lsv2                                                   | High disk throughput and IO ideal for Big Data, SQL, NoSQL databases, data warehousing and large transactional databases.                                                                       |
| [GPU](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-gpu)                      | NC, NCv2, NCv3, ND, NDv2 (Preview), NV, NVv3 (Preview) | Specialized virtual machines targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND) with deep learning. Available with single or multiple GPUs. |
| [High performance compute](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-hpc) | HB, HC, H                                              | Our fastest and most powerful CPU virtual machines with optional high-throughput network interfaces (RDMA).                                                                                     |

### Operating Systems

Azure provides a variety of OS images that you can install into the VM, including several versions of Windows and Linux. The choice of OS will influence your hourly compute pricing as Azure bundles the cost of the OS license into the price.

Additionally, if you are looking for more than just base OS images, you can search the Azure Marketplace for more sophisticated install images that include the OS and popular software tools installed for specific scenarios. For example, if you needed a new WordPress site instead of setting up and configuring each component, you can leverage a Marketplace image and install the required stack all at once.

Finally, if you can't find a suitable OS image, you can create your disk image with what you need, upload it to Azure storage, and use it to create an Azure VM. It is to note however, that Azure only supports 64-bit operating systems.

#### Azure Hybrid Benefit

For customers with Software Assurance, Azure Hybrid Benefit for Windows Server allows you to use your on-premises Windows Server licenses and run Windows virtual machines on Azure at a reduced cost. 

## VM Scale Sets

### Overview

Virtual machine scale sets are an Azure Compute resource you can use to deploy and manage a set of identical VMs. With all VMs configured the same, VM scale sets are designed to support true auto-scaling and as such makes it easier to build large-scale services targeting big compute, big data, and containerized workloads. So, as demand goes up more virtual machine instances can be added, and as demand goes down virtual machines instances can be removed. The process can be manual or automated or a combination of both.

![VM_Scale_Sets](..\media\VM_Scale_Sets.png)

Scale sets works in a way that provides many benefits.

- All VM instances are created from the same base OS image and configuration. This approach lets you easily manage hundreds of VMs without additional configuration tasks or network management.


- Scale sets support the use of the Azure load balancer for basic layer-4 traffic distribution, and Azure Application Gateway for more advanced layer-7 traffic distribution and SSL termination.

- Scale sets are used to run multiple instances of your application. If one of these VM instances has a problem, customers continue to access your application through one of the other VM instances with minimal interruption.

- Customer demand for your application may change throughout the day or week. To match customer demand, scale sets can automatically increase the number of VM instances as application demand increases, then reduce the number of VM instances as demand decreases.

- Scale sets support up to 1,000 VM instances. If you create and upload your own custom VM images, the limit is 300 VM instances.

### Differences between Virtual Machines and Scale Sets

Scale sets are built from virtual machines. With scale sets, the management and automation layers are provided to run and scale your applications. You could instead manually create and manage individual VMs, or integrate existing tools to build a similar level of automation. The following table outlines the benefits of scale sets compared to manually managing multiple VM instances.

| Scenario                           | Manual group of VMs                                          | Virtual machine scale set                                    |
| ---------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Add additional VM instances        | Manual process to create, configure, and ensure compliance   | Automatically create from central configuration              |
| Traffic balancing and distribution | Manual process to create and configure Azure load balancer or Application Gateway | Can automatically create and integrate with Azure load balancer or Application Gateway |
| High availability and redundancy   | Manually create Availability Set or distribute and track VMs across Availability Zones | Automatic distribution of VM instances across Availability Zones or Availability Sets |
| Scaling of VMs                     | Manual monitoring and Azure Automation                       | Autoscale based on host metrics, in-guest metrics, Application Insights, or schedule |

There is no additional cost to scale sets. You only pay for the underlying compute resources such as the VM instances, load balancer, or Managed Disk storage. The management and automation features, such as autoscale and redundancy, incur no additional charges over the use of VMs.

## Extensions

Azure virtual machine extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or a configuration script inside, a VM extension can be used. Extensions are all about managing your virtual machines.

Azure VM extensions can be:

- Managed with Azure CLI, PowerShell, Azure Resource Manager templates, and the Azure portal.
- Bundled with a new VM deployment or run against any existing system. For example, they can be part of a larger deployment, configuring applications on VM provision, or run against any supported extension operated systems post deployment.

### Azure VM Agent

To handle the extension on the VM, you need the Azure Windows Agent installed. The Azure VM agent manages interactions between an Azure VM and the Azure fabric controller. The VM agent is responsible for many functional aspects of deploying and managing Azure VMs, including running VM extensions. The Azure VM agent is preinstalled on Azure Marketplace images, and can be installed manually on supported operating systems.

## Sources

[Azure Virtual Machines Documentation](<https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview>)

[Azure Virtual Machine Scale Sets Documentation](https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)

[Azure VM Extensions Documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/overview)

[Limitations for VMs in Azure](<https://docs.microsoft.com/en-us/azure/azure-subscription-service-limits#virtual-machines-limits>)

