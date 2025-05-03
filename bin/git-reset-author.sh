#!/bin/sh

# Credits: http://stackoverflow.com/a/750191

git filter-branch -f --env-filter "
    GIT_AUTHOR_NAME=${GITHUB_USER_NAME}
    GIT_AUTHOR_EMAIL=${GITHUB_USER_EMAIL}
    GIT_COMMITTER_NAME=${GITHUB_USER_NAME}
    GIT_COMMITTER_EMAIL=${GITHUB_USER_EMAIL}
  " HEAD
