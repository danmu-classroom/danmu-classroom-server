# Ruby 2.7.1 (matches .ruby-version / Gemfile). The official image is Debian
# buster and ships native arm64, so no amd64 emulation is needed on Apple Silicon.
FROM node:16-buster AS node

FROM ruby:2.7.1

# buster is EOL: its packages now live on archive.debian.org.
RUN sed -i -e 's|deb.debian.org|archive.debian.org|g' \
           -e 's|security.debian.org|archive.debian.org|g' \
           -e '/buster-updates/d' /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends postgresql-client \
 && rm -rf /var/lib/apt/lists/*

# Node + yarn for the node_modules that Sprockets pulls in (bootstrap, jquery, popper).
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /opt /opt
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
 && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
 && ln -s /opt/yarn-v*/bin/yarn /usr/local/bin/yarn \
 && node --version && yarn --version

RUN gem install bundler -v 2.1.4
