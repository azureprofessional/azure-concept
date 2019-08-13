# Naming standards

## Introduction
The first pillar of the scaffold is naming standards. Well-designed naming standards enable to identify resources in the portal, on a bill, and within scripts. Most likely, there are already naming standards for on-premises infrastructure. When adding Azure to your environment, those naming standards should be extended to your Azure resources. Naming standard facilitate more efficient management of the environment at all levels.

The choice of a name for any resource in Microsoft Azure is important because:

  - It is difficult to change a name later.

  - Names must meet the requirements of their specific resource type.

Consistent naming conventions make resources easier to locate. They can also indicate the role of a resource in a solution.

The key to success with naming conventions is establishing and following them across your applications and organizations.

### Subscriptions

When naming Azure subscriptions, verbose names make understanding the context and purpose of each subscription clear. When working in an environment with many subscriptions, following a shared naming convention can improve clarity.

A recommended pattern for naming subscriptions is:

**\<Company\> \<Department (optional)\> \<Product Line (optional)\> \<Environment\>**

  - Company would usually be the same for each subscription. However, some companies may have child companies within the organizational structure. These companies may be managed by a central IT group. In these cases, they could be differentiated by having both the parent company name and child company name.

  - Department is a name within the organization that contains a group of individuals. This item within the namespace is optional. For example: “IT”, “Marketing”, …

  - Product line is a specific name for a product or function that is performed from within the department. This is generally optional for internal-facing services and applications. However, it is highly recommended to use for public-facing services that require easy separation and identification (such as for clear separation of billing records).

  - Environment is the name that describes the deployment lifecycle of the applications or services, such as Dev, Test, or Prod.

### Rules and restrictions

Each resource or service type in Azure enforces a set of naming restrictions and scope; any naming convention or pattern must adhere to the requisite naming rules and scope. For example, while the name of a VM maps to a DNS name (and is thus required to be unique across all of Azure), the name of a VNET is scoped to the Resource Group that it is created within.

In general, avoid having any special characters (- or \_) as the first or last character in any name. These characters will cause most validation rules to fail.

#### General naming restrictions

| Entity           | Scope             | Length                  | Case sensitive           | Valid Characters                                                          | Suggested Pattern                         | Example                     |
| ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------------------------------------------------------- | ----------------------------------------- | --------------------------- |
| Resource Group   | Subscription      | 1-90                    | false | Alphanumeric, underscore, parentheses, hyphen, and period (except at end) | \<service short name\>-\<environment\>-rg | profx-prod-rg               |
| Availability Set | Resource Group    | 1-80                    | false | Alphanumeric, underscore, and hyphen                                      | \<service-short-name\>-\<context\>-as     | profx-sql-as                |
| Tag              | Associated Entity | 512 (name), 256 (value) | false | Alphanumeric                                                              | "key" : "value"                           | "department" : "Central IT" |

#### Compute naming restrictions

| Entity          | Scope          | Length                           | Case sensitive | Valid Characters        | Suggested Pattern              | Example         |
| --------------- | -------------- | -------------------------------- | -------------- | ----------------------- | ------------------------------ | --------------- |
| Virtual Machine | Resource Group | **1-15 (Windows), 1-64 (Linux)** | false          | Alphanumeric and hyphen | \<name\>-\<role\>-vm\<number\> | profx-sql-vm1   |
| Function App    | Global         | 1-60                             | false          | Alphanumeric and hyphen | \<name\>-func                  | calcprofit-func |

