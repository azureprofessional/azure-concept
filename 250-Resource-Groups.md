# Resource Groups

After the subscriptions are created, the resource groups should be planned.

**In general, all the resources in your group should share the same lifecycle**. You deploy, update, and delete them together. If one resource, such as a database server, needs to exist on a different deployment cycle it should be in another resource group.

General information about resource groups:

1.  Each resource can only exist in one resource group.

2.  You can add or remove a resource to a resource group at any time.

3.  You can move a resource from one resource group to another group (not all resource types can be moved between resource groups)

4.  A resource group can contain resources that reside in different regions.

5.  A resource group can be used to scope access control for administrative actions.

6.  A resource can interact with resources in other resource groups. This interaction is common when the two resources are related but do not share the same lifecycle (for example, web apps connecting to a database).

When creating a resource group, you need to provide a location for that resource group. The resource group stores metadata about the resources. Therefore, when you specify a location for the resource group, you are specifying where that metadata is stored. For compliance reasons, you may need to ensure that your data is stored in a particular region. The region for the resource group is also important if the resources are deployed by templates (see section 15.1 Provisioning with templates).

Each subscription contains a Resource Group per Service (depending on which pattern you **go). Additionally, in each subscription will be one resource group containing all network components to ensure connectivity between the different subscriptions (or regions) (see section** **9** **Networking)**.

Consider the Hub-Spoke Architecture in **section** **9.5** when planning your Resource groups.

Source: <https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview#resource-groups>