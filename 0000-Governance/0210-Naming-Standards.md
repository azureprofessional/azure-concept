# Naming standards

## Introduction
The first pillar of the scaffold is naming standards. Well-designed naming standards enable to identify resources in the portal, on a bill, and within scripts. Most likely, there are already naming standards for on-premises infrastructure. When adding Azure to your environment, those naming standards should be extended to your Azure resources. Naming standard facilitate more efficient management of the environment at all levels.

The choice of a name for any resource in Microsoft Azure is important because:

  - It is difficult to change a name later.

  - Names must meet the requirements of their specific resource type.

Consistent naming conventions make resources easier to locate. They can also indicate the role of a resource in a solution.

The key to success with naming conventions is establishing and following them across your applications and organizations.

## Technical Background
Sources: <https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions>, <https://blogs.technet.microsoft.com/dsilva/2017/11/10/azure-subscription-governance-resource-group-and-naming-convention-strategies/>

### Subscriptions

When naming Azure subscriptions, verbose names make understanding the context and purpose of each subscription clear. When working in an environment with many subscriptions, following a shared naming convention can improve clarity.

A generic recommended pattern for naming subscriptions is:

**\<Company\> \<Department (optional)\> \<Product Line (optional)\> \<Environment\>**

  - Company would usually be the same for each subscription. However, some companies may have child companies within the organizational structure. These companies may be managed by a central IT group. In these cases, they could be differentiated by having both the parent company name and child company name.

  - Department is a name within the organization that contains a group of individuals. This item within the namespace is optional. For example: “IT”, “Marketing”, …

  - Product line is a specific name for a product or function that is performed from within the department. This is generally optional for internal-facing services and applications. However, it is highly recommended to use for public-facing services that require easy separation and identification (such as for clear separation of billing records).

  - Environment is the name that describes the deployment lifecycle of the applications or services, such as Dev, Test, or Prod.

### Rules and restrictions

Each resource or service type in Azure enforces a set of naming restrictions and scope; any naming convention or pattern must adhere to the requisite naming rules and scope. For example, while the name of a VM maps to a DNS name (and is thus required to be unique across all of Azure), the name of a VNET is scoped to the Resource Group that it is created within.

In general, avoid having any special characters (- or \_) as the first or last character in any name. These characters will cause most validation rules to fail.

#### General naming restrictions

| Entity           | Scope             | Length                  | Case sensitive | Valid Characters                                                          | Suggested Pattern                         | Example                     |
| ---------------- | ----------------- | ----------------------- | -------------- | ------------------------------------------------------------------------- | ----------------------------------------- | --------------------------- |
| Resource Group   | Subscription      | 1-90                    | false          | Alphanumeric, underscore, parentheses, hyphen, and period (except at end) | \<service short name\>-\<environment\>-rg | profx-prod-rg               |
| Availability Set | Resource Group    | 1-80                    | false          | Alphanumeric, underscore, and hyphen                                      | \<service-short-name\>-\<context\>-as     | profx-sql-as                |
| Tag              | Associated Entity | 512 (name), 256 (value) | false          | Alphanumeric                                                              | "key" : "value"                           | "department" : "Central IT" |

#### Compute naming restrictions

| Entity          | Scope          | Length                           | Case sensitive | Valid Characters        | Suggested Pattern              | Example         |
| --------------- | -------------- | -------------------------------- | -------------- | ----------------------- | ------------------------------ | --------------- |
| Virtual Machine | Resource Group | **1-15 (Windows), 1-64 (Linux)** | false          | Alphanumeric and hyphen | \<name\>-\<role\>-vm\<number\> | profx-sql-vm1   |
| Function App    | Global         | 1-60                             | false          | Alphanumeric and hyphen | \<name\>-func                  | calcprofit-func |

For all rules and restrictions, please visit [https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions\#naming-rules-and-restrictions](https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions).

### Affixes

When developing a  naming convention for a company or project, it is important to select a common set of affixes and their position (suffix or prefix).

While all the information about type, metadata and context is available via API, applying common affixes simplifies visual identification. When incorporating affixes into your naming convention, it is important to clearly specify whether the affix is at the beginning of the name (prefix) or at the end (suffix).

For instance, here are two possible names for a service hosting a calculation engine:

  - SvcCalculationEngine (prefix)

  - CalculationEngineSvc (suffix)

Affixes can refer to different aspects that describe the particular resources. See in the examples under chapter application.

[recommendations]: # ( start )
## Good Practices: Naming standards
### Affixes
#### Region
| Region               | Location             | Code     |
| -------------------- | -------------------- | -------- |
| Region Neutral       | Location Neutral     | **AAAA** |
| South Africa North   | Johannesburg         | SANO     |
| South Africa West    | Cape Town            | SAWE     |
| Central India        | Pune                 | INCE     |
| China East           | Shanghai             | CHEA     |
| China East 2         | Shanghai             | CHE2     |
| China North          | Beijing              | CHNO     |
| China North 2        | Beijing              | CHN2     |
| East Asia            | Hong Kong            | ASEA     |
| Japan East           | Tokyo, Saitama       | JAEA     |
| Japan West           | Osaka                | JAWE     |
| Korea Central        | Seoul                | KOCE     |
| Korea South          | Busan                | KOSO     |
| South India          | Chennai              | INSO     |
| Southeast Asia       | Singapore            | ASSO     |
| UAE Central          | Abu Dhabi            | UACE     |
| UAE North            | Dubai                | UANO     |
| West India           | Mumbai               | INWE     |
| Australia Central    | Canberra             | AUCE     |
| Australia Central 2  | Canberra             | AUC2     |
| Australia East       | New South Wales      | AUEA     |
| Australia Southeast  | Victoria             | AUSO     |
| France Central       | Paris                | FRCE     |
| France South         | Marseille            | FRSO     |
| Germany Central      | Frankfurt            | GECE     |
| Germany North        | Germany North        | GENO     |
| Germany Northeast    | Magdeburg            | GENE     |
| Germany West Central | Germany West Central | GEWC     |
| North Europe         | Ireland              | EUNO     |
| Norway East          | Norway               | NOEA     |
| Norway West          | Norway               | NOWE     |
| Switzerland North    | Zurich               | SCNO     |
| Switzerland West     | Geneva               | SCWE     |
| UK South             | London               | UKSO     |
| UK West              | Cardiff              | UKWE     |
| West Europe          | Netherlands          | **EUWE** |
| Canada Central       | Toronto              | CACE     |
| Canada East          | Quebec City          | CAEA     |
| Central US           | Iowa                 | USCE     |
| East US              | Virginia             | USEA     |
| East US 2            | Virginia             | USE2     |
| North Central US     | Illinois             | USNC     |
| South Central US     | Texas                | USSC     |
| US DoD Central       | Iowa                 | USGC     |
| US DoD East          | Virginia             | USGE     |
| US Gov Arizona       | Arizona              | USGA     |
| US Gov Iowa          | Iowa                 | USGI     |
| US Gov Texas         | Texas                | USGT     |
| US Gov Virginia      | Virginia             | USGV     |
| West Central US      | Wyoming              | UWCE     |
| West US              | California           | USW2     |
| West US 2            | Washington           | USWE     |
| Brazil South         | Sao Paulo State      | BRSO     |
| Azure Stack          | Datacenter           | AZBE     |

#### Environment
| Code | Description   |
| ---- | ------------- |
| DE   | Development   |
| TE   | Test          |
| ST   | Staging (UAT) |
| PR   | Production    |
| CO   | Core          |
| AU   | Automation    |
| SB   | Sandbox       |
| SP   | Special       |
| UN   | Undefined     |

#### Services
| Name                                          | Category     | Prefix | Suffix |
| --------------------------------------------- | ------------ | ------ | ------ |
| App Service                                   | App Services | APPS   |        |
| App Service Environment                       | App Services | APSE   |        |
| App Service Plan                              | App Services | ASPL   |        |
| Application Insights                          | App Services | AINS   |        |
| Application Security Group                    |              | APSG   |        |
| Automation Account                            | Serverless   | AUTO   |        |
| Availability Set                              | Compute      | AVSE   |        |
| Azure Analysis Services                       | Databases    | AASE   |        |
| Azure Application Gateway                     | Security     | AAGA   |        |
| Azure Automation Hybrid Worker                | Hybrid       |        |        |
| Azure Traffic Manager Profile                 | Networking   | ATMP   |        |
| Blob                                          | Storage      |        |        |
| Blueprints                                    | Governance   | BLPR   |        |
| Container                                     | Serverless   |        |        |
| Data Lake Store                               | Storage      |        |        |
| Event Grid Domains                            | Event Hub    | EGDO   |        |
| Event Grid Subscriptions                      | Event Hub    | EGSU   |        |
| Event Hubs                                    | Event Hub    | EVHU   |        |
| Event Hubs Topics                             | Event Hub    | EHTO   |        |
| External Load Balancer                        | Compute      | LBEX   |        |
| File                                          | Storage      |        |        |
| Function                                      | Serverless   |        |        |
| Initative                                     | Governance   |        |        |
| Internal Load Balancer                        | Networking   | LBIN   |        |
| Key Vault                                     | Other        | KEYV   |        |
| Load Balancer	Networking                      | Networking   | LLBN   |        |
| Local Network Gateway                         | Networking   | LNGA   |        |
| Log Analytics Workspace                       | Monitoring   | LAWS   |        |
| Managed Disk	Storage                          | Storage      |        |        |
| Management Group                              | Governance   | MAGR   |        |
| Network Interface                             | Networking   |        | NIC    |
| Network Security Group                        | Networking   | NSGR   |        |
| Network Security Group Rule                   | Networking   |        |        |
| Policies                                      | Governance   |        |        |
| Public IP Address                             | Networking   |        | PIP    |
| Public IP Address	Networking                  | Networking   | PUBN   |        |
| Queue                                         | Serverless   |        |        |
| Recovery Service Vault Storage                | Backup       | RSVS   |        |
| Recovery Services Vault                       | Backup       | RSVA   |        |
| Recovery Services Vault – Azure Backup Policy | Backup       | ABPO   |        |
| Ressource Group                               | Governance   | RSGR   |        |
| Route Table                                   | Networking   | NRTA   |        |
| SQL Database                                  | Database     | SQDB   |        |
| SQL Datawarehouse                             | Database     | SQDB   |        |
| SQL Managed Instance                          | Database     | SQMI   |        |
| SQL Server                                    | Database     | SQSR   |        |
| Storage Account                               | Storage      |        |        |
| Storage Account Name (data)                   | Storage      |        |        |
| Storage Account Name (disk)                   | Storage      |        |        |
| Subnet                                        | Networking   | SNET   |        |
| Subscription                                  | Governance   | SUBS   |        |
| Table                                         | Databases    |        |        |
| Tag                                           | Governance   |        |        |
| Virtual Machine                               | Compute      |        |        |
| Virtual Network (VNet)                        | Networking   | VNET   |        |
| VNet Peering                                  | Networking   | VNPE   |        |
| VPN Gateway                                   | Networking   | VPNW   |        |

### Naming Conventions

If this naming convention used only for a single-tenant, you can omit the **TenantShort** term. But if you are an MSP/CSP or uses services from it, it recommended that you use this in your notation.

#### Management Group

*Corp Pattern*: `<Prefix>_<CORP|TenantShort>_<Level>` \
*Corp ID Pattern*: `<Prefix>_<ManagementGroupID>_<Level>`

*Name Pattern*: `<Prefix>_[TenantShort]_<Scope>_<Level>` \
*ID Pattern*: `<Prefix>_<ManagementGroupID>_<Level>`

*Examples*:

| ID          | Name            |
| ----------- | --------------- |
| MAG_0001_00 | MAG_CORP_00     |
| MAG_0002_01 | MAG_Infra_01    |
| MAG_0003_01 | MAG_Standard_01 |
| MAG_0004_01 | MAG_Special_01  |
| MAG_0005_02 | MAG_SuplierA_02 |
| MAG_0006_02 | MAG_SuplierB_02 |

| ID          | Name                 |
| ----------- | -------------------- |
| MAG_0007_00 | MAG_MYTC_00          |
| MAG_0008_01 | MAG_MYTC_Infra_01    |
| MAG_0009_01 | MAG_MYTC_Standard_01 |

*Description*:

| Identifiers       | Range | Values/Meaning                                                                | Comments |
| ----------------- | ----- | ----------------------------------------------------------------------------- | -------- |
| Prefix            | 3     | MAG = Management Group                                                        |          |
| ManagementGroupID | 4     | Ongoing numbering                                                             |          |
| TenantShort       | 4     | MYTC = My Top Company                                                         |          |
| Scope             | 5..30 | Infra <br> Standard <br> Special <br> Others                                  |          |
| Level             | 2     | 00 = Top Level <br> 01 = Level under Top Level <br> 02 = Level under Level 01 |          |


#### Subscription
*Pattern*:
`<Prefix>_[TenantShort]_<Environment>_<SubscriptionID>_<Product|Service|Team>_<VersionNr>`

*Examples*:

SUB_AU_0001_CentralAutomation_01\
SUB_CO_0001_CentralServices_01\
SUB_SB_0001_CentralSandbox_01\
SUB_PR_1001_BusinesServices_01

SUB_MYTC_AU_0001_CentralAutomation_01\
SUB_MYTC_CO_0001_CentralServices_01\
SUB_MYTC_SB_0001_CentralSandbox_01\
SUB_MYTC_PR_1001_BusinesServices_01\
SUB_MYTC_TE_1002_BusinesServices_01\
SUB_MYTC_DE_1003_BusinesServices_01\
SUB_MYTC_PR_1004_VDIServices_01\
SUB_MYTC_SP_2001_ExternalCorpA_01

*Description*:

| Identifiers            | Range | Values/Meaning                                                                                                                              | Comments |
| ---------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| Prefix                 | 3     | SUB = Subscription                                                                                                                          |          |
| TenantShort            | 4     | MYTC = My Top Company                                                                                                                       |          |
| Environment            | 2     | Described in the chapter Affixes, Environment                                                                                               |          |
| SubscriptionID         | 4     | Ongoing numbering per environment, the first position of the number stands for: <br> 0 = Infrastructure <br> 1 = Standard <br> 2 = Special. |          |
| Product\|Service\|Team | 5..20 | CentralAutomation <br> CentralServices <br> BusinesServices <br> VDIServices <br> ExternalCorpA                                             |          |
| VersionNr              | 2     | 01..99                                                                                                                                      |          |



#### Tag
<br><br><br><br><br><br><br><br>


#### Blueprints
*Pattern*: `<Prefix>_<Description>_<VersionNr>`

*Examples*:
BLP_Automation_01
BLP_Backup_01
BLP_BasicConfig_01


*Description*:

| Identifiers | Range | Values/Meaning                                            | Comments |
| ----------- | ----- | --------------------------------------------------------- | -------- |
| Prefix      | 3     | BLP = Blueprints                                          |          |
| Description | 4     | A description that best describes the purpose or content. |          |
| VersionNr   | 2     | 01..99                                                    |          |


#### Ressource Group
*Pattern*: `<Prefix>_[TenantShort]_<Environment>_<Region>_<Service|System>_<VersionNr>`

*Examples*:

RSG_AU_EUWE_Automation_01\
RSG_CO_AAAA_Core_01\
RSG_CO_AAAA_Network_01\
RSG_PR_AAAA_Network_01\
RSG_PR_AAAA_Security_01\
RSG_PR_AAAA_Storage_01

RSG_MYTC_AU_EUWE_Automation_01\
RSG_MYTC_CO_AAAA_Core_01\
RSG_MYTC_CO_AAAA_Network_01\
RSG_MYTC_CO_AAAA_Security_01\
RSG_MYTC_CO_AAAA_Storage_01\
RSG_MYTC_CO_AAAA_Backup_01
RSG_MYTC_CO_EUWE_DomainServices_01
RSG_MYTC_PR_AAAA_Network_01\
RSG_MYTC_PR_AAAA_Security_01\
RSG_MYTC_PR_AAAA_Storage_01\
RSG_MYTC_PR_EUWE_ApplicationA_01\
RSG_MYTC_TE_AAAA_Network_01\
RSG_MYTC_TE_AAAA_Security_01\
RSG_MYTC_TE_AAAA_Storage_01\
RSG_MYTC_TE_EUWE_ApplicationA_01

*Description*:

| Identifiers     | Range | Values/Meaning                                             | Comments |
| --------------- | ----- | ---------------------------------------------------------- | -------- |
| Prefix          | 3     | RSG = Ressource Group                                      |          |
| TenantShort     | 4     | MYTC = My Top Company                                      |          |
| Environment     | 2     | Described in the chapter Affixes, Environment              |          |
| Region          | 4     | Described in the chapter Affixes, Region                   |          |
| Service\|System | 5..25 | Describes a purpose for which the resource should be used. |          |
| VersionNr       | 2     | 01..99                                                     |          |

*Declaration*:

Resources that are managed from the same team, and where all resources planned to be member of the same resource group, are the best examples for the AAAA Region code.

#### Virtual Network (VNet)
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>_<VersionNr>`

*Examples*:

VNE_EUWE_CO_0001_01\
VNE_EUWE_PR_1001_01\
VNE_EUWE_TE_1002_01\
VNE_EUWE_DE_1003_01

VNE_MYTC_EUWE_CO_0001_01\
VNE_MYTC_EUWE_PR_1001_01\
VNE_MYTC_EUWE_TE_1002_01\
VNE_MYTC_EUWE_DE_1003_01

*Description*:

| Identifiers    | Range | Values/Meaning                                                            | Comments |
| -------------- | ----- | ------------------------------------------------------------------------- | -------- |
| Prefix         | 3     | VNE = Virtual Network                                                     |          |
| TenantShort    | 4     | MYTC = My Top Company                                                     |          |
| Region         | 4     | Described in the chapter Affixes, Region                                  |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                             |          |
| SubscriptionID | 4     | Same SubscriptionID in which subscription the resource will be published. |          |
| VersionNr      | 2     | 01..99                                                                    |          |


#### VNet Peering
*Pattern*: `<Prefix>_[SourceTenantShort]_<SourceRegion>_<SourceEnvironment>_<SourceSubscriptionID>_<SourceVersionNr>-[TargetTenantShort]_<TargetRegion>_<TargetEnvironment>_<TargetSubscriptionID>_<TargetVersionNr>`

*Examples*:

VNP_EUWE_CO_0001_01-EUWE_PR_1001_01\
VNP_EUWE_PR_1001_01-EUWE_CO_0001_01\
VNP_EUWE_CO_0001_01-EUWE_TE_1002_01\
VNP_EUWE_TE_1002_01-EUWE_CO_0001_01\
VNP_EUWE_CO_0001_01-EUWE_DE_1003_01\
VNP_EUWE_DE_1003_01-EUWE_CO_0001_01

VNP_MYTC_EUWE_CO_0001_01-MYTC_EUWE_PR_1001_01\
VNP_MYTC_EUWE_PR_1001_01-MYTC_EUWE_CO_0001_01\
VNP_MYTC_EUWE_CO_0001_01-MYTC_EUWE_TE_1002_01\
VNP_MYTC_EUWE_TE_1002_01-MYTC_EUWE_CO_0001_01\
VNP_MYTC_EUWE_CO_0001_01-MYTC_EUWE_DE_1003_01\
VNP_MYTC_EUWE_DE_1003_01-MYTC_EUWE_CO_0001_01

*Description*:

| Identifiers    | Range | Values/Meaning                                                     | Comments |
| -------------- | ----- | ------------------------------------------------------------------ | -------- |
| Prefix         | 3     | VNP = VNet Peering                                                 |          |
| TenantShort    | 4     | MYTC = My Top Company                                              |          |
| Region         | 4     | Described in the chapter Affixes, Region                           |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                      |          |
| SubscriptionID | 4     | Same SubscriptionID which is also used for the corresponding VNet. |          |
| VersionNr      | 2     | 01..99                                                             |          |


#### Subnet
*Pattern*: `<Prefix>_<Region>_<Environment>_<SubscriptionID>_[CustomerShort]_<Service|System>_<AreaShort>`

*Examples*:

SNE_EUWE_CO_0001_Frontend_FE\
SNE_EUWE_CO_0001_Backend_BE\
SNE_EUWE_CO_0001_Management_MG\
SNE_EUWE_CO_0001_DomainServices_FE\
SNE_EUWE_PR_1001_Frontend_FE\
SNE_EUWE_PR_1001_Backend_BE\
SNE_EUWE_PR_1001_Management_MG\
SNE_MYTC_EUWE_PR_1001_DMZ_FE\
SNE_MYTC_EUWE_PR_1001_DMZ_BE\
SNE_MYTC_EUWE_PR_1001_AppServer_BE\

*Description*:

| Identifiers     | Range | Values/Meaning                                                     | Comments |
| --------------- | ----- | ------------------------------------------------------------------ | -------- |
| Prefix          | 3     | VNP = VNet Peering                                                 |          |
| TenantShort     | 4     | MYTC = My Top Company                                              |          |
| Region          | 4     | Described in the chapter Affixes, Region                           |          |
| Environment     | 2     | Described in the chapter Affixes, Environment                      |          |
| SubscriptionID  | 4     | Same SubscriptionID which is also used for the corresponding VNet. |          |
| Service\|System | 5..25 | Describes a purpose for which the resource should be used.         |          |
| AreaShort       | 2     | FE = Frontend <br> BE = Backend <br> MG = Management               |          |

#### Route Table
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>_<VersionNr>`

*Examples*:

NRT_EUWE_CO_0001_01\
NRT_EUWE_PR_1001_01\
NRT_EUWE_TE_1002_01\
NRT_EUWE_DE_1003_01

NRT_MYTC_EUWE_CO_0001_01\
NRT_MYTC_EUWE_PR_1001_01\
NRT_MYTC_EUWE_TE_1002_01\
NRT_MYTC_EUWE_DE_1003_01


*Description*:

| Identifiers    | Range | Values/Meaning                                                     | Comments |
| -------------- | ----- | ------------------------------------------------------------------ | -------- |
| Prefix         | 3     | VNE = Virtual Network                                              |          |
| TenantShort    | 4     | MYTC = My Top Company                                              |          |
| Region         | 4     | Described in the chapter Affixes, Region                           |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                      |          |
| SubscriptionID | 4     | Same SubscriptionID which is also used for the corresponding VNet. |          |
| VersionNr      | 2     | 01..99                                                             |          |


#### Network Security Group
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>_<Service|System>_<AreaShort>`

*Examples*:

NSG_EUWE_CO_0001_Frontend_FE\
NSG_EUWE_CO_0001_Backend_BE\
NSG_EUWE_CO_0001_Management_MG\
NSG_EUWE_CO_0001_DomainServices_FE\
NSG_EUWE_PR_1001_Frontend_FE\
NSG_EUWE_PR_1001_Backend_BE\
NSG_EUWE_PR_1001_Management_MG

NSG_MYTC_EUWE_CO_0001_Frontend_FE\
NSG_MYTC_EUWE_CO_0001_Backend_BE\
NSG_MYTC_EUWE_CO_0001_Management_MG\
NSG_MYTC_EUWE_CO_0001_DomainServices_FE\
NSG_MYTC_EUWE_PR_1001_Frontend_FE\
NSG_MYTC_EUWE_PR_1001_Backend_BE\
NSG_MYTC_EUWE_PR_1001_Management_MG\
NSG_MYTC_EUWE_PR_1001_CSTA_DMZ_FE\
NSG_MYTC_EUWE_PR_1001_CSTA_DMZ_BE\
NSG_MYTC_EUWE_PR_1001_CSTA_AppServer_BE\
NSG_MYTC_EUWE_PR_1001_CSTB_AppServer_BE

*Description*:

| Identifiers     | Range | Values/Meaning                                                     | Comments |
| --------------- | ----- | ------------------------------------------------------------------ | -------- |
| Prefix          | 3     | NSG = Network Security Group                                       |          |
| TenantShort     | 4     | MYTC = My Top Company                                              |          |
| Region          | 4     | Described in the chapter Affixes, Region                           |          |
| Environment     | 2     | Described in the chapter Affixes, Environment                      |          |
| SubscriptionID  | 4     | Same SubscriptionID which is also used for the corresponding VNet. |          |
| Service\|System | 5..25 | Describes a purpose for which the resource should be used.         |          |
| AreaShort       | 2     | FE = Frontend <br> BE = Backend <br> MG = Management               |          |

*Declaration*:

Network Security Groups inherit the name of the Subnet, they are not using a counter as there can’t be multiple NSG with the same name.

#### Network Security Group Rule
*Pattern*: `<Prefix>_<Direction>_<Protocol>_<Action>_<FromToWhere|Service|System>_<ShortPortDescription>`

*Examples*:

Inbound:\
NSR_in_TCP_allow_JUMPtoVNET-RDP\
NSR_in_ANY_allow_CXCCtoVDAIP-WEB

Outbound:\
NSR_out_TCP_allow_JUMPtoVNET-RDP\
NSR_out_ANY_allow_WAPtoWAP-ANY


*Description*:

| Identifiers                  | Range | Values/Meaning                                                  | Comments                                                                                                              |
| ---------------------------- | ----- | --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Prefix                       | 3     | NSR = Network Security Group Rule                               |                                                                                                                       |
| Direction                    | 2..3  | in <br> out                                                     |                                                                                                                       |
| Protocol                     | 3     | ANY <br> TCP <br> UDP                                           |                                                                                                                       |
| Action                       | 4..5  | allow <br> deny                                                 |                                                                                                                       |
| FromToWhere\|Service\|System | 5..20 | JUMPtoVNET <br> CXCCtoVDAIP <br> ONPREMtoJUMP <br> WAPtoWAP     | As a rule, an abbreviation of 4 characters per service is attempted here. But this is not a hard value at the moment. |
| ShortPortDescription         | 2..8  | RDP <br> HTTP <br> HTTPS <br> ICA <br> DNS <br> WEB <br> DOMAIN |                                                                                                                       |


#### Application Security Group
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>_<Service|System>_<VersionNr>`

*Examples*:
ASG_EUWE_CO_0001_WAP_01\
ASG_EUWE_CO_0001_ADDC_01\
ASG_EUWE_CO_0001_ADFS_01\
ASG_EUWE_CO_0001_ADCA_01\
ASG_EUWE_CO_0001_AADC_01

ASG_MYTC_EUWE_CO_0001_WAP_01\
ASG_MYTC_EUWE_CO_0001_ADDC_01\
ASG_MYTC_EUWE_CO_0001_ADFS_01\
ASG_MYTC_EUWE_CO_0001_ADCA_01\
ASG_MYTC_EUWE_CO_0001_AADC_01

*Description*:

| Identifiers     | Range | Values/Meaning                                                     | Comments |
| --------------- | ----- | ------------------------------------------------------------------ | -------- |
| Prefix          | 3     | SUB = Subscription                                                 |          |
| TenantShort     | 4     | MYTC = My Top Company                                              |          |
| Region          | 4     | Described in the chapter Affixes, Region                           |          |
| Environment     | 2     | Described in the chapter Affixes, Environment                      |          |
| SubscriptionID  | 4     | Same SubscriptionID which is also used for the corresponding VNet. |          |
| Service\|System | 5..25 | Describes a purpose for which the resource should be used.         |          |
| VersionNr       | 2     | 01..99                                                             |          |

#### VPN Gateway
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>`

*Examples*:

VPN_EUWE_CO_0001

VPN_MYTC_EUWE_CO_0001


*Description*:

| Identifiers    | Range | Values/Meaning                                                            | Comments |
| -------------- | ----- | ------------------------------------------------------------------------- | -------- |
| Prefix         | 3     | VPN = VPN Gateway                                                         |          |
| TenantShort    | 4     | MYTC = My Top Company                                                     |          |
| Region         | 4     | Described in the chapter Affixes, Region                                  |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                             |          |
| SubscriptionID | 4     | Same SubscriptionID in which subscription the resource will be published. |          |

#### Local Network Gateway
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>`

*Examples*:

LNG_EUWE_CO_0001

LNG_MYTC_EUWE_CO_0001


*Description*:

| Identifiers    | Range | Values/Meaning                                                            | Comments |
| -------------- | ----- | ------------------------------------------------------------------------- | -------- |
| Prefix         | 3     | LNG = Local Network Gateway                                               |          |
| TenantShort    | 4     | MYTC = My Top Company                                                     |          |
| Region         | 4     | Described in the chapter Affixes, Region                                  |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                             |          |
| SubscriptionID | 4     | Same SubscriptionID in which subscription the resource will be published. |          |

##### Connection
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<SubscriptionID>_<SiteName>`

*Examples*:

LNG_EUWE_CO_0001_HQ

LNG_MYTC_EUWE_CO_0001_HQ


*Description*:

| Identifiers    | Range | Values/Meaning                                                            | Comments |
| -------------- | ----- | ------------------------------------------------------------------------- | -------- |
| Prefix         | 3     | LNG = Local Network Gateway                                               |          |
| TenantShort    | 4     | MYTC = My Top Company                                                     |          |
| Region         | 4     | Described in the chapter Affixes, Region                                  |          |
| Environment    | 2     | Described in the chapter Affixes, Environment                             |          |
| SubscriptionID | 4     | Same SubscriptionID in which subscription the resource will be published. |          |
| SiteName       | 2..20 | A descriptive name of the remote site.                                    |          |


#### Internal Load Balancer
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<LBFunction><Nr>_<VersionNr>`

*Examples*:

LBI_EUWE_CO_GENP01_01\
LBI_EUWE_CO_CXSF01_01

LBI_MYTC_EUWE_CO_GENP01_01\
LBI_MYTC_EUWE_CO_CXSF01_01

*Description*:

| Identifiers | Range | Values/Meaning                                                                      | Comments |
| ----------- | ----- | ----------------------------------------------------------------------------------- | -------- |
| Prefix      | 3     | LBI = Internal Load Balancer                                                        |          |
| TenantShort | 4     | MYTC = My Top Company                                                               |          |
| Region      | 4     | Described in the chapter Affixes, Region                                            |          |
| Environment | 2     | Described in the chapter Affixes, Environment                                       |          |
| LBFunction  | 4     | GENP =  General Purpose <br> or a name that corresponds to the destination service. |          |
| Nr          | 2     | 01..99, a number that is oriented towards the target service.                       |          |
| VersionNr   | 2     | 01..99                                                                              |          |

#### Public Load Balancer
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<LB-Function><Nr>_<VersionNr>`

*Examples*:

LBP_EUWE_CO_GENP01_01\
LBP_EUWE_CO_WAP001_01

LBP_MYTC_EUWE_CO_GENP01_01\
LBP_MYTC_EUWE_CO_WAP001_01

*Description*:

| Identifiers | Range | Values/Meaning                                                                      | Comments |
| ----------- | ----- | ----------------------------------------------------------------------------------- | -------- |
| Prefix      | 3     | LBP = Public Load Balancer                                                          |          |
| TenantShort | 4     | MYTC = My Top Company                                                               |          |
| Region      | 4     | Described in the chapter Affixes, Region                                            |          |
| Environment | 2     | Described in the chapter Affixes, Environment                                       |          |
| LBFunction  | 4     | GENP =  General Purpose <br> or a name that corresponds to the destination service. |          |
| Nr          | 2     | 01..99, a number that is oriented towards the target service.                       |          |
| VersionNr   | 2     | 01..99                                                                              |          |

#### Load Balancing Rules
*Pattern*: `<Prefix>_<HostnamePart>_<Type>_<Protocol>_<VersionNr>`

*Examples*:

LBP_WAP00001_FE_01\
LBP_WAP00001_BE_01\
LBP_WAP00001_HP-HTTPS_01\
LBP_WAP00001_LB-HTTPS_01\
LBP_WAP00001_IN-HTTPS_01

LBP_WAP00001_FE_01\
LBP_WAP00001_BE_01\
LBP_WAP00001_HP-HTTPS_01\
LBP_WAP00001_LB-HTTPS_01\
LBP_WAP00001_IN-HTTPS_01

*Description*:

| Identifiers  | Range | Values/Meaning                                                                                                                        | Comments |
| ------------ | ----- | ------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| Prefix       | 3     | Same as the Loadbalancer <br> LBI = Internal Load Balancer <br> LBP = Public Load Balancer                                            |          |
| HostnamePart | 6 + 2 | The descriptive part of the hostname, and the number of the first host.                                                               |          |
| Type         | 2     | FE = Frontend IP configuration <br> BE = Backend pool <br> HP = Health probe <br> LB = Load balancing rule <br> IN = Inbound NAT rule |          |
| Protocol     | 2..8  | HTTP <br> HTTPS <br> DNS                                                                                                              |          |
| VersionNr    | 2     | 01..99                                                                                                                                |          |


#### Automation Account
*Pattern*: `<Prefix>-[TenantShort]-<Region>-<Environment>-<Name>-<VersionNr>`

*Examples*:

AAA-EUWE-CO-CentalAutomation-01

AAA-MYTC-EUWE-CO-CentalAutomation-01

*Description*:

| Identifiers | Range | Values/Meaning                                | Comments |
| ----------- | ----- | --------------------------------------------- | -------- |
| Prefix      | 3     | AAA = Azure Automation Account                |          |
| TenantShort | 4     | MYTC = My Top Company                         |          |
| Region      | 4     | Described in the chapter Affixes, Region      |          |
| Environment | 2     | Described in the chapter Affixes, Environment |          |
| Name        | 5..20 | A descriptive name of the automation account. |          |
| VersionNr   | 2     | 01..99                                        |          |



#### Log Analytics Workspace
*Pattern*: `<Prefix>-[TenantShort]-<Region>-<Environment>-<SecurityLevel>-<Name>-<VersionNr>`

*Examples*:

LAW-EUWE-AU-N-Automation-01\
LAW-EUWE-CO-N-ShortRetention-01\
LAW-EUWE-CO-H-LongRetention-01

LAW-MYTC-EUWE-AU-N-Automation-01\
LAW-MYTC-EUWE-CO-N-ShortRetention-01\
LAW-MYTC-EUWE-CO-H-LongRetention-01

*Description*:

| Identifiers   | Range | Values/Meaning                                | Comments |
| ------------- | ----- | --------------------------------------------- | -------- |
| Prefix        | 3     | LAW = Log Analytics Workspace                 |          |
| TenantShort   | 4     | MYTC = My Top Company                         |          |
| Region        | 4     | Described in the chapter Affixes, Region      |          |
| Environment   | 2     | Described in the chapter Affixes, Environment |          |
| SecurityLevel | 1     | N = Normal Security <br> H = High Security    |          |
| Name          | 5..20 | A descriptive name of the workspace.          |          |
| VersionNr     | 2     | 01..99                                        |          |


#### Recovery Service Vault
*Pattern*: `<Prefix>-[TenantShort]-<Region>-<Environment>-<Name>-<VersionNr>`

*Examples*:

RSV-EUWE-AU-DefaultBackup-01\
RSV-EUWE-CO-DefaultBackup-01\
RSV-EUWE-PR-DefaultBackup-01\
RSV-EUWE-TE-DefaultBackup-01

RSV-MYTC-EUWE-AU-DefaultBackup-01\
RSV-MYTC-EUWE-CO-DefaultBackup-01\
RSV-MYTC-EUWE-PR-DefaultBackup-01\
RSV-MYTC-EUWE-TE-DefaultBackup-01

*Description*:

| Identifiers | Range | Values/Meaning                                | Comments |
| ----------- | ----- | --------------------------------------------- | -------- |
| Prefix      | 3     | RSV = Recovery Service Vault                  |          |
| TenantShort | 4     | MYTC = My Top Company                         |          |
| Region      | 4     | Described in the chapter Affixes, Region      |          |
| Environment | 2     | Described in the chapter Affixes, Environment |          |
| Name        | 5..20 | A descriptive name of the service vault.      |          |
| VersionNr   | 2     | 01..99                                        |          |

##### Azure Backup Policy
*Pattern*: `<Prefix>-[TenantShort]-<Region>-<Environment>-<Purpose>-<BackupSchedule>-<BackupTime>-<TimeZone>-<Instant>-<DailyRetention>-<WeeklyRetention>-[MontlyRetention]-[YearlyRetention]`

ABP-EUWE-AU-AVM-D-22-UTCP01-1-7-SO5\
ABP-EUWE-CO-AVM-D-22-UTCP01-1-7-SO5\
ABP-EUWE-CO-AVM-D-22-UTCP01-1-7-SO5-1stSO12-Jan1stSO10\
ABP-EUWE-PR-AVM-D-22-UTCP01-1-7-SO5\
ABP-EUWE-PR-AVM-D-22-UTCP01-1-7-SO5-1stSO12-Jan1stSO10\
ABP-EUWE-TE-AVM-D-22-UTCP01-1-7-SO5\
ABP-EUWE-TE-AVM-D-22-UTCP01-1-7-SO5-1stSO12-Jan1stSO10

| Identifiers     | Range | Values/Meaning                                                                                                                                                                                        | Comments                             |
| --------------- | ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| Prefix          | 3     | ABP = Azure Backup Policy                                                                                                                                                                             |                                      |
| TenantShort     | 4     | MYTC = My Top Company                                                                                                                                                                                 |                                      |
| Region          | 4     | Described in the chapter Affixes, Region                                                                                                                                                              |                                      |
| Environment     | 2     | Described in the chapter Affixes, Environment                                                                                                                                                         |                                      |
| Purpose         | 3     | AVM = Azure Virtual Machines <br> AFS = Azure File Share <br> SQL = SQL Server in Azure VM                                                                                                            |                                      |
| BackupSchedule  | 1     | D = Daily <br> W = Weekly                                                                                                                                                                             |                                      |
| BackupTime      | 2     | Time, only hour                                                                                                                                                                                       |                                      |
| TimeZone        | 6     | UTCP01 = UTC + 1h <br> UTCM01 = UTC - 1h                                                                                                                                                              |                                      |
| Instant         | 1     | Day: 1..5                                                                                                                                                                                             | Retain instant recovery snapshot(s). |
| DailyRetention  | 1..4  | Day: 1..9999                                                                                                                                                                                          | Retention of daily backup point.     |
| WeeklyRetention | 3..6  | Day: MO-SO or SE (Several) <br> for 1..5163 weeks.                                                                                                                                                    | Retention of weekly backup point.    |
| MontlyRetention | 6..9  | On Week Base: 1st,2nd,3rd,4th,LAS = Last <br> On Day Base: 1..28,LA = Last <br> Day: MO-SO or SE (Several) <br> for 1..1188 months.                                                                   | Retention of monthly backup point.   |
| YearlyRetention | 6..10 | In: Jan, Feb, Mar, Apr, Mai, Jun, Jul, Aug, Sep, Oct, Nov, Dec <br> On Week Base: 1st,2nd,3rd,4th,LAS = Last <br> On Day Base: 1..28\|LA = Last <br> Day: MO-SO or SE (Several) <br> for 1..99 years. | Retention of yearly backup point.    |

#### Availability Set
*Pattern*: `<Prefix>_[TenantShort]_<Region>_<Environment>_<HostnamePart>_<VersionNr>`

*Examples*:

AVS_EUWE_CO_WAP00001_01\
AVS_EUWE_CO_ADDC0001_01\
AVS_EUWE_PR_CXSF0001_01

AVS_MYTC_EUWE_CO_WAP00001_01\
AVS_MYTC_EUWE_CO_ADDC0001_01\
AVS_MYTC_EUWE_PR_CXSF0001_01

*Description*:

| Identifiers  | Range | Values/Meaning                                                          | Comments |
| ------------ | ----- | ----------------------------------------------------------------------- | -------- |
| Prefix       | 3     | AVS = Availability Set                                                  |          |
| TenantShort  | 4     | MYTC = My Top Company                                                   |          |
| Region       | 4     | Described in the chapter Affixes, Region                                |          |
| Environment  | 2     | Described in the chapter Affixes, Environment                           |          |
| HostnamePart | 6 + 2 | The descriptive part of the hostname, and the number of the first host. |          |
| VersionNr    | 2     | 01..99                                                                  |          |

<!---
#### Template
*Pattern*: `<Prefix>_<Region>_<Environment>_<VersionNr>`

*Examples*:


*Description*:

| Identifiers | Range | Values/Meaning                                | Comments |
| ----------- | ----- | --------------------------------------------- | -------- |
| Prefix      | 3     | SUB = Subscription                            |          |
| Region      | 4     | Described in the chapter Affixes, Region      |          |
| Environment | 2     | Described in the chapter Affixes, Environment |          |
| VersionNr   | 2     | 01..99                                        |          |
--->

[recommendations]: # ( end )
