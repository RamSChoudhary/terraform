
package terraform.tag_validation
import future.keywords
import input.resource_changes

# Tag checking functions
# Read all tags from a resource
readTags(resource) = tags {
    tags = resource.change.after.tags
}

missingTags(resource, tagList) if {
    keys := { key | resource.change.after.tags[key] }
    missing := tagList - keys
    missing == set()
}

required_tags := {"environment","project","owner"}

tags_contain_required(resource_checks) = resources {
    resources := [ resource | 
      resource := resource_checks[_]
      not (missingTags(resource, required_tags))
    ]
}

kv := get_resources_by_type("azurerm_key_vault", resource_changes)

get_resources_by_type(type, resources) = filtered_resources {
    filtered_resources := [resource | resource := resources[_]; resource.type = type]
}

deny[msg] {
    resources := tags_contain_required(kv)
    resources != []
    msg := sprintf("The following resources are missing required tags: %s", [resources[_].address])
}
