import os
import json

modules_path = os.getenv("WORKSPACE_MODULE_DIR")

# This is the list we'll store the different categories
tbc_terraform_manifest_categories = []

# This is the dict we'll store all the manifests in
tbc_terraform_manifest = {}

# Iterate through each module directory to compile the manifest
for module_dir in os.listdir(modules_path):

    # The meta/icon.svg and meta/meta.json file paths
    icon_path = f"{modules_path}/{module_dir}/meta/icon.svg"
    meta_path = f"{modules_path}/{module_dir}/meta/meta.json"

    # THe default icon svg
    icon_svg = '<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg  role="img" xmlns="http://www.w3.org/2000/svg" width="1000mm" height="1000mm" viewBox="0 0 1000 1000" style="max-width:1.6em; height: auto;"><path id="path" style="opacity:1;vector-effect:none;fill:#000000;fill-opacity:1;" d="M 500 0C 224 0 0 224 0 500C 0 776 224 1000 500 1000C 776 1000 1000 776 1000 500C 1000 224 776 0 500 0C 500 0 500 0 500 0 M 501 191C 626 191 690 275 690 375C 690 475 639 483 595 513C 573 525 558 553 559 575C 559 591 554 602 541 601C 541 601 460 601 460 601C 446 601 436 581 436 570C 436 503 441 488 476 454C 512 421 566 408 567 373C 566 344 549 308 495 306C 463 303 445 314 411 361C 400 373 384 382 372 373C 372 373 318 333 318 333C 309 323 303 307 312 293C 362 218 401 191 501 191C 501 191 501 191 501 191M 500 625C 541 625 575 659 575 700C 576 742 540 776 500 775C 457 775 426 739 425 700C 425 659 459 625 500 625C 500 625 500 625 500 625" transform=""></path></svg>'

    # Load the module meta/icon.svg if it has one
    if os.path.isfile(icon_path):
        with open(icon_path, 'r') as icon_file:
            icon_svg = icon_file.read()

    # Load the module manifest from the meta/meta.json file.
    with open(meta_path, 'r') as meta_file:
        module_manifest = json.load(meta_file)

    # This is where we'll load up things like input variable validation
    # TODO: Find a library that supports input variable validation
    #with open(f"{modules_path}/{module_dir}/variables.tf", 'r') as fp:
    #    terraform_objects = hcl.load(fp)

    # Sets the icon SVG that will be used for this module
    module_manifest['icon'] = icon_svg

    tbc_terraform_manifest[module_manifest['name']] = module_manifest

    category = str(module_manifest['category']).lower()
    if category not in tbc_terraform_manifest_categories:
        tbc_terraform_manifest_categories.append(category)


# Get the configured artifact name and directory and construct the full path.
artifact_name = os.getenv("MANIFEST_ARTIFACT_NAME")
artifact_directory = os.getenv("MANIFEST_ARTIFACT_PATH")
artifact_path = f"{artifact_directory}/{artifact_name}"

# Make sure the path exists and write the manifest file
os.makedirs(os.path.dirname(artifact_path), exist_ok=True)
f = open(artifact_path, "w")
f.write(json.dumps(tbc_terraform_manifest))
f.close()

# Make sure the path exists and write the manifest file
category_artifact_path = f"{artifact_directory}/manifest-categories.json"
os.makedirs(os.path.dirname(category_artifact_path), exist_ok=True)
f = open(category_artifact_path, "w")
f.write(json.dumps(tbc_terraform_manifest_categories))
f.close()