# Container

## Azure Container Instances

Containers are becoming the preferred way to package, deploy, and manage cloud applications. Azure Container Instances offers the fastest and simplest way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service.

Azure Container Instances are a great solution for small-scale tasks like task automation, build jobs or simple applications. For large-scale operations where you require full container orchestration, automatic scaling or coordinated application upgrades, the Azure Kubernetes Service is the recommended solution. You can find more information on that further below.

Source: https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview

### Features

- **Faster startup times**
  Azure Container Instances can start containers in Azure in seconds, without the need to provision and manage VMs.
- **Public IP connectivity and DNS Name**
    Azure Container Instances enables exposing your containers directly to the internet with an IP address and a fully qualified domain name. When you create a container instance, you can specify a custom DNS name label so your application is reachable at *customlabel*.*azureregion*.azurecontainer.io.
- **Hypervisor-level security**
  Historically, containers have offered application dependency isolation and resource governance but have not been considered sufficiently hardened for hostile multi-tenant usage. Azure Container Instances guarantees your application is as isolated in a container as it would be in a VM.
- **Custom sizes**
  Containers are typically optimized to run just a single application, but the exact needs of those applications can differ greatly. Azure Container Instances provides optimum utilization by allowing exact specifications of CPU cores and memory. You pay based on what you need and get billed by the second, so you can fine-tune your spending based on actual need.
- **Persistent storage**
  To retrieve and persist state with Azure Container Instances, we offer direct mounting of Azure Files shares.
- **Linux and Windows containers**
  Azure Container Instances can schedule both Windows and Linux containers with the same API. Simply specify the OS type when you create your container groups. 

Source: https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview

### Securing your Azure Container Instances

- **Use a private registry**
  Containers are built from images that are stored in one or more repositories. These repositories can belong to a public registry, like Docker Hub, or to a private registry. An example of a private registry is the Docker Trusted Registry, which can be installed on-premises or in a virtual private cloud. You can also use cloud-based private container registry services, including Azure Container Registry.

  A publicly available container image does not guarantee security. Container images consist of multiple software layers, and each software layer might have vulnerabilities. To help reduce the threat of attacks, you should store and retrieve images from a private registry, such as Azure Container Registry or Docker Trusted Registry. In addition to providing a managed private registry, Azure Container Registry supports service principal-based authentication through Azure Active Directory for basic authentication flows. This authentication includes role-based access for read-only (pull), write (push), and owner permissions.

- **Monitor and scan container images**
  Security monitoring and scanning solutions such as Twistlock and Aqua Security are available through the Azure Marketplace. You can use them to scan container images in a private registry and identify potential vulnerabilities.

- **Protect credentials**
  Containers can spread across several clusters and Azure regions. So, you must secure credentials required for logins or API access, such as passwords or tokens. Ensure that only privileged users can access those containers in transit and at rest. Inventory all credential secrets, and then require developers to use emerging secrets-management tools that are designed for container platforms. Make sure that your solution includes encrypted databases, TLS encryption for secrets data in transit, and least-privilege role-based access control. Azure Key Vault is a cloud service that safeguards encryption keys and secrets for containerized applications. Because this data is sensitive and business critical, secure access to your key vaults so that only authorized applications and users can access them.

Source: https://docs.microsoft.com/en-us/azure/container-instances/container-instances-image-security

## Azure Container Registry

Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images.

Use container registries in Azure with your existing container development and deployment pipelines, or use ACR Tasks to build container images in Azure. Build on demand, or fully automate builds with source code commit and base image update build triggers.

Source: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro

### Service Tiers

Azure Container Registry (ACR) is available in multiple service tiers, known as SKUs. These SKUs provide predictable pricing and several options for aligning to the capacity and usage patterns of your private Docker registry in Azure.

