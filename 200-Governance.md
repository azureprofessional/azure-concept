# Governance

In real life, scaffolding is used to create the basis of the structure. The scaffold guides the general outline and provides anchor points for more permanent systems to be mounted. An enterprise scaffold is the same: a set of flexible controls and Azure capabilities that provide structure to the environment, and anchors for services built on the public cloud. It provides the builders (IT and business groups) a foundation to create and attach new services.

![](.//media/image3.png)The following image describes the components of the scaffold. The foundation relies on a solid plan for departments, accounts, and subscriptions. The pillars consist of Resource Manager policies and strong naming standards. The rest of the scaffold comes from core Azure capabilities and features that enable a secure and manageable environment. The enterprise scaffold is explicitly designed for the Resource Manager model.

## Hierarchy for Enterprise enrollments

![](.//media/image4.png)The foundation of the scaffold is the Azure Enterprise Enrollment (and the Enterprise Portal). The enterprise enrollment defines the shape and use of Azure services within a company and is the core governance structure. Within the enterprise agreement, customers can further subdivide the environment into departments, accounts and finally, subscriptions. An Azure subscription is the basic unit where all resources are contained. It also defines several limits within Azure, such as number of cores, resources, etc.

Every enterprise is different and the hierarchy in the previous image allows for significant flexibility in how Azure is organized within the company. Before implementing the guidance contained in this document, the hierarchy should be modelled and the impact on billing, resource access, and complexity understood.

![](.//media/image5.png)![](.//media/image6.png)![](.//media/image7.png)

## Patterns

The three common patterns for Azure enrolments are:

  - Functional pattern

  - Business unit pattern

  - Geographic pattern

![](.//media/image7.png)![](.//media/image5.png)![](.//media/image6.png)![](.//media/image7.png)![](.//media/image5.png)![](.//media/image6.png)![](.//media/image7.png)![](.//media/image5.png)![](.//media/image6.png)![](.//media/image7.png)![](.//media/image6.png)The following roles will be defined:

EA = Enterprise Admin, DA = Department Admin, AO = Account Owner, SA = Service Admin

![](.//media/image8.png)

First, the administrators are defined in the portal (ea.azure.com). This could be either a Microsoft or a work or school account. We recommend using a Work-Account.

![](.//media/image9.png)Secondly, the departments are created. A department can’t live without DA. If there is no DA specified, the EA will be the DA of the department:

Once the department is created, accounts can be created on the department. Each department needs to have account owners, those are the only one who can create subscriptions on the account. If a EA wants to create subscriptions on an account, he needs to add himself as the account owner.

![](.//media/image10.png)At the account level, each account can be named as Dev/Test and therefore be treated separately:

![](.//media/image11.png)When the account is created, a subscription can be assigned:

This approach is resumed in the CSP Model – whereas the customer doesn’t have an Enterprise portal, but multiple subscriptions that are bound to his Active Directory.

## CSP Hierarchy

![](.//media/image12.png)If Azure Services are provided by a Cloud Service Provider as Corporate Software, all the administrative elements above the subscription are eliminated. Within the CSP, the different defined subscriptions are bound directly to an Azure Active Directory (Azure AD).

CSP provided Azure subscriptions can only be managed over the ARM (Azure Resource Manager) Portal. There are no service or co-administrators. To control access, Azure provides roles (see chapter 16.3 Role based access control (RBAC)).

The CSP licence provider is always the owner over all of the ordered subscriptions and defines who else is owner of a subscription. This definition is modelled on the Azure AD tenant of the CSP.

Source: <https://docs.microsoft.com/en-us/azure/security/governance-in-azure>
Source: <https://www.credera.com/blog/credera-site/azure-governance-part-2-using-subscriptions-resource-groups-building-blocks/>