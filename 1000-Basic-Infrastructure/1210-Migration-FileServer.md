# Files on Azure

For many customers, who are migrating their workload to the cloud, one central question is: what about my files?
Most of the times there are a lot of dependencies to be arware of like user accessing files or EDI between systems.
Before migrating your workload to the cloud you have to check these dependencies. Even if all dependencies are fine, there are a few thinks to consider:

- what about availability requirenments
- current file server setup (Cluster, NetApp Ontap etc.)
- Linux Server
- Local WAN breakout bandwidth and latency
- Backup Solution
- AD Integration
- Dependencies to Servers/Services/Clients
- IOPS / Bandwidth requirenments
- How Much Data to be migrated
- How Much Data do you eeally need to keep
- Who currently uses the data and how do they use It
- Archiving

What options do we have to provide files on azure (we will not focus on all 3rd party solutions):

- Lift & Shift your FileServer via ASR (Azure Site Recovery)
- Built a new FileServer on Azure and migrate Files (Azure File Sync, robocopy...)
- Azure Files
- NetApp Files
- Switch to a new concept like SharePoint and OneDrive

For all the solutions above (except SharePoint and OneDrive), you should be aware of:

- SMB is not quite the best protocoll for accessing files over WAN with high latency
- Outbound data transfers will be charged

Let´s have a deeper look on these options:

## Lift & Shift

This would quite be the easiest way as you can setup ASR, sync your server and failover in a scheduled maintenance window.
[recommendations]: # ( start )
Even if azure managed disks provide Azure Storage Service Encryption (SSE), we recommend Azure Disk Encryption (ADE) to protect your data against internal threats (like copy disk).
[recommendations]: # ( end )

![Decision Tree for File Server](<../media/Protect_FileServer.png>)

*Pros:*

- Client connections doesen´t change
- Scripts and GPO´s do not need to change
- Small maintenance window required
- Tests possible
- AD Integration
- All Links, favority, recent documents etc. still work after failover

*Cons:*

- Not possible if 3rd Party Solutions like Netapp are in place
- Not possible for Scale-Out File Server (SOFS)
- operation modell doesen´t change as this is just IaaS (OS Patches)
- Costs on Azure (large Premium Disks)
- OS of the FileServer may be an old Version like 2012R2
- New Share can be used by OnPremises Servers and Clients
- ADE produces overhead for restore (single file restore not supported for today)

## New FileServer

Setup a new File Server in parallel and prestage Files or sync with Azure File Sync. The final Delta-Synchronization has to be done in a scheduled maintenance window.
One Option to achieve high availability is to create a Scale out File Server (SoFS) in Azure. For more informations check this Blog:
<https://techcommunity.microsoft.com/t5/Failover-Clustering/Deploying-IaaS-VM-Guest-Clusters-in-Microsoft-Azure/ba-p/372126>

![Azure File Sync Topology](<../media/Azure-FileSync.png>)

*Pros:*

- Chance to switch to a new OS
- Tests possible
- AD Integration
- Mirations from 3rd Party Solutions like NetApp
- If DFSN is in place, client connections doesen´t change (same for GPOs etc.)
- New Share can be used by OnPremises Servers and Clients
- AD Integration

*Cons:*

- Client connections will change (except DFSN is in place)
- Operation modell doesen´t change as this is just IaaS (OS Patches)
- Costs on Azure (large Premium Disks)
- ADE produces overhead for restore (single file restore not supported for today)
- All Links, favority, recent documents etc. will no longer work (except DFSN is in place)

## NetApp Files

Azure NetApp Files is a fully managed cloud service with full Azure portal integration. As NetApp supports AD integration,
all your domain joined Servers and Clients can access the shares via SMB (3.1).
Beside SMB, NetApp also supports NFSv3. As there are three performance tiers (Standard, Premium and Ultra tier), you can optimise NetApp Files for your workload and spending requirements.
Azure NetApp Files is billed on provisioned storage capacity. Provisioned capacity is allocated by creating capacity pools. 
Capacity pools are billed based on $/provisioned-GiB/month in hourly increments. 
The minimum size for a single capacity pool is 4 TiB, and capacity pools can be subsequently expanded in 1-TiB increments.

 ![NetApp Files in Azure Portal](<../media/NetApp-Files.png>)

*Pros:*

- Quite good performance
- Fully managed service
- Prooven technology
- Easy snapshots (examples: db copy for developer)
- FIPS-140-2-compliant data encryption at rest
- Local AD integration

*Cons:*

- Can be expensive (depends on tier configuration)
- For new customers, this is a new technology that operations teams has to be trained for
- New backup/restore concept
- Limited to a few regions for today
- Be carefull with: NSG´s, UDRs, Policies, Load Balancers (check constraints)
- Cross region or global peering access to volumes not supported

## Azure Files