| SKU          | Managed | Description                                                  |
| :----------- | :-----: | :----------------------------------------------------------- |
| **Basic**    |   Yes   | A cost-optimized entry point for developers learning about Azure Container Registry. Basic registries have the same programmatic capabilities as Standard and Premium (such as Azure Active Directory authentication integration, image deletion, and web hooks. However, the included storage and image throughput are most appropriate for lower usage scenarios. |
| **Standard** |   Yes   | Standard registries offer the same capabilities as Basic, with increased included storage and image throughput. Standard registries should satisfy the needs of most production scenarios. |
| **Premium**  |   Yes   | Premium registries provide the highest amount of included storage and concurrent operations, enabling high-volume scenarios. In addition to higher image throughput, Premium adds features including geo-replication for managing a single registry across multiple regions, content trust for image tag signing, and firewalls and virtual networks (preview) to restrict access to the registry. |

The Basic, Standard, and Premium SKUs (collectively called managed registries) all provide the same programmatic capabilities. They also all benefit from image storage managed entirely by Azure. Choosing a higher-level SKU provides more performance and scale. With multiple service tiers, you can get started with Basic, then convert to Standard and Premium as your registry usage increases.

Source: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-skus

### Best Practices

**Network-close deployment**

Create your container registry in the same Azure region in which you deploy containers. Placing your registry in a region that is network-close to your container hosts can help lower both latency and cost.

Network-close deployment is one of the primary reasons for using a private container registry. Docker images have an efficient [layering construct](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/) that allows for incremental deployments. However, new nodes need to pull all layers required for a given image. This initial `docker pull` can quickly add up to multiple gigabytes. Having a private registry close to your deployment minimizes the network latency. Additionally, all public clouds, Azure included, implement network egress fees. Pulling images from one datacenter to another adds network egress fees, in addition to the latency.

**Geo-replicate multi-region deployments**

Use Azure Container Registry's [geo-replication](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-geo-replication) feature if you're deploying containers to multiple regions. Whether you're serving global customers from local datacenters or your development team is in different locations, you can simplify registry management and minimize latency by geo-replicating your registry. Geo-replication is available only with [Premium](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-skus) registries.

To learn how to use geo-replication, see the three-part tutorial, [Geo-replication in Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-prepare-registry).

**Repository namespaces**

By leveraging repository namespaces, you can allow sharing a single registry across multiple groups within your organization. Registries can be shared across deployments and teams. Azure Container Registry supports nested namespaces, enabling group isolation.

For example, consider the following container image tags. Images that are used corporate-wide, like `aspnetcore`, are placed in the root namespace, while container images owned by the Production and Marketing groups each use their own namespaces.

**Dedicated resource group**

Because container registries are resources that are used across multiple container hosts, a registry should reside in its own resource group.

Although you might experiment with a specific host type, such as Azure Container Instances, you'll likely want to delete the container instance when you're done. However, you might also want to keep the collection of images you pushed to Azure Container Registry. By placing your registry in its own resource group, you minimize the risk of accidentally deleting the collection of images in the registry when you delete the container instance resource group.

**Authentication**

When authenticating with an Azure container registry, there are two primary scenarios: individual authentication, and service (or "headless") authentication. The following table provides a brief overview of these scenarios, and the recommended method of authentication for each.

| Type                      | Example scenario                                             | Recommended method                                           |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Individual identity       | A developer pulling images to or pushing images from their development machine. | [az acr login](https://docs.microsoft.com/en-us/cli/azure/acr?view=azure-cli-latest#az-acr-login) |
| Headless/service identity | Build and deployment pipelines where the user isn't directly involved. | [Service principal](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication#service-principal) |

For in-depth information about Azure Container Registry authentication, see [Authenticate with an Azure container registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication).

**Manage registry size**

The storage constraints of each [container registry SKU](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-skus) are intended to align with a typical scenario: **Basic** for getting started, **Standard** for the majority of production applications, and **Premium** for hyper-scale performance and [geo-replication](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-geo-replication). Throughout the life of your registry, you should manage its size by periodically deleting unused content.

You can use the Azure CLI command `az acr show-usage` to display the current size of your registry or find the current storage used in the Overview of your registry in the Azure Portal.

Source: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-best-practices

