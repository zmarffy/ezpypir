#! /usr/bin/env bash

pipPackageInstalled() {
    python3 -m pip show $1 > /dev/null 2>&1
    return $?
}

# Bumpversion if possible, else use user's inputted version
pipPackageInstalled "bumpversion"
if [ $? -eq 0 ]; then
    if [[ ! -z "$1" ]]; then
        newVersion=$(bumpversion --list $1 | grep new_version | sed -r s,"^.*=",,)
        if [[ -z "$newversion" ]]; then
            exit 1
        fi
    else
        echo "Need to specify a release type"
        exit 1
    fi
else
    if [[ -z "$1" ]]; then
        echo "Need to specify a version"
        exit 1
    else
        newVersion=$1
    fi
fi

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
