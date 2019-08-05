# Storage

## General Purpose v2

[comment]: # (Add small explanation regarding GPv1 and Blob Storage, why it's not generally used anymore and where it might still be applicable today.)

General-purpose v2 (GPv2) accounts are storage accounts that support all of the latest features for blobs, files, queues, and tables. GPv2 accounts support all APIs and features supported in GPv1 and Blob storage accounts. They also support the same durability, availability, scalability, and performance features in those account types. Pricing for GPv2 accounts has been designed to deliver the lowest per gigabyte prices, and industry competitive transaction prices.

For block blobs in a GPv2 storage account, you can choose between hot and cool storage tiers at the account level, or hot, cool, and archive tiers at the blob level based on access patterns. Store frequently, infrequently, and rarely accessed data in the hot, cool, and archive storage tiers respectively to optimize costs.

GPv2 storage accounts expose the Access Tier attribute at the account level, which specifies the default storage account tier as Hot or Cool. The default storage account tier is applied to any blob that does not have an explicit tier set at the blob level. If there is a change in the usage pattern of your data, you can also switch between these storage tiers at any time. The archive tier can only be applied at the blob level.

### Recommendations

For applications requiring only block or append blob storage, using GPv2 storage accounts is recommended, to take advantage of the differentiated pricing model of tiered storage. However, you may want to use GPv1 in certain scenarios, such as:

  - You still need to use the classic deployment model. Blob storage accounts are only available via the Azure Resource Manager deployment model.

  - You use high volumes of transactions or geo-replication bandwidth, both of which cost more in GPv2 and Blob storage accounts than in GPv1, and don't have enough storage that benefits from the lower costs of GB storage.

  - You use a version of the Storage Services REST API that is earlier than 2014-02-14 or a client library with a version lower than 4.x and cannot upgrade your application.

## Replication

The data in your Microsoft Azure storage account is always replicated to ensure durability and high availability. Replication copies your data so that it is protected from transient hardware failures, preserving your application up-time.

You can choose to replicate your data within the same data center, across data centers within the same region, or across regions. If your data is replicated across multiple data centers or across regions, it's also protected from a catastrophic failure in a single location.

Replication ensures that your storage account meets the Service-Level Agreement (SLA) for Storage even in the face of failures. See the SLA for information about Azure Storage guarantees for durability and availability.

When you create a storage account, you can select one of the following replication options:

  - Locally redundant storage (LRS)

  - Zone-redundant storage (ZRS)

  - Geo-redundant storage (GRS)

  - Read-access geo-redundant storage (RA-GRS)

| Scenario                                                                                                 | LRS                             | ZRS                              | GRS                                  | RA-GRS                               |
| -------------------------------------------------------------------------------------------------------- | ------------------------------- | -------------------------------- | ------------------------------------ | ------------------------------------ |
| Node unavailability within a data center                                                                 | Yes                             | Yes                              | Yes                                  | Yes                                  |
| An entire data center (zonal or non-zonal) becomes unavailable                                           | No                              | Yes                              | Yes                                  | Yes                                  |
| A region-wide outage                                                                                     | No                              | No                               | Yes                                  | Yes                                  |
| Read access to your data (in a remote, geo-replicated region) in the event of region-wide unavailability | No                              | No                               | No                                   | Yes                                  |
| Designed to provide \_ durability of objects over a given year                                           | at least 99.999999999% (11 9's) | at least 99.9999999999% (12 9's) | at least 99.99999999999999% (16 9's) | at least 99.99999999999999% (16 9's) |
| Supported storage account types                                                                          | GPv1, GPv2, Blob                | GPv2                             | GPv1, GPv2, Blob                     | GPv1, GPv2, Blob                     |

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy

### Locally redundant storage

