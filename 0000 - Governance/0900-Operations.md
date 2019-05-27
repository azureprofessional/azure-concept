# Operating Azure IaaS Service

We recommend taking advantage of cloud scale infrastructure and increase ease of deployment through a unified “IT Management as a Service,” which is called Microsoft Operations Management Suite (OMS). Management capabilities such as monitoring, backup, automation, and so forth are delivered as a service from the cloud that connects all of the servers in all environments (on-premises, Azure, and other clouds such as AWS) and allows IT staff to centrally manage operations. OMS consist of the following 4 modules:

  - Log Analytics Gain visibility across your Hybrid Enterprise Cloud

  - Automation Orchestrate complex and repetitive operations

  - Availability Increase data protection and application availability

  - Security Help secure your workloads, servers, and users

## Gaining operational insights

Today traditional IT is usually using multiple different tools for platform and application monitoring, network monitoring, and Security Analysis. Extending those tools to the cloud is challenging in various aspects: connectivity, agility, and data volume. Furthermore, it is more and more necessary to combine and analyze information from various sources to gain operational insights. With OMS Log Analytics, organizations can collect, store, and analyze log data from virtually any Windows Server and Linux source and get unparalleled insights across their datacenters and clouds, including Azure and AWS.

### Core monitoring

Core monitoring provides fundamental, required monitoring across Azure resources. These services require minimal configuration and collect core telemetry that the premium monitoring services use.

Azure Monitor

Azure Monitor enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. For example, the activity log tells you when new resources are created or modified.

Metrics are available that provide performance statistics for different resources and even the operating system inside a virtual machine. You can view this data with one of the explorers in the Azure portal and create alerts based on these metrics. Azure Monitor provides the fastest metrics pipeline (5 minute down to 1 minute), so you should use it for time critical alerts and notifications.

You can also send these metrics and logs Azure Log Analytics for trending and detailed analysis, or create additional alert rules to proactively notify you of critical issues as a result of that analysis.

Azure Advisor

Azure Advisor constantly monitors your resource configuration and usage telemetry. It then gives you personalized recommendations based on best practices. Following these recommendations helps you improve the performance, security, and availability of the resources that support your applications.

Service Health

The health of your application relies on the Azure services that it depends on. Azure Service Health identifies any issues with Azure services that might affect your application. Service Health also helps you plan for scheduled maintenance.

Activity Log

Activity Log provides data about the operation of an Azure resource. This information includes:

  - Configuration changes to the resource.

  - Service health incidents.

  - Recommendations on better utilizing the resource.

  - Information related to autoscale operations.

You can view logs for a particular resource on its page in the Azure portal. Or you can view logs from multiple resources in Activity Log Explorer.

You can also send activity log entries to Log Analytics. There, you can analyze the logs by using data collected by management solutions, agents on virtual machines, and other sources.

Sources: <https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview>

### Log Analytics

To manage access to Log Analytics, you perform various administrative tasks related to workspaces. This article provides best practice advice and procedures to manage workspaces. A workspace is essentially a container that includes account information and simple configuration information for the account. You or other members of your organization might use multiple workspaces to manage different sets of data that is collected from all or portions of your IT infrastructure.

To create a workspace, you need to:

1.  Have an Azure subscription.

2.  Choose a workspace name.

3.  Associate the workspace with your subscription.

4.  Choose a geographical location.

### Log searches and alerts

We recommend creating log searches and alerts based on all the resources created in Azure.

### Securing data

Microsoft is committed to protecting the privacy and securing data, while delivering software and services that help to manage the IT infrastructure of the organization. We recognize that when you entrust your data to others, that trust requires rigorous security. Microsoft adheres to strict compliance and security guidelines—from coding to operating a service.

The OMS service manages cloud-based data securely by using the following methods:

  - **Data segregation:** Customer data is kept logically separate on each component throughout the OMS service. All data is tagged per organization. This tagging persists throughout the data lifecycle, and it is enforced at each layer of the service. Each customer has a dedicated Azure blob that houses the long-term data.

  - **Data retention:** Aggregated metrics for some of the solutions such as Capacity Management are stored in a SQL Database hosted by Microsoft Azure. This data is stored for 390 days. Indexed log search data is stored and retained according to the pricing plan.

  - **Physical security:** The OMS service is manned by Microsoft personnel, and all activities are logged and can be audited. The OMS service runs completely in Azure and complies with the Azure common engineering criteria.

  - **Compliance and certifications:** The OMS software development and service team is actively working with the Microsoft Legal and Compliance teams and other industry partners to acquire a variety of certifications.

