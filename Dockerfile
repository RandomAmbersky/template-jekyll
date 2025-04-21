FROM debian:12.10-slim

RUN apt-get update && apt-get install -y \
    ruby \
    ruby-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN ruby --version && gem install jekyll
