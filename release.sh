#!/bin/bash
set -euo pipefail

LAST_VERSION=$(jq -r '.version' update.json)
LAST_VERSION_CODE=$(jq -r '.versionCode' update.json)
NEW_VERSION_CODE=$(($LAST_VERSION_CODE + 1))

echo "=====Making release====="
echo "Last version: $LAST_VERSION"
echo "Last version code: $LAST_VERSION_CODE"
read -p "Enter new version: " NEW_VERSION

echo ""
echo "New version: $NEW_VERSION"
echo "New version code: $NEW_VERSION_CODE"
read -p "Proceed? [Y/n] " response
response=${response,,}

if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then
    cat update.json | jq ".version = \"$NEW_VERSION\"" | tee update.json > /dev/null
    cat update.json | jq ".versionCode = \"$NEW_VERSION_CODE\"" | tee update.json > /dev/null
    sed -i -e "s/version=[^ ]*/version=$NEW_VERSION/g" module.prop
    sed -i -e "s/versionCode=[^ ]*/versionCode=$NEW_VERSION_CODE/g" module.prop
    git add module.prop update.json && git commit -m "$NEW_VERSION" && git tag "$NEW_VERSION" -m "$NEW_VERSION"
    git push
    git push --tags

    make all
    echo "Release $NEW_VERSION complete, please upload the artifact."
fi
