FROM debian:12.10-slim

RUN apt-get update && apt-get install -y \
    ruby \
    ruby-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# USER user
ENV MODE_ENV='undefined env'

RUN ruby --version && gem install bundler jekyll

CMD [ "./bin/startup.sh" ]
