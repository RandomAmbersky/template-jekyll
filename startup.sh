#!/bin/bash

# exit when any command fails
set -e

echo "MODE_ENV=${MODE_ENV}"

case "${MODE_ENV}" in
    new)
        jekyll new my-awesome-site && cd my-awesome-site && bundle install
    ;;
    serve)
        cd my-awesome-site
        bundle install
        jekyll serve --force_polling --livereload --host 0.0.0.0
    ;;
    loop)
        tail -f /dev/null
    ;;
    *)
    echo "Unsupported MODE_ENV=${MODE_ENV}"
    exit 1
esac
