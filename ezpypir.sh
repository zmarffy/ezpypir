#! /usr/bin/env bash

if [[ ! -z "$1" ]]; then
    newVersion=$(bumpversion --list $1 | grep new_version | sed -r s,"^.*=",,)
    if [[ -z "$newVersion" ]]; then
        exit 1
    fi
else
    echo "Need to specify a release type"
    exit 1
fi

# Push
git push

# Push GitHub tags
git push --tags

# Create GitHub release
gh release create ${newVersion} dist/*${newVersion}* 

# Build and upload
python3 setup.py sdist bdist_wheel || exit 1
twine upload dist/*${newVersion}* || exit 1

# If not yet installed locally, do so
packageName=$(python3 -c "import os; print(os.listdir('dist')[0].split('-')[0])") # Because who wants to do this in Bash?
if [[ -z "$packageName" ]]; then
    exit 1
fi
pipPackageInstalled "$packageName"
if [ $? -ne 0 ]; then
    python3 setup.py develop --user || exit 1
fi
