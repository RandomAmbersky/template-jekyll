#!/bin/sh

echo "Установка локальных настроек пользователя ${GITHUB_USER_NAME} ${GITHUB_USER_EMAIL} ${GITHUB_KEY_NAME}"
git config --local user.name "${GITHUB_USER_NAME}"
git config --local user.email "${GITHUB_USER_EMAIL}"
git config --local core.sshCommand "ssh -i ~/.ssh/${GITHUB_KEY_NAME} -o IdentityAgent=none"

echo "Локальные настройки:"
git --no-pager config --local --list
