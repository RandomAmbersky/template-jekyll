#!/bin/bash

# exit when any command fails
set -e

echo "JEKYLL_ENV=${JEKYLL_ENV}"
echo "MODE_ENV=${MODE_ENV}"

case "${MODE_ENV}" in
    new)
        jekyll new my-awesome-site
    ;;
    serve)
        cd my-awesome-site && jekyll serve --watch --host 0.0.0.0
    ;;
    *)
    echo "Unsupported MODE_ENV=${MODE_ENV}"
    exit 1
esac
