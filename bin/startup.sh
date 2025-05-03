#!/bin/bash

# exit when any command fails
set -e

if [ "$(id -u)" -eq 0 ]; then
    echo "Не запускайте скрипт от root!"
    exit 1
fi

echo "MODE_ENV=${MODE_ENV}"

case "${MODE_ENV}" in
    new)
        echo "Создание нового сайта Jekyll"
        jekyll -v

        # 1. Создаём временную папку в /tmp
        TEMP_DIR="/tmp/${SITE_DIR}_1"
        jekyll new ${TEMP_DIR} --force --skip-bundle

        # 2. Проверяем, существует ли целевая папка SITE_DIR
        if [ ! -d "$SITE_DIR" ]; then
            echo "Папка $SITE_DIR не найдена. Создаём..."
            mkdir -p "$SITE_DIR"
        fi

        # 3. Копируем содержимое из /tmp в SITE_DIR
        echo "Копируем файлы из $TEMP_DIR в $SITE_DIR..."
        cp -R "$TEMP_DIR"/. "$SITE_DIR"/

        # 4. Удаляем временную папку (опционально)
        rm -rf "$TEMP_DIR"

        echo "Готово! Новый сайт создан в папке ${SITE_DIR}"
    ;;
    clone)
         echo "Клонирование репозитория ${GITHUB_REPO}"

         if [ -d "${SITE_DIR}" ]; then
             echo "Ошибка: Папка ${SITE_DIR} уже существует"
             exit 1
         fi
         GIT_SSH_COMMAND="ssh -i ~/.ssh/${GITHUB_KEY_NAME}" git clone ${GITHUB_REPO} ${SITE_DIR}
         cd ${SITE_DIR}
         git checkout ${GITHUB_BRANCH}
         echo "Готово! Репозиторий склонирован в ${SITE_DIR}"
         ../bin/git-set-local.sh
    ;;
    anonimize)
        echo "Исправление всей истории коммитов на ${GITHUB_USER_NAME} ${GITHUB_USER_EMAIL} ${GITHUB_USER_NAME} ${GITHUB_USER_EMAIL}"
        cd ${SITE_DIR}
        ../bin/git-reset-author.sh
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

        bundle config set --global path '~/bundle' && bundle check || bundle install
        bundle exec jekyll serve --force_polling --livereload --host 0.0.0.0
    ;;
    push)
        cd ${SITE_DIR}
        git add .
        git commit -m "Update site content"
        git push origin ${GITHUB_BRANCH}
        echo "Changes pushed to GitHub"
    ;;
    push-force)
        echo "Try push force..."
        cd ${SITE_DIR}
        git push origin ${GITHUB_BRANCH} --force
        echo "Changes forced pushed to GitHub"
    ;;
    loop)
        tail -f /dev/null
    ;;
    *)
    echo "Unsupported MODE_ENV=${MODE_ENV}"
    exit 1
esac
