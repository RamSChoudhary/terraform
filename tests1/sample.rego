package terraform.tag_validation
import future.keywords
import input.resource_changes

# Required tags for all resources
required_tags := {"environment","project","owner"}

# Check to see if there are Virtual networks missing tags
kv := get_resources_by_type("azurerm_key_vault", resource_changes)

get_resources_by_type(type, resources) = filtered_resources {
    filtered_resources := [resource | resource := resources[_]; resource.type = type]
}

tags_contain_required(resource_checks) = resources {
    resources := [ resource | 
      resource := resource_checks[_]
      not (missingTags(resource, required_tags))
    ]
}

deny[msg]{
  msg := "No Deployments" 
}

#deny[msg] {
#    resources := tags_contain_required(kv)
#    resources != []
#    msg := sprintf("The following resources are missing required tags: %s", [resources[_].address])
#}

# Tag checking functions
# Read all tags from a resource
readTags(resource) = tags {
    tags = resource.change.after.tags
}

# Check if tag is present for a given resource
findTag(resource, tagName) if {
    readTags(resource)[tagName]
}

# Check if tag has proper value for a given resource
findValue(resource, tagName, tagValue) if {
    readTags(resource)[tagName] == tagValue
}

# Check if all tags are present for a given resource
missingTags(resource, tagList) if {
    keys := { key | resource.change.after.tags[key] }
    missing := tagList - keys
    missing == set()
}
