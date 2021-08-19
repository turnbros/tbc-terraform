import os
import json

modules_path = os.getenv("WORKSPACE_MODULE_DIR")

# This is the dict we'll store all the manifests in
tbc_terraform_manifest = {}

# Iterate through each module directory to compile the manifest
for module_dir in os.listdir(modules_path):

    # Load the module manifest from the meta.json file.
    with open(f"{modules_path}/{module_dir}/meta.json", 'r') as fp:
        module_manifest = json.load(fp)

    # This is where we'll load up things like input variable validation
    # TODO: Find a library that supports input variable validation
    #with open(f"{modules_path}/{module_dir}/variables.tf", 'r') as fp:
    #    terraform_objects = hcl.load(fp)

    tbc_terraform_manifest[module_manifest['name']] = module_manifest

# Get the configured artifact name and directory and construct the full path.
artifact_name = os.getenv("MANIFEST_ARTIFACT_NAME")
artifact_directory = os.getenv("MANIFEST_ARTIFACT_PATH")
artifact_path = f"{artifact_directory}/{artifact_name}"

# Make sure the path exists and write the manifest file
os.makedirs(os.path.dirname(artifact_path), exist_ok=True)
f = open(artifact_path, "w")
f.write(json.dumps(tbc_terraform_manifest))
f.close()
