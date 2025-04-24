# ruby on GitHub Pages
FROM ruby:3.3.4

# Создаем пользователя с явным UID (например, 1000)
# RUN groupadd -r -g 1000 jekyllgroup && \
#     useradd -r -u 1000 -g jekyllgroup jekylluser \
#     && mkdir -p /home/jekylluser \
#     && chown -R jekylluser:jekyllgroup /home/jekylluser

# Устанавливаем Bundler и версию Jekyll, совместимую с GitHub Pages
RUN gem install github-pages -v "232" --no-document

# USER jekylluser

WORKDIR /src

ENV MODE_ENV='undefined env'

CMD [ "./bin/startup.sh" ]
