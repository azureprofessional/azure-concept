# Introduction

The following document is a recommended concept in order to set up an Azure Environment. As many aspects need to be kept in mind, the concept is about the whole Azure Environment and how it needs to be built, so that future Azure projects/builds doesn’t face foreseeable restrictions.

Azure has grown rapidly since its introduction in 2008. This growth required Microsoft engineering teams to rethink their approach for managing and deploying services. The Azure Resource Manager model was introduced in 2014 and replaces the classic deployment model. Resource Manager enables organizations to more easily deploy, organize, and control Azure resources. Resource Manager includes parallelization when creating resources for faster deployment of complex, interdependent solutions. It also includes granular access control, and the ability to tag resources with metadata. We recommend that all resources are created through the Resource Manager model.

## General recommendations for moving to the cloud

  | Recommendations for Azure enterprise administration ||
  | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | Limit the number of administrative users            | Assign a minimum number of users as Subscription Administrators and/or Co-administrators.                                                                                    |
  | Use Role-Based Access                               | Use Azure Resource Management RBAC whenever possible to control the amount of access that administrators have, and log what changes are made to the environment.             |
  | Use work accounts                                   | You should sign up for Azure as an organization and use a work or school account to manage resources in Azure. Do not allow the use of existing personal Microsoft Accounts. |
  | Define naming conventions                           | Assign meaningful names to your Azure subscriptions according to defined naming conventions.                                                                                 |
  | Use management groups to group your subscriptions   | Create your own "root" Management group. Don't modify the built-in management group. Create a structure that reflects your organization, in the view of departments, services and release cycles. |
  | Use a managment subscription                        | Begin by creating a Management Subscription from which you want to perform the automation. Also included in this subscription are services that are to be disconnected from the hub but still centralized, e.g. Workspaces for Log Analytics or Storage Account for Cloudshell. However, no VNet is created in it. |
  | Use Tier 0 subscription (Hub)                       | Use Tier 0 subscription to host shared resources, such as domain controllers and other sensitive roles, and limit the privileges to access it.                               |
  | Use Tier 1 subscriptions (Spoke)                    | Use Tier 1 subscription for the rest of the subscriptions. |
  | Use project subscriptions                           | Use decentralized project subscriptions. Delegate management of those subscriptions to the responsible project teams.                                                        |
  | Separate production from QA                         | Separate QA environments into distinct subscriptions to allow separation of access and to allow the QA subscription to scale on its own without impacting production.        |
