# Security

## Infrastructure Security

### VM Security

#### VM Authentication and access control

The first step in protecting your VM is to ensure that only authorized users are able to set up new VMs. You can use Azure policies to establish conventions for resources in your organization, create customized policies, and apply these policies to resources, such as resource groups.

VMs that belong to a resource group naturally inherit its policies. Although we recommend this approach to managing VMs, you can also control access to individual VM policies by using role-based access control (RBAC).

When you enable Resource Manager policies and RBAC to control VM access, you help improve overall VM security. We recommend that you consolidate VMs with the same life cycle into the same resource group. By using resource groups, you can deploy, monitor, and roll up billing costs for your resources. To enable users to access and set up VMs, use a least privilege approach. And when you assign privileges to users, plan to use the following built-in Azure roles:

- **Virtual Machine Contributor:** Can manage VMs, but not the virtual network or storage account to which they are connected.
- **Security Manager:** Can manage security components, security policies, and VMs.
- **DevTest Labs User:** Can view everything and connect, start, restart, and shut down VMs.

Don't share accounts and passwords between administrators, and don't reuse passwords across multiple user accounts or services, particularly passwords for social media or other non-administrative activities. Ideally, you should use Azure Resource Manager templates to set up your VMs securely. By using this approach, you can strengthen your deployment choices and enforce security settings throughout the deployment.

Organizations that do not enforce data-access control by taking advantage of capabilities such as RBAC might be granting their users more privileges than necessary. Inappropriate user access to certain data can directly compromise that data.

## Networking Security

### Core networking resources

