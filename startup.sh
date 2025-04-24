#!/bin/bash

# exit when any command fails
set -e

echo "MODE_ENV=${MODE_ENV}"

# Настройки репозитория (замените на свои)
GITHUB_REPO="https://github.com/username/repo.git"
SITE_DIR="my-awesome-site"
BRANCH="main"  # или "gh-pages" для GitHub Pages

case "${MODE_ENV}" in
    new)
        echo "Создание нового сайта Jekyll"
        jekyll new my-awesome-site
        echo "Готово! Новый сайт создан в папке ${SITE_DIR}"
    ;;
    clone)
         echo "Клонирование репозитория ${GITHUB_REPO}"
         if [ -d "${SITE_DIR}" ]; then
             echo "Ошибка: Папка ${SITE_DIR} уже существует"
             exit 1
         fi
         git clone ${GITHUB_REPO} ${SITE_DIR}
         cd ${SITE_DIR}
         git checkout ${BRANCH}
         echo "Готово! Репозиторий склонирован в ${SITE_DIR}"
    ;;
    serve)
        if [ ! -d "${SITE_DIR}" ]; then
            echo "Ошибка: Папка ${SITE_DIR} не существует. Сначала выполните:"
            echo "  make clone"
            echo "или "
            echo "  make new"
            exit 1
        fi

        cd ${SITE_DIR}

        bundle check || bundle install
        bundle exec jekyll serve --force_polling --livereload --host 0.0.0.0
    ;;
    push)
        cd ${SITE_DIR}
        git add .
        git commit -m "Update site content"
        git push origin ${BRANCH}
        echo "Changes pushed to GitHub"
    ;;
    loop)
        tail -f /dev/null
    ;;
    *)
    echo "Unsupported MODE_ENV=${MODE_ENV}"
    exit 1
esac