Azure Files offers fully managed file shares in the cloud that can be accessed via SMB (Azure Files support SMB 3.0).
You can use Azure Files without being responsible for managing the overhead of a physical server, device, or appliance.
Azure Files also supports identity-based authentication through Azure Active Directory Domain Services (AADDS).
To use this new services, your VMs have to be joined to AADDS. The good news are, that users, who will login to this VMs, can also mount Shares from VMs that are just connected to local AD. As Azure Files offers Soft Delete and also Azure backup support, no agents or VMs need to be deployed to enable Backup.

The Setup is quite easy:
Before you enable Azure AD over SMB for Azure Files, make sure you have completed the following prerequisites:

- Select or create an Azure AD tenant.
You can use a new or existing tenant for Azure AD authentication over SMB. The tenant and the file share that you want to access must be associated with the same subscription. To create a new Azure AD tenant, you can Add an Azure AD tenant and an Azure AD subscription. If you have an existing Azure AD tenant but want to create a new tenant for use with Azure Files, see Create an Azure Active Directory tenant.

- Enable Azure AD Domain Services on the Azure AD tenant.
To support authentication with Azure AD credentials, you must enable Azure AD Domain Services for your Azure AD tenant. If you aren't the administrator of the Azure AD tenant, contact the administrator and follow the step-by-step guidance to Enable Azure Active Directory Domain Services using the Azure portal.

- Domain-join an Azure VM with Azure AD DS.
To access a file share by using Azure AD credentials from a VM, your VM must be domain-joined to Azure AD DS. For more information about how to domain-join a VM, see Join a Windows Server virtual machine to a managed domain.

- Select or create an Azure file share.
Select a new or existing file share that's associated with the same subscription as your Azure AD tenant. For information about creating a new file share, see Create a file share in Azure Files. For optimal performance, we recommend that your file share be in the same region as the VM from which you plan to access the share.

- Verify Azure Files connectivity by mounting Azure file shares using your storage account key.
 To verify that your VM and file share are properly configured, try mounting the file share using your storage account key. For more information, see Mount an Azure file share and access the share in Windows.

 ![Active AADDS on Azure Files](<../media/AzureFiles-AADDS.png>)

 Source: <https://docs.microsoft.com/de-de/azure/storage/files/storage-files-active-directory-enable>

*Pros:*

- If you migrate your files (for example via robocopy), your ACL´s are preserved (you just have to configure Access via Azure RBAC on the Share for the Storage Account.
- Built-In high availibility (check SLA for Storage Accounts)
- Managed by Microsoft
- Several performance level available
- Cheaper than IaaS (mostly)

*Cons:*

- No NFS Support
- AADDS not supported for Linux
- Azure AD DS authentication for SMB access is not supported for Active Directory domain-joined machines
- Backup concept has to change
- All Links, favority, recent documents etc. will no longer work

## SharePoint online and OneDrive

One of the big revolutions of modern business has been the emergence of remote working. This could be quite challanging with traditional file servers.
This kind of migration requires a llot of planning as it is not really a good approach to just move the files to a SharePoint library.
Even if SharePoint Online and OneDrive is the way where clients will save their documents (OneDrive is the new default file location in Office), there are
a few situations, where you still need to have a file server in place.
Check <https://support.office.com/en-us/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa#invalidcharacters>
for current limitations.

*Pros:*

- Works great for WAN connections as this solutions is designed for WAN access
- Great collaboratoin capabilities (work together on documents, internal and external sharing)
- New Security features like AIP, IRM, Azure AD Premium etc.
- Versioning
- Can be much cheaper (if you compare a high availability file server to a user licensed with E3)
- Fully managed by Microsoft
- No hybrid connection required
- No Domain Controllers in Azure required

*Cons:*

- Users has to change the way they work 
- All Links, favority, recent documents etc. will no longer work
- EDI between Servers via Service Accounts has to be redesigned
- SharePoint online license required
- New technology that operations teams has to be trained for
- Migration is quite complex
- Security features has to be well planned and has to licensed
- End-User training required
- Best with Windows 10 and latest Office 365 Version

## Bellow some key features in a short overview ##

| | Classic File Server | SharePoint Online | OneDrive for Business | NetApp | Azure Files |
|---|---|---|---|---|---|---|
| Operated by| Internal IT | Microsoft | Microsoft | Microsoft/NetApp | Microsoft |
| Local AD integration | Yes | No (Azure AD)| No (Azure AD) | Yes | No (Azure AD Domain Services) |
| New Storage| New Storage space required (perhaps new disks) | Pay-as-you-Go| Pay-as-you-Go (MS issues credits beyond 25TB) |Pay-as-you-Go| Pay-as-you-Go|
| Work together on Files in realtime | No | Yes | Yes | No | No |
| Access Files from everywhere | No (VPN)| Yes | Yes | No | No |
| Offline Access | Yes (work folders)| Yes | Yes | No | No |
| External Sharing | No| Yes | Yes | No | No |
| Optimzed for WAN Access | No| Yes | Yes | No | No |
