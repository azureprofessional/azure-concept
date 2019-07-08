# Backup and Recovery

Backing up and restoring data are key for any production and most nonproduction workloads. The relevant scenarios are:

- Backup and restore a virtual machine
- Backup and restore files and folders
- Backup and restore application data

We recommend taking advantage of Azure Backup. 

## Azure Backup

Azure Backup is the Azure-based service you can use to back up, protect and restore your data in the Microsoft cloud. Azure Backup replaces your existing on-premises or off-site backup solution with a cloud-based solution that is reliable, secure, and cost-competitive. Azure Backup offers multiple components that you download and deploy on the appropriate computer, server, or in the cloud. The component or agent that you deploy depends on what you want to protect. All Azure Backup components (no matter whether you're protecting data on-premises or in the cloud) can be used to back up data to a Recovery Services vault in Azure. See the Azure Backup components table (later in this article) for information about which component to use to protect specific data, applications, or workloads.

Traditional backup solutions have evolved to treat the cloud as an endpoint or static storage destination, similar to disks or tape. While this approach is simple, it is limited and doesn't take full advantage of an underlying cloud platform, which translates to an expensive, inefficient solution. Other solutions are expensive because you end up paying for the wrong type of storage, or storage that you don't need. Other solutions are often inefficient because they don't offer you the type or amount of storage you need, or administrative tasks require too much time. In contrast, Azure Backup delivers these key benefits:

- **Automatic storage management**
    Hybrid environments often require heterogeneous storage - some on-premises and some in the cloud. With Azure Backup, there is no cost for using on-premises storage devices. Azure Backup automatically allocates and manages backup storage, and it uses a pay-as-you-use model. Pay-as-you-use means that you only pay for the storage that you consume. For more information, see the Azure pricing article (https://azure.microsoft.com/pricing/details/backup).
- **Unlimited scaling**
    Azure Backup uses the underlying power and unlimited scale of the Azure cloud to deliver high-availability - with no maintenance or monitoring overhead. You can set up alerts to provide information about events, but you don't need to worry about high-availability for your data in the cloud.
- **Multiple storage options**
An aspect of high-availability is storage replication. Azure Backup offers two types of replication: locally redundant storage and geo-redundant storage. Choose the backup storage option based on need:
    - Locally redundant storage (LRS) replicates your data three times (it creates three copies of your data) in a storage scale unit in a datacenter. All copies of the data exist within the same region. LRS is a low-cost option for protecting your data from local hardware failures.
    - Geo-redundant storage (GRS) is the default and recommended replication option. GRS replicates your data to a secondary region (hundreds of miles away from the primary location of the source data). GRS costs more than LRS, but GRS provides a higher level of durability for your data, even if there is a regional outage.

- **Unlimited data transfer**
  Azure Backup does not limit the amount of inbound or outbound data you transfer. Azure Backup also does not charge for the data that is transferred. However, if you use the Azure Import/Export service to import large amounts of data, there is a cost associated with inbound data. For more information about this cost, see Offline-backup workflow in Azure Backup. Outbound data refers to data transferred from a Recovery Services vault during a restore operation.
- **Data encryption**
  Data encryption allows for secure transmission and storage of your data in the public cloud. You store the encryption passphrase locally, and it is never transmitted or stored in Azure. If it is necessary to restore any of the data, only you have encryption passphrase, or key.
- **Application-consistent backup**
  An application-consistent backup means a recovery point has all required data to restore the backup copy. Azure Backup provides application-consistent backups, which ensure additional fixes are not required to restore the data. Restoring application-consistent data reduces the restoration time, allowing you to quickly return to a running state.
- **Long-term retention**
  You can use Recovery Services vaults for short-term and long-term data retention. Azure doesn't limit the length of time data can remain in a Recovery Services vault. You can keep data in a vault for as long as you like. Azure Backup has a limit of 9999 recovery points per protected instance.

## Azure Virtual Machines

When the Azure Backup service initiates a backup job at the scheduled time, it triggers the backup extension to take a point-in-time snapshot. The Azure Backup service uses the VMSnapshot extension in Windows, and the VMSnapshotLinux extension in Linux. The extension is installed during the first VM backup. To install the extension, the VM must be running. If the VM is not running, the Backup service takes a snapshot of the underlying storage (since no application writes occur while the VM is stopped).

- During the backup process, Azure Backup doesn't include the temporary disk attached to the virtual machine.
- Since Azure Backup takes a storage-level snapshot and transfers that snapshot to vault, do not change the storage account keys until the backup job finishes.
- For premium VMs, we copy the snapshot to storage account. This is to make sure that Azure Backup service gets sufficient IOPS for transferring data to vault. This additional copy of storage is charged as per the VM allocated size.

Microsoft’s best practices while configuring backups for virtual machines:

- Do not schedule more than 40 VMs to back up at the same time.
- Schedule VM backups during non-peak hours. This way the Backup service uses IOPS for transferring data from the customer storage account to the vault.
- Make sure that a policy is applied on VMs spread across different storage accounts. We suggest no more than 20 total disks from a single storage account be protected by the same backup schedule. If you have greater than 20 disks in a storage account, spread those VMs across multiple policies to get the required IOPS during the transfer phase of the backup process.
- Do not restore a VM running on Premium storage to same storage account. If the restore operation process coincides with the backup operation, it reduces the available IOPS for backup.
- For Premium VM backup, ensure that storage account that hosts premium disks has at least 50% free space for staging snapshot for a successful backup.
- Make sure that python version on Linux VMs enabled for backup is 2.7

## Files and Folders

![File_and_Folder_Recovery](../media/image26.png)

This backup option is designed to back up files and folders from any Windows machine. The machine can run in Azure, on-premises, or in any other cloud; it can be physical or virtual. You cannot use this option to back up the system state, or to create a Bare-Metal-Restore (BMR) backup. The Recovery Services Vault could be the one that is mentioned in the previous section, or it could be any other Recovery Services Vault.

Azure Backup for files and folders requires the installation of an Azure Backup Agent on the server, which can be downloaded from the Azure Recovery Services Vault. After installing the agent, it is necessary to connect the server to the Recovery Services Vault by downloading the vault credential files from the Recovery Services Vault. The vault credentials file is used only during the registration workflow and expires after 48 hours. Ensure that the vault credential file is available in a location that can be accessed by the setup application.