OMS Log Analytics currently meet the following security standards:

  - Windows Common Engineering Criteria

  - Microsoft Trustworthy Computing Certification

  - ISO/IEC 27001 compliant

  - Service Organization Controls (SOC) 1 Type 1 and SOC 2 Type 1 compliant

## Backing up and restoring data

Backing up and restoring data are key for any production and most nonproduction workloads. The relevant scenarios are:

  - Backup and restore a virtual machine

  - Backup and restore files and folders

  - Backup and restore application data

We recommend taking advantage of Azure backup.

Azure Backup is the Azure-based service you can use to back up (or protect) and restore your data in the Microsoft cloud. Azure Backup replaces your existing on-premises or off-site backup solution with a cloud-based solution that is reliable, secure, and cost-competitive. Azure Backup offers multiple components that you download and deploy on the appropriate computer, server, or in the cloud. The component, or agent, that you deploy depends on what you want to protect. All Azure Backup components (no matter whether you're protecting data on-premises or in the cloud) can be used to back up data to a Recovery Services vault in Azure. See the Azure Backup components table (later in this article) for information about which component to use to protect specific data, applications, or workloads.

Traditional backup solutions have evolved to treat the cloud as an endpoint, or static storage destination, similar to disks or tape. While this approach is simple, it is limited and doesn't take full advantage of an underlying cloud platform, which translates to an expensive, inefficient solution. Other solutions are expensive because you end up paying for the wrong type of storage, or storage that you don't need. Other solutions are often inefficient because they don't offer you the type or amount of storage you need, or administrative tasks require too much time. In contrast, Azure Backup delivers these key benefits:

  - **Automatic storage management** - Hybrid environments often require heterogeneous storage - some on-premises and some in the cloud. With Azure Backup, there is no cost for using on-premises storage devices. Azure Backup automatically allocates and manages backup storage, and it uses a pay-as-you-use model. Pay-as-you-use means that you only pay for the storage that you consume. For more information, see the Azure pricing article (<https://azure.microsoft.com/pricing/details/backup>).

  - **Unlimited scaling** - Azure Backup uses the underlying power and unlimited scale of the Azure cloud to deliver high-availability - with no maintenance or monitoring overhead. You can set up alerts to provide information about events, but you don't need to worry about high-availability for your data in the cloud.

  - **Multiple storage options** - An aspect of high-availability is storage replication. Azure Backup offers two types of replication: locally redundant storage and geo-redundant storage. Choose the backup storage option based on need:
    
      - Locally redundant storage (LRS) replicates your data three times (it creates three copies of your data) in a storage scale unit in a datacenter. All copies of the data exist within the same region. LRS is a low-cost option for protecting your data from local hardware failures.
    
      - Geo-redundant storage (GRS) is the default and recommended replication option. GRS replicates your data to a secondary region (hundreds of miles away from the primary location of the source data). GRS costs more than LRS, but GRS provides a higher level of durability for your data, even if there is a regional outage.

  - **Unlimited data transfer** - Azure Backup does not limit the amount of inbound or outbound data you transfer. Azure Backup also does not charge for the data that is transferred. However, if you use the Azure Import/Export service to import large amounts of data, there is a cost associated with inbound data. For more information about this cost, see Offline-backup workflow in Azure Backup. Outbound data refers to data transferred from a Recovery Services vault during a restore operation.

  - **Data encryption** - Data encryption allows for secure transmission and storage of your data in the public cloud. You store the encryption passphrase locally, and it is never transmitted or stored in Azure. If it is necessary to restore any of the data, only you have encryption passphrase, or key.

  - **Application-consistent backup** - An application-consistent backup means a recovery point has all required data to restore the backup copy. Azure Backup provides application-consistent backups, which ensure additional fixes are not required to restore the data. Restoring application-consistent data reduces the restoration time, allowing you to quickly return to a running state.

  - **Long-term retention** - You can use Recovery Services vaults for short-term and long-term data retention. Azure doesn't limit the length of time data can remain in a Recovery Services vault. You can keep data in a vault for as long as you like. Azure Backup has a limit of 9999 recovery points per protected instance.

### Azure virtual Machines

When the Azure Backup service initiates a backup job at the scheduled time, it triggers the backup extension to take a point-in-time snapshot. The Azure Backup service uses the VMSnapshot extension in Windows, and the VMSnapshotLinux extension in Linux. The extension is installed during the first VM backup. To install the extension, the VM must be running. If the VM is not running, the Backup service takes a snapshot of the underlying storage (since no application writes occur while the VM is stopped).

1.  During the backup process, Azure Backup doesn't include the temporary disk attached to the virtual machine.

2.  Since Azure Backup takes a storage-level snapshot and transfers that snapshot to vault, do not change the storage account keys until the backup job finishes.

3.  For premium VMs, we copy the snapshot to storage account. This is to make sure that Azure Backup service gets sufficient IOPS for transferring data to vault. This additional copy of storage is charged as per the VM allocated size.

Microsoft’s **best practices** while configuring backups for virtual machines:

  - Do not schedule more than 40 VMs to back up at the same time.

  - Schedule VM backups during non-peak hours. This way the Backup service uses IOPS for transferring data from the customer storage account to the vault.

  - Make sure that a policy is applied on VMs spread across different storage accounts. We suggest no more than 20 total disks from a single storage account be protected by the same backup schedule. If you have greater than 20 disks in a storage account, spread those VMs across multiple policies to get the required IOPS during the transfer phase of the backup process.

  - Do not restore a VM running on Premium storage to same storage account. If the restore operation process coincides with the backup operation, it reduces the available IOPS for backup.

  - For Premium VM backup, ensure that storage account that hosts premium disks has atleast 50% free space for staging snapshot for a successful backup.

  - Make sure that python version on Linux VMs enabled for backup is 2.7

### Files and Folders

![](.//media/image26.png)This backup option is designed to back up files and folders from any Windows machine. The machine can run in Azure, on-premises, or in any other cloud; it can be physical or virtual. You cannot use this option to back up the system state, or to create a Bare-Metal-Restore (BMR) backup. The Recovery Services Vault could be the one that is mentioned in the previous section, or it could be any other Recovery Services Vault.

Azure Backup for files and folders requires the installation of an Azure Backup Agent on the server, which can be downloaded from the Azure Recovery Services Vault. After installing the agent, it is necessary to connect the server to the Recovery Services Vault by downloading the vault credential files from the Recovery Services Vault. The vault credentials file is used only during the registration workflow and expires after 48 hours. Ensure that the vault credential file is available in a location that can be accessed by the setup application.

Sources: <https://docs.microsoft.com/en-us/azure/backup/backup-azure-vms-introduction#capacity-planning>

## Establishing secure remote access

## Automating operational procedure

## Managing IT services according to ITIL

## Recommendations for operation Azure IaaS Services

|                                                |                                                                                                                                                                                                                                                                                                      |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Use nonpeak hours for backups**              | Schedule backups during nonpeak hours for VMs so that backup service gets IOPS for transferring data from customer storage account to backup vault.                                                                                                                                                  |
| **Spread VMs into different backup schedules** | Please make sure that in a policy VMs are spread from different storage accounts. We suggest that if the total number of disks stored in a single storage account from VMs is more than 20, spread the VMs into different backup schedules to get required IOPS during transfer phase of the backup. |
| **Back up critical data to separate location** | Ensuring all applications and mission-critical data is backed up at a separate secondary location other than the primary datacenter                                                                                                                                                                  |

# Offering management for cloud-based services

## Provisioning with templates

With Resource Manager, application designers can create a simple template (in JSON format) that defines deployment and configuration of entire application. This template is known as a Resource Manager template and provides a declarative way to define deployment. By using a template, you can repeatedly deploy the application throughout the app lifecycle and have confidence that resources are deployed in a consistent state.

Within the template, you define the infrastructure for your app, how to configure that infrastructure, and how to publish your app code to that infrastructure. You do not need to worry about the order for deployment because Azure Resource Manager analyzes dependencies to ensure resources are created in the correct order. There is no need to define your entire infrastructure in a single template. Often, it makes sense to divide the deployment requirements into a set of targeted, purpose-specific templates that are linked together.

Templates allow the specification of parameters for customization and flexibility in deployments. Those parameters should fit to the configuration options in the service catalog. The fact that resource manager orchestrates the deployment of multiple components supports a definition of application-specific instead of infrastructure-specific parameters. Example: For a deployment of a Big Data Service you may ask the customer for parameters such as the amount of master and data nodes, the required performance, and the amount of data that should be handled. All the logic for provisioning multiple virtual machines, load balancers, network settings, application installation, and configuration, etc., could be baked into the template.
Source: <https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-subscription-examples>, <https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/>, <https://www.xpirit.com/2017/11/23/best-practices-using-azure-resource-manager-templates/>