For all rules and restrictions, please visit [https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions\#naming-rules-and-restrictions](https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions).

### Affixes

When developing a specific naming convention for your company or projects, it is importantly to choose a common set of affixes and their position (suffix or prefix).

While all the information about type, metadata, context, is available programmatically, applying common affixes simplifies visual identification. When incorporating affixes into your naming convention, it is important to clearly specify whether the affix is at the beginning of the name (prefix) or at the end (suffix).

For instance, here are two possible names for a service hosting a calculation engine:

  - SvcCalculationEngine (prefix)

  - CalculationEngineSvc (suffix)

Affixes can refer to different aspects that describe the particular resources. See in the examples under chapter application.

## Application
## Affixes
### Region
| Region | Location | Code |
|--------|----------|------|
|South Africa North|Johannesburg|SANO|
|South Africa West|Cape Town|SAWE|
|Central India|Pune|INCE|
|China East|Shanghai|CHEA|
|China East 2|Shanghai|CHE2|
|China North|Beijing|CHNO|
|China North 2|Beijing|CHN2|
|East Asia|Hong Kong|ASEA|
|Japan East|Tokyo, Saitama|JAEA|
|Japan West|Osaka|JAWE|
|Korea Central|Seoul|KOCE|
|Korea South|Busan|KOSO|
|South India|Chennai|INSO|
|Southeast Asia|Singapore|ASSO|
|UAE Central|Abu Dhabi|UACE|
|UAE North|Dubai|UANO|
|West India|Mumbai|INWE|
|Australia Central|Canberra|AUCE|
|Australia Central 2|Canberra|AUC2|
|Australia East|New South Wales|AUEA|
|Australia Southeast|Victoria|AUSO|
|France Central|Paris|FRCE|
|France South|Marseille|FRSO|
|Germany Central|Frankfurt|GECE|
|Germany North|Germany North|GENO|
|Germany Northeast|Magdeburg|GENE|
|Germany West Central|Germany West Central|GEWC|
|North Europe|Ireland|EUNO|
|Norway East|Norway|NOEA|
|Norway West|Norway|NOWE|
|Switzerland North|Zurich|SCNO|
|Switzerland West|Geneva|SCWE|
|UK South|London|UKSO|
|UK West|Cardiff|UKWE|
|West Europe|Netherlands|EUWE|
|Canada Central|Toronto|CACE|
|Canada East|Quebec City|CAEA|
|Central US|Iowa|USCE|
|East US|Virginia|USEA|
|East US 2|Virginia|USE2|
|North Central US|Illinois|USNC|
|South Central US|Texas|USSC|
|US DoD Central|Iowa|USGC|
|US DoD East|Virginia|USGE|
|US Gov Arizona|Arizona|USGA|
|US Gov Iowa|Iowa|USGI|
|US Gov Texas|Texas|USGT|
|US Gov Virginia|Virginia|USGV|
|West Central US|Wyoming|UWCE|
|West US|California|USW2|
|West US 2|Washington|USWE|
|Brazil South|Sao Paulo State|BRSO|
|Azure Stack|Datacenter|AZBE|

### Environment
| Code | Description |
|------|-------------|
|DE|Development|
|TE|Test|
|ST|Staging (UAT)|
|PR|Production|
|CO|Core|
|AU|Automation|
|SB|Sandbox|
|SP|Special|
|UN|Undefined|

### Services
| Name | Category | Prefix | Suffix |
|------|----------|--------|--------|
| App Service |	App Services | aps | |

## Naming Conventions
### Management Groups

**Corp Pattern**: `<Prefix>_<CORP|TenantShort>_<Level>` \
**Corp ID Pattern**: `<Prefix>_<ManagementGroupID>_<Level>`

**Name Pattern**: `<Prefix>_[TenantShort]_<Scope>_<Level>` \
**ID Pattern**: `<Prefix>_<ManagementGroupID>_<Level>`

**Examples**:
| ID | Name |
|----|------|
| MAG_0001_00 | MAG_CORP_00 |
| MAG_0002_01 | MAG_Infra_01 |
| MAG_0003_01 | MAG_Standard_01 |
| MAG_0004_01 | MAG_Special_01 |
| MAG_0005_02 | MAG_SuplierA_02 |
| MAG_0006_02 | MAG_SuplierB_02 |
| MAG_0007_00 | MAG_MYTC_00 |
| MAG_0008_01 | MAG_MYTC_Infra_01 |
| MAG_0009_01 | MAG_MYTC_Standard_01 |

**Description**:
| Identifiers | Range | Values/Meaning | Comments |
|-------------|-------|----------------|----------|
| Prefix | 3 | MAG = Management Group | |
| ManagementGroupID | 4 | Ongoing numbering | |
| TenantShort | 4 | MYTC = My Top Company | |
| Scope | 5..30 | Infra <br> Standard <br> Special <br> Others | |
| Level | 2 | 00 = Top Level <br> 01 = Level under Top Level <br> 02 = Level under Level 01 | |


### Subscriptions
**Pattern**: `<Prefix>_<TenantShort>_<Environment>_<SubscriptionID>_<Product|Service|Team>_<VersionNr>`

**Examples**:\
SUB_MYTC_AU_0001_CentralAutomation_01\
SUB_MYTC_CO_0001_CentralServices_01\
SUB_MYTC_SB_0001_CentralSandbox_01\
SUB_MYTC_PR_1001_BusinesServices_01\
SUB_MYTC_TE_1002_BusinesServices_01\
SUB_MYTC_DE_1003_BusinesServices_01\
SUB_MYTC_PR_1004_VDIServices_01\
SUB_MYTC_SP_2001_ExternalCorpA_01

**Description**:
| Identifiers | Range | Values/Meaning | Comments |
|-------------|-------|----------------|----------|
| Prefix | 3 | SUB = Subscription | |
| TenantShort | 4 | MYTC = My Top Company | |
| Environment | 2 | Described in the chapter Affixes, Environment | |
| SubscriptionID | 4 | Ongoing numbering per environment | |
| Product\|Service\|Team | 5..20 | CentralAutomation <br> CentralServices <br> BusinesServices <br> VDIServices <br> ExternalCorpA| |
| VersionNr | 2 | 01..99 | |

### Ressource Groups
**Pattern**: `<Präfix>_<TenantShort>_[Environment]_<Region>_<Service|System>_<VersionNr>`

**Examples**:\


**Description**:
| Identifiers | Range | Values/Meaning | Comments |
|-------------|-------|----------------|----------|
| Prefix | 3 | RSG = Ressource Group | |
| TenantShort | 4 | MYTC = My Top Company | |
| Environment | 2 | Described in the chapter Affixes, Environment | |
| Region | 4 | Described in the chapter Affixes, Region | |
| Service\|System | 5..25 | | |
| VersionNr | 2 | 01..99 | |



### Template
**Pattern**: `<Prefix>_<TenantShort>_<Environment>_<VersionNr>`

**Examples**:\


**Description**:
| Identifiers | Range | Values/Meaning | Comments |
|-------------|-------|----------------|----------|
| Prefix | 3 | SUB = Subscription | |
| TenantShort | 4 | MYTC = My Top Company | |
| Environment | 2 | Described in the chapter Affixes, Environment | |
| VersionNr | 2 | 01..99 | |


Sources: <https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions>, <https://blogs.technet.microsoft.com/dsilva/2017/11/10/azure-subscription-governance-resource-group-and-naming-convention-strategies/>
