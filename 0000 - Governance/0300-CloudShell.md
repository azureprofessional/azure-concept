# Azure Cloud Shell

Storage accounts that you create in Cloud Shell are tagged with ``ms-resource-usage:azure-cloud-shell``. If you want to manage the naming, disallow users from creating storage accounts in Cloud Shell or something else, create an Azure resource policy for tags that are triggered by this specific tag.

Source: <https://docs.microsoft.com/en-us/azure/cloud-shell/persisting-shell-storage>
