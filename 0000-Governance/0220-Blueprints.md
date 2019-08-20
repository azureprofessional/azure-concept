# Blueprints

## What it is

Just as a blueprint allows an engineer or an architect to sketch out the design parameters for a project, Azure Blueprints enables cloud architects and central IT to define a repeatable set of Azure resources that implements and adheres to an organization's standards, patterns, and requirements. Azure Blueprints enables development teams to rapidly provision and stand up new environments knowing that they're built within organizational compliance and contain a set of built-in components -- such as networking -- to speed up development and delivery.

Blueprints are a declarative way to orchestrate the deployment of multiple resource templates and other artifacts such as:

  - Role Assignments

  - Policy Assignments

  - Azure Resource Manager templates

  - Resource Groups

## Difference to ARM Templates

Blueprints is designed to help with environment setup, which often consists of a set of resource groups, policies, and role assignments, in addition to Resource Manager template deployments. A blueprint is a package to bring each of these artifact types together and allow you to compose and version that package -- including through a CI/CD pipeline. Ultimately, each is assigned to a subscription in a single operation that can be audited and tracked.

Nearly everything that you want to include for deployment in Blueprints can be accomplished with a Resource Manager template. However, a Resource Manager template is a document that doesn’t exist natively in Azure – each is stored either locally or in source control. The template gets used for deployments of one or more Azure resources, but once those resources are deployed the connection and relationship to the template used is lost.

With Blueprints, the relationship between the blueprint definition (the what should be deployed) and the blueprint assignment (the what was deployed) remains. This connection enables improved tracking and auditing of deployments, the ability to upgrade multiple subscriptions at once that are governed by the same blueprint, and more.

There's no need to choose between a Resource Manager template and a blueprint. Each blueprint can consist of zero or more Resource Manager template artifacts. This means that previous efforts to develop and maintain a library of Resource Manager templates can be leveraged in Blueprints.

## Differences to Azure Policy

A blueprint is a package or container for composing focus-specific sets of standards, patterns, and requirements related to the implementation of Azure cloud services, security, and design that can be reused to ensure consistency and compliance.

A policy is a default allow and explicit deny system focused on resource properties during deployment and for already existing resources. It supports IT governance by ensuring that resources **within a subscription** adhere to requirements and standards.

Including a policy in a blueprint enables not only the creation of the right pattern or design during assignment of the blueprint, but ensures that only approved or expected changes can be made to the environment to ensure ongoing compliance to the intent of the blueprint.

A policy can be included as one of many artifacts in a blueprints definition. Blueprints also support using parameters with policies and initiatives.

## Definitions of Blueprints

A blueprint is made up of artifacts. Blueprints currently support the following resources as artifacts:

| Resource  | Hierarchy options | Description   |
| ----- | ----- | ---------- |
| Resource Groups                 | Subscription                 | Create a new resource group for use by other artifacts within the blueprint. These placeholder resource groups enable you to organize resources exactly the way you want them structured and provides a scope limiter for included policy and role assignment artifacts as well as Azure Resource Manager templates.                                                         |
| Azure Resource Manager template | Resource Group               | These templates can be used to compose complex environments such as a SharePoint farm, Azure Automation State Configuration, or a Log Analytics workspace.                                                                                                                                                                                                                   |
| Policy Assignment               | Subscription, Resource Group | Allows assignment of a policy or initiative to the management group or subscription the blueprint is assigned to. The policy or initiative must be within the scope of the blueprint (in the blueprint management group or below). If the policy or initiative has parameters, these parameters can be assigned at creation of the blueprint or during blueprint assignment. |
| Role Assignment                 | Subscription, Resource Group | Add an existing user or group to a built-in role to ensure the right people always have the right access to your resources. Role assignments can be defined for the entire subscription or nested to a specific resource group included in the blueprint.                                                                                                                    |

### Blueprints and management groups

When creating a blueprint definition, you'll define where the blueprint is saved. Currently, blueprints can only be **saved to a management group** that you have Contributor access to. The blueprint will then be available to assign to any child (management group or subscription) of that management group.

Important

If you don't have access to any management groups or any management groups configured, loading the list of blueprint definitions will show that none are available and clicking on Scope will open a window with a warning about retrieving management groups. To resolve this, ensure a subscription you have appropriate access to is part of a management group.

### Blueprint parameters

Blueprints can pass parameters to either a policy/initiative or an Azure Resource Manager template. When either artifact is added to a blueprint, the author is able to decide to provide a defined value for each blueprint assignment or to allow each blueprint assignment to provide a value at assignment time. This flexibility provides the option to define a pre-determined value for all uses of the blueprint or to enable that decision to be made at the time of assignment.

### Blueprint publishing

When a blueprint is first created, it's considered to be in Draft mode. When it's ready to be assigned, it needs to be Published. Publishing requires defining a Version string (letters, numbers, and hyphens with a maximum length of 20 characters) along with optional Change notes. The Version differentiates it from future changes to the same blueprint and allows each version to be assigned. This also means different Versions of the same blueprint can be assigned to the same subscription. When additional changes are made to the blueprint, the Published Version still exists, in addition to the Unpublished changes. Once the changes are complete, the updated blueprint is Published with a new and unique Version and can now also be assigned.

## Assignment of Blueprints

Each Published Version of a blueprint can be assigned to an existing subscription. In the portal, the blueprint will default the Version to the one Published most recently. If there are artifact parameters (or blueprint parameters), then the parameters will be defined during the assignment process.