Locally redundant storage (LRS) is designed to provide at least 99.999999999% (11 9's) durability of objects over a given year by replicating your data within a storage scale unit, which is hosted in a datacenter in the region in which you created your storage account. A write request returns successfully only once it has been written to all replicas. These replicas each reside in separate fault domains and update domains within one storage scale unit.

A storage scale unit is a collection of racks of storage nodes. A fault domain (FD) is a group of nodes that represent a physical unit of failure and can be considered as nodes belonging to the same physical rack. An upgrade domain (UD) is a group of nodes that are upgraded together during the process of a service upgrade (rollout). The replicas are spread across UDs and FDs within one storage scale unit to ensure that data is available even if hardware failure impacts a single rack or when nodes are upgraded during a rollout.

LRS is the lowest cost option and offers least durability compared to other options. In the event of a datacenter level disaster (fire, flooding etc.) all replicas might be lost or unrecoverable. To mitigate this risk, Geo Redundant Storage (GRS) is recommended for most applications.

Locally redundant storage may still be desirable in certain scenarios:

  - Provides highest maximum bandwidth of Azure Storage replication options.
  - If your application stores data that can be easily reconstructed, you may opt for LRS.
  - Some applications are restricted to replicating data only within a country due to data governance requirements. A paired region could be in another country. For more information on region pairs, see Azure regions.

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-lrs

### Zone redundant storage

Zone redundant storage (ZRS) is designed to simplify the development of highly available applications. ZRS provides durability for storage objects of at least 99.9999999999% (12 9's) over a given year. ZRS replicates your data synchronously across multiple availability zones. Consider ZRS for scenarios like transactional applications where downtime is not acceptable.

ZRS enables customers to read and write data even if a single zone is unavailable or unrecoverable. Inserts and updates to data are made synchronously and are strongly consistent.

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-zrs

### Geo-redundant storage

Geo-redundant storage (GRS) is designed to provide at least 99.99999999999999% (16 9's) durability of objects over a given year by replicating your data to a secondary region that is hundreds of miles away from the primary region. If your storage account has GRS enabled, then your data is durable even in the case of a complete regional outage or a disaster in which the primary region is not recoverable.

For a storage account with GRS enabled, an update is first committed to the primary region. Then the update is replicated asynchronously to the secondary region, where it is also replicated.

With GRS, both the primary and secondary regions manage replicas across separate fault domains and upgrade domains within a storage scale unit as described with LRS.

Considerations:

  - Since asynchronous replication involves a delay, in the event of a regional disaster it is possible that changes that have not yet been replicated to the secondary region will be lost if the data cannot be recovered from the primary region.

  - The replica is not available unless Microsoft initiates failover to the secondary region. If Microsoft does initiate a failover to the secondary region, you will have read and write access to that data after the failover has completed. For more information, please see Disaster Recovery Guidance.

  - If an application wants to read from the secondary region, the user should enable RA-GRS.

When you create a storage account, you select the primary region for the account. The secondary region is determined based on the primary region and cannot be changed.
You can find all region pairings, as well as more information regarding paired regions in the following Microsoft Article: https://docs.microsoft.com/en-us/azure/best-practices-availability-paired-regions

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy-grs

### Read-access geo-redundant storage

Read-access geo-redundant storage (RA-GRS) maximizes availability for your storage account. RA-GRS provides read-only access to the data in the secondary location, in addition to geo-replication across two regions.

When you enable read-only access to your data in the secondary region, your data is available on a secondary endpoint as well as on the primary endpoint for your storage account. The secondary endpoint is similar to the primary endpoint but appends the suffix –secondary to the account name. For example, if your primary endpoint for the Blob service is myaccount.blob.core.windows.net, then your secondary endpoint is myaccount-secondary.blob.core.windows.net. The access keys for your storage account are the same for both the primary and secondary endpoints.

Some considerations to keep in mind when using RA-GRS:

  - Your application has to manage which endpoint it is interacting with when using RA-GRS.
  - Since asynchronous replication involves a delay, changes that have not yet been replicated to the secondary region may be lost if data cannot be recovered from the primary region, for example in the event of a regional disaster.
  - If Microsoft initiates failover to the secondary region, you will have read and write access to that data after the failover has completed.
  - RA-GRS is intended for high-availability purposes.

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy?toc=%2fazure%2fstorage%2fblobs%2ftoc.json

## VM Disk Storage

Just like any other computer, virtual machines in Azure use disks as a place to store an operating system, applications, and data. All Azure virtual machines have at least two disks – a Windows operating system disk and a temporary disk. The operating system disk is created from an image, and both the operating system disk and the image are virtual hard disks (VHDs) stored in an Azure storage account. Virtual machines also can have one or more data disks, that are also stored as VHDs.

### Operating system disk

Every virtual machine has one attached operating system disk. It's registered as a SATA drive and labeled as the C: drive by default. This disk has a maximum capacity of 2048 gigabytes (GB).

### Temporary disk

Each VM contains a temporary disk. The temporary disk provides short-term storage for applications and processes and is intended to only store data such as page or swap files. Data on the temporary disk may be lost during a maintenance event or when you redeploy a VM. During a standard reboot of the VM, the data on the temporary drive should persist.

The temporary disk is labeled as the D: drive by default and it used for storing pagefile.sys. The size of the temporary disk varies, based on the size of the virtual machine.

### Data disk

A data disk is a VHD that's attached to a virtual machine to store application data, or other data you need to keep. Data disks are registered as SCSI drives and are labeled with a letter that you choose. The size of the virtual machine determines how many data disks you can attach to it and the type of storage you can use to host the disks.

Azure creates an operating system disk when you create a virtual machine from an image. If you use an image that includes data disks, Azure also creates the data disks when it creates the virtual machine. Otherwise, you add data disks after you create the virtual machine.

You can add data disks to a virtual machine at any time, by attaching the disk to the virtual machine. You can use a VHD that you've uploaded or copied to your storage account or use an empty VHD that Azure creates for you. Attaching a data disk associates the VHD file with the VM by placing a 'lease' on the VHD so it can't be deleted from storage while it's still attached.

### VHDs

The VHDs used in Azure are .vhd files stored as page blobs in a standard or premium storage account in Azure.

Azure supports the fixed disk VHD format. The fixed format lays the logical disk out linearly within the file, so that disk offset X is stored at blob offset X. A small footer at the end of the blob describes the properties of the VHD. Often, the fixed format wastes space because most disks have large unused ranges in them. However, Azure stores .vhd files in a sparse format, so you receive the benefits of both the fixed and dynamic disks at the same time.

All .vhd files in Azure that you want to use as a source to create disks or images are read-only, except the .vhd files uploaded or copied to Azure storage by the user (which can be either read-write or read-only). When you create a disk or image, Azure makes copies of the source .vhd files. These copies can be read-only or read-and-write, depending on how you use the VHD.

When you create a virtual machine from an image, Azure creates a disk for the virtual machine that is a copy of the source .vhd file. To protect against accidental deletion, Azure places a lease on any source .vhd file that’s used to create an image, an operating system disk, or a data disk.

Before you can delete a source .vhd file, you’ll need to remove the lease by deleting the disk or image. To delete a .vhd file that is being used by a virtual machine as an operating system disk, you can delete the virtual machine, the operating system disk, and the source .vhd file all at once by deleting the virtual machine and deleting all associated disks. However, deleting a .vhd file that’s a source for a data disk requires several steps in a set order. First you detach the disk from the virtual machine, then delete the disk, and then delete the .vhd file.

Don’t delete a source .vhd file from storage or the storage account itself – Microsoft can’t recover that data for you.

## Premium vs. Standard storage

**Azure Disks are designed for 99.999% availability**. Azure Disks have consistently delivered enterprise-grade durability, with an industry-leading ZERO% Annualized Failure Rate.

There are two performance tiers for storage that you can choose from when creating your disks -- Standard Storage and Premium Storage. Also, there are two types of disks -- unmanaged and managed -- and they can reside in either performance tier.

### Standard storage (HDD)

Standard Storage is backed by HDDs and delivers cost-effective storage while still being performant. Standard storage can be replicated locally in one datacenter or be geo-redundant with primary and secondary data centers.

Azure Standard Storage delivers reliable, low-cost disk support for VMs running latency-insensitive workloads. It also supports blobs, tables, queues, and files. With Standard Storage, the data is stored on hard disk drives (HDDs). When working with VMs, you can use standard storage disks for Dev/Test scenarios and less critical workloads, and premium storage disks for mission-critical production applications. Standard Storage is available in all Azure regions.

### Standard storage (SSD)

Azure Standard Solid State Drives (SSD) Managed Disks are a **cost-effective storage option** optimized for workloads that need consistent performance at lower IOPS levels. Standard SSD offers a good entry level experience for those who wish to move to the cloud, especially if you experience issues with the variance of workloads running on your HDD solutions on premises. Standard SSDs deliver better availability, consistency, reliability and latency compared to HDD Disks, and are suitable for Web servers, low IOPS application servers, lightly used enterprise applications, and Dev/Test workloads.

**Managed Disks:** Standard SSDs are only available as Managed Disks. Unmanaged Disks and Page Blobs are not supported on Standard SSD. While creating the Managed Disk, you specify the disk type as Standard SSD and indicate the size of disk you need, and Azure creates and manages the disk for you. Standard SSDs support all service management operations offered by Managed Disks. For example, you can create, copy or snapshot Standard SSD Managed Disks in the same way you do with Managed Disks.

**Virtual Machines:** Standard SSDs can be used with all Azure VMs, including the VM types that do not support Premium Disks. For example, if you're using an A-series VM, or N-series VM, or DS-series, or any other Azure VM series, you can use Standard SSDs with that VM. With the introduction of Standard SSD, we are enabling a broad range of workloads that previously used HDD-based disks to transition to SSD-based disks, and experience the consistent performance, higher availability, better latency, and an overall better experience that come with SSDs.

**Highly durable and available:** Standard SSDs are built on the same Azure Disks platform, which has consistently delivered high availability and durability for disks. Azure Disks are designed for 99.999 percent availability. Like all Managed Disks, Standard SSDs will also offer Local Redundant Storage (LRS). With LRS, the platform maintains multiple replicas of data for every disk and has consistently delivered enterprise-grade durability for IaaS disks, with an industry-leading ZERO percent Annualized Failure Rate.

**Snapshots:** Like all Managed Disks, Standard SSDs also support creation of Snapshots. Snapshot type can be either Standard (HDD) or Premium (SSD). For cost saving, we recommend Snapshot type of Standard (HDD) for all Azure disk types. This is because when you create a managed disk from a snapshot, you're always able to choose a higher tier such as Standard SSD or Premium SSD.

Source: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/standard-storage

### Premium storage (SSD)

Premium Storage is backed by SSDs, and delivers high-performance, low-latency disk support for VMs running I/O-intensive workloads. You can use Premium Storage with DS, DSv2, GS, Ls, or FS series Azure VMs.

Azure Premium Storage delivers high-performance, low-latency disk support for virtual machines (VMs) with input/output (I/O)-intensive workloads. VM disks that use Premium Storage store data on solid-state drives (SSDs). To take advantage of the speed and performance of premium storage disks, you can migrate existing VM disks to Premium Storage.

In Azure, you can attach several premium storage disks to a VM. Using multiple disks gives your applications up to 256 TB of storage per VM. With Premium Storage, your applications can achieve 80,000 I/O operations per second (IOPS) per VM, and a disk throughput of up to 2,000 megabytes per second (MB/s) per VM. Read operations give you very low latencies.

With Premium Storage, Azure offers the ability to truly lift-and-shift demanding enterprise applications like Dynamics AX, Dynamics CRM, Exchange Server, SAP Business Suite, and SharePoint farms to the cloud. You can run performance-intensive database workloads in applications like SQL Server, Oracle, MongoDB, MySQL, and Redis, which require consistent high performance and low latency.

For the best performance for your application, we recommend that you migrate any VM disk that requires high IOPS to Premium Storage. If your disk does not require high IOPS, you can help limit costs by keeping it in standard Azure Storage. In standard storage, VM disk data is stored on hard disk drives (HDDs) instead of on SSDs.

Source: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/premium-storage

### Unmanaged disks

Unmanaged disks are the traditional type of disks that have been used by VMs. With these, you create your own storage account and specify that storage account when you create the disk. You have to make sure you don't put too many disks in the same storage account, because you could exceed the scalability targets of the storage account (20,000 IOPS, for example), resulting in the VMs being throttled. With unmanaged disks, you have to figure out how to maximize the use of one or more storage accounts to get the best performance out of your VMs.

### Managed disks

Managed Disks handles the storage account creation/management in the background for you and ensures that you do not have to worry about the scalability limits of the storage account. You simply specify the disk size and the performance tier (Standard/Premium), and Azure creates and manages the disk for you. Even as you add disks or scale the VM up and down, you don't have to worry about the storage being used.

You can also manage your custom images in one storage account per Azure region and use them to create hundreds of VMs in the same subscription.

Azure Managed Disks simplifies disk management for Azure IaaS VMs by managing the storage accounts associated with the VM disks. You only have to specify the type (Premium or Standard) and the size of disk you need, and Azure creates and manages the disk for you.

Managed Disks handles storage for you behind the scenes. Previously, you had to create storage accounts to hold the disks (VHD files) for your Azure VMs. When scaling up, you had to make sure you created additional storage accounts so you didn't exceed the IOPS limit for storage with any of your disks. With Managed Disks handling storage, you are no longer limited by the storage account limits (such as 20,000 IOPS / account). You also no longer have to copy your custom images (VHD files) to multiple storage accounts. You can manage them in a central location – one storage account per Azure region – and use them to create hundreds of VMs in a subscription.

Managed Disks will allow you to create up to 10,000 VM disks in a subscription, which will enable you to create thousands of VMs in a single subscription. This feature also further increases the scalability of Virtual Machine Scale Sets (VMSS) by allowing you to create up to a thousand VMs in a VMSS using a Marketplace image.

**Managed Disks provides better reliability for Availability Sets** by ensuring that the disks of VMs in an Availability Set are sufficiently isolated from each other to avoid single points of failure. It does this by automatically placing the disks in different storage scale units (stamps). If a stamp fails due to hardware or software failure, only the VM instances with disks on those stamps fail. For example, let's say you have an application running on five VMs, and the VMs are in an Availability Set. The disks for those VMs won't all be stored in the same stamp, so if one stamp goes down, the other instances of the application continue to run.

**Azure Disks are designed for 99.999% availability**. Rest easier knowing that you have three replicas of your data that enables high durability. If one or even two replicas experience issues, the remaining replicas help ensure persistence of your data and high tolerance against failures. This architecture has helped Azure consistently deliver enterprise-grade durability for IaaS disks, with an industry-leading ZERO% Annualized Failure Rate.

You can use Azure Role-Based Access Control (RBAC) to assign specific permissions for a managed disk to one or more users. Managed Disks exposes a variety of operations, including read, write (create/update), delete, and retrieving a shared access signature (SAS) URI for the disk. You can grant access to only the operations a person needs to perform his job. For example, if you don't want a person to copy a managed disk to a storage account, you can choose not to grant access to the export action for that managed disk. Similarly, if you don't want a person to use an SAS URI to copy a managed disk, you can choose not to grant that permission to the managed disk.

Use Azure Backup service with Managed Disks to create a backup job with time-based backups, easy VM restoration and backup retention policies. **Managed Disks only support Locally Redundant Storage (LRS) as the replication option**; this means it keeps three copies of the data within a single region. For regional disaster recovery, you must backup your VM disks in a different region using Azure Backup service and a GRS storage account as backup vault. Currently Azure Backup supports data disk sizes up to 1TB for backup. Read more about this at Using Azure Backup service for VMs with Managed Disks.

We recommend that you use Azure Managed Disks for new VMs, and that you convert your previous unmanaged disks to managed disks, to take advantage of the many features available in Managed Disks.

### Comparison

You can find an up-to-date comparison between the available storage disks in Azure under the following link: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types

### Available disk sizes

You can find more information for all available managed disks in Azure, as well as tables listing the available disk sizes under the following links:

Premium SSD: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types#premium-ssd

Standard SSD: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types#standard-ssd

Standard HDD: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types#standard-hdd

## Storage Firewalls and Virtual Networks

Azure Storage provides a layered security model allowing you to secure your storage accounts to a specific set of allowed networks. When network rules are configured, only applications from allowed networks can access a storage account. When calling from an allowed network, applications continue to require proper authorization (a valid access key or SAS token) to access the storage account.

Turning on Firewall rules for your Storage account will block access to incoming requests for data, including from other Azure services. This includes using the Portal, writing logs, etc. For participating services you can re-enable functionality through the Exceptions section below. To access the Portal you would need to do so from a machine within the trusted boundary (either IP or VNet) that you have set up.

Storage accounts can be configured to deny access to traffic from all networks (including internet traffic) by default. Access can be granted to traffic from specific Azure Virtual networks, allowing you to build a secure network boundary for your applications. Access can also be granted to public internet IP address ranges, enabling connections from specific internet or on-premises clients.

Network rules are enforced on all network protocols to Azure storage, including REST and SMB. Access to your data from tools like the Azure portal, Storage Explorer, and AZCopy require explicit network rules granting access when network rules are in force.

Network rules can be applied to existing Storage accounts, or can be applied during the creation of new Storage accounts.

Once network rules are applied, they are enforced for all requests. SAS tokens that grant access to a specific IP Address service serve to limit the access of the token holder, but do not grant new access beyond configured network rules.

Virtual Machine Disk traffic (including mount and unmount operations, and disk IO) is not affected by network rules. REST access to page blobs is protected by network rules.

**Backup and Restore of Virtual Machines using unmanaged disks in storage accounts with network rules applied is not currently supported.**

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security

### Exceptions

While network rules can enable a secure network configuration for most scenarios, there are some cases where exceptions must be granted to enable full functionality. Storage accounts can be configured with exceptions for Trusted Microsoft services, and for access to Storage analytics data.

Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security#exceptions