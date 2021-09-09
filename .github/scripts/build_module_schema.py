import os
import json

modules_path = os.getenv("WORKSPACE_MODULE_DIR")

# Iterate through each module directory to compile the manifest
for module_dir in os.listdir(modules_path):

    # The meta/icon.svg and meta/meta.json file paths
    meta_path = f"{modules_path}/{module_dir}/meta/meta.json"

    # Load the module manifest from the meta/meta.json file.
    with open(meta_path, 'r') as meta_file:
        module_manifest = json.load(meta_file)

        """
        {
            "name": "rust_server_name",
            "type": "string",
            "description": "The publicly visible server name",
            "default": "Rust Server [DOCKER]"
        }
        """

    module_properties = {}
    required_properties = []
    for variable in module_manifest.get('variables'):

        # Add the parameter to the list of required parameters if it doesn't have a default
        if not variable.get("default"):
            required_properties.append(variable.get("name"))

        module_properties[variable.get("name")] = {
          "type": variable.get("type"),
          "minLength": 8,
          "maxLength": 80,
          "title": variable.get("name"),
          "attrs": {
            "placeholder": variable.get("default"),
            "title": variable.get("description")
            }
        }

    module_scheme = {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "title": module_manifest["title"],
        "description": module_manifest["description"],
        "properties": module_properties,
        "additionalProperties": False,
        "required": required_properties
    }

    # Get the configured artifact name and directory and construct the full path.
    artifact_name = os.getenv("MANIFEST_ARTIFACT_NAME")
    artifact_directory = os.getenv("MANIFEST_ARTIFACT_PATH")
    artifact_path = f"{artifact_directory}/schemas/modules/{module_manifest['name']}/{artifact_name}"

    print(json.dumps(module_properties))

    # Make sure the path exists and write the manifest file
    os.makedirs(os.path.dirname(artifact_path), exist_ok=True)
    f = open(artifact_path, "w")
    f.write(json.dumps(module_scheme))
    f.close()