Access to resources can be either internal (within the corporation's network) or external (through the internet). It is easy for users in your organization to inadvertently put resources in the wrong spot, and potentially open them to malicious access. As with on-premises devices, enterprises must add appropriate controls to ensure that Azure users make the right decisions. For subscription governance, we identify core resources that provide basic control of access. The core resources consist of:

- **Virtual networks** are container objects for subnets. Though not strictly necessary, it is often used when connecting applications to internal corporate resources.
- **Network security groups** are similar to a firewall and provide rules for how a resource can "talk" over the network. They provide granular control over how/if a subnet (or virtual machine) can connect to the Internet or other subnets in the same virtual network.
- Create virtual networks dedicated to external-facing workloads and internal-facing workloads. This approach reduces the chance of inadvertently placing virtual machines that are intended for internal workloads in an external facing space.
- Configure network security groups to limit access. At a minimum, block access to the internet from internal virtual networks, and block access to the corporate network from external virtual networks.

Microsoft Azure enables you to connect virtual machines and appliances to other networked devices by placing them on Azure Virtual Networks. An Azure Virtual Network is a construct that allows you to connect virtual network interface cards to a virtual network to allow TCP/IP-based communications between network enabled devices. Azure Virtual Machines connected to an Azure Virtual Network are able to connect to devices on the same Azure Virtual Network, different Azure Virtual Networks, on the Internet or even on your own on-premises networks.

Azure Virtual Networks are similar to a LAN on your on-premises network. The idea behind an Azure Virtual Network is that you create a single private IP address space-based network on which you can place all your Azure Virtual Machines. The private IP address spaces available are in the Class A (10.0.0.0/8), Class B (172.16.0.0/12), and Class C (192.168.0.0/16) ranges.

## Role-based Access Control

Azure Role-Based Access Control (RBAC) enables fine-grained access management for Azure. Using RBAC, you can grant only the amount of access that users need to perform their jobs. We recommend going with the [least privilege security principles](https://en.wikipedia.org/wiki/Principle_of_least_privilege). 

Within each subscription, you can grant up to 2000 role assignments.

Restricting access based on the **least privilege security principles** is imperative for organizations that want to enforce security policies for data access. Azure Role-Based Access Control (RBAC) can be used to assign permissions to users, groups, and applications at a certain scope. The scope of a role assignment can be a subscription, a resource group, or a single resource.

You can leverage built in RBAC roles in Azure to assign privileges to users. Consider using Storage Account Contributor for cloud operators that need to manage storage accounts and Classic Storage Account Contributor role to manage classic storage accounts. For cloud operators that needs to manage VMs and storage account, consider adding them to Virtual Machine Contributor role.

Organizations that do not enforce data access control by leveraging capabilities such as RBAC may be giving more privileges than necessary to their users. This can lead to data compromise by allow users access to certain types of types of data (e.g., high business impact) that they shouldn’t have in the first place.

### Security Principal

A security principal is an object that represents a user, group, or service principal that is requesting access to Azure resources.

- **User** - An individual who has a profile in Azure Active Directory. You can also assign roles to users in other tenants. For information about users in other organizations, see Azure Active Directory B2B.
- **Group** - A set of users created in Azure Active Directory. When you assign a role to a group, all users within that group have that role.
- **Service principal** - A security identity used by applications or services to access specific Azure resources. You can think of it as a user identity (username and password or certificate) for an application.

### Role Definition

A role definition is a collection of permissions. It's sometimes just called a role. A role definition lists the operations that can be performed, such as read, write, and delete. Roles can be high-level, like owner, or specific, like virtual machine reader. 

### Built-In Roles

- **Owner** - Has full access to all resources including the right to delegate access to others.
- **Contributor** - Can create and manage all types of Azure resources but can’t grant access to others.
- **Reader** - Can view existing Azure resources.
- **User Access Administrator** - Lets you manage user access to Azure resources.

### Custom Roles

If the built-in roles don’t meet the specific needs of the organization, there can be
created custom roles. Just like built-in roles, custom roles can be assigned to users, groups, and service principals at subscription, resource group, and resource scopes. Custom roles are stored in an Azure Active Directory (Azure AD) tenant and can be shared across subscriptions. Each tenant can have up to 2000 custom roles. Custom roles can be created using Azure PowerShell, Azure CLI, or the REST API.

### Scope

Scope is the boundary that the access applies to. When you assign a role, you can further limit the actions allowed by defining a scope. This is helpful if you want to make someone a Website Contributor, but only for one resource group.

In Azure, you can specify a scope at multiple levels: subscription, resource group, or resource. Scopes are structured in a parent-child relationship where every child will have only one parent.

Access that you assign at a parent scope is inherited at the child scope. For example:

- If you assign the Reader role to a group at the subscription scope, the members of that group can view every resource group and resource in the subscription.
- If you assign the Contributor role to an application at the resource group scope, it can manage resources of all types in that resource group, but not other resource groups in the subscription.

Azure also includes a scope above subscriptions called management groups. When you specify scope for RBAC, you can either specify a management group or specify a subscription, resource group, or resource hierarchy.

### Assignment

A role assignment is the process of binding a role definition to a user, group, or service principal at a particular scope for the purpose of granting access. Access is granted by creating a role assignment, and access is revoked by removing a role assignment.

The diagram shows an example of a role assignment. In this example, the Marketing group has been assigned the Contributor role for the pharma-sales resource group. This means that users in the Marketing group can create or manage any Azure resource in the pharma-sales resource group. Marketing users do not have access to resources outside the pharma-sales resource group, unless they are part of another role assignment. 

## Resource Locks

As organizations add core services to the subscription, it becomes increasingly important to ensure that those services are available to avoid business disruption. Resource locks enable to restrict operations on high-value resources where modifying or deleting them would have a significant impact on your applications or cloud infrastructure. You can apply locks on a subscription-, resource group-, or resource-level. Typically, you apply locks to foundational resources such as **virtual networks, gateways, and storage accounts.**

Resource locks currently support two values: **CanNotDelete** and **ReadOnly**. **CanNotDelete** means that users (with the appropriate rights) can still read or modify a resource but cannot delete it. **ReadOnly** means that authorized users can't delete or modify a resource.

To create or delete management locks, you must have access to Microsoft.Authorization/* or Microsoft.Authorization/locks/* actions. Of the built-in roles, only Owner and User Access Administrator are granted those actions.

We recomment to protect core network options with locks. Accidental deletion of a gateway, site-to-site VPN would be disastrous to an Azure subscription. Azure doesn't allow you to delete a virtual network that is in use, but applying more restrictions is a helpful precaution.

- Virtual Network: CanNotDelete
- Network Security Group: CanNotDelete
- Policies: CanNotDelete

Policies are also crucial to the maintenance of appropriate controls. We recommend that you apply a CanNotDelete lock to polices that are in use.

## Azure Policy

IT governance creates clarity between business goals and IT projects. Good IT governance involves planning your initiatives and setting priorities on a strategic level. Does your company experience a significant number of IT issues that never seem to get resolved? Implementing policies helps you better manage and prevent them. Implementing policies is where Azure Policy comes in.

Azure Policy is a service in Azure that you use to create, assign and, manage policy definitions. Policy definitions enforce different rules and actions over your resources, so those resources stay compliant with your corporate standards and service level agreements. Azure Policy runs an evaluation of your resources, scanning for those not compliant with the policy definitions you have. For example, you can have a policy to allow only certain type of virtual machines. **Another requires that all resources have a particular tag**. These policies are then evaluated when creating and updating resources.

### How is it different from RBAC?

There are a few key differences between policy and role-based access control (RBAC). RBAC focuses on user actions at different scopes. For example, you might be added to the contributor role for a resource group at the desired scope. The role allows you to make changes to that resource group. Policy focuses on resource properties during deployment and for already existing resources. For example, through policies, you can control the types of resources that can be provisioned. Or, you can restrict the locations in which the resources can be provisioned. Unlike RBAC, policy is a default allow and explicit deny system.

To use policies, you must be authenticated through RBAC. Specifically, your account needs the:

- Microsoft.Authorization/policydefinitions/write permission to define a policy.
- Microsoft.Authorization/policyassignments/write permission to assign a policy.
- Microsoft.Authorization/policySetDefinitions/write permission to define an initiative.
- Microsoft.Authorization/policyassignments/write permission to assign an initiative.

These permissions are not included in the Contributor role.

### Policy Definition

Every policy definition has conditions under which it is enforced. Additionally, it has an accompanying action that takes place if the conditions are met.

Azure Policy offers some built-in policies that are available to you by default. For example:

- Require SQL Server 12.0: This policy definition has conditions/rules to ensure that all SQL servers use version 12.0. Its action is to deny all servers that do not meet these criteria.
- Allowed Storage Account SKUs: This policy definition has a set of conditions/rules that determine if a storage account that is being deployed is within a set of SKU sizes. Its action is to deny all servers that do not adhere to the set of defined SKU sizes.
- Allowed Resource Type: This policy definition has a set of conditions/rules to specify the resource types that your organization can deploy. Its action is to deny all resources that are not part of this defined list.
- Allowed Locations: This policy enables you to restrict the locations that your organization can specify when deploying resources. Its action is used to enforce your geo-compliance requirements.
- Allowed Virtual Machine SKUs: This policy enables you to specify a set of virtual machine SKUs that your organization can deploy.
- Apply tag and its default value: This policy applies a required tag and its default value, if it is not specified by the user.
- Enforce tag and its value: This policy enforces a required tag and its value to a resource.
- Not allowed resource types: This policy enables you to specify the resource types that your organization cannot deploy.
- You can assign any of these policies through the Azure portal, PowerShell, or Azure CLI.

## Sources

[Azure Resource Locks](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-subscription-governance#azure-resource-locks)

[Azure Policy Introduction](https://docs.microsoft.com/en-us/azure/azure-policy/azure-policy-introduction)