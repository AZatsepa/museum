FROM ruby:2.4.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
    nodejs \
    qt5-default \
    libqt5webkit5-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-tools \
    gstreamer1.0-x \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN \
  cd /tmp && \
  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  cd phantomjs-2.1.1-linux-x86_64 && \
  cp bin/phantomjs /usr/local/bin/ && \
  cd /tmp && \
  rm -rf /tmp/phantomjs
RUN gem install bundler && bundle install
COPY . .
# TODO: find solution for using webkit in Docker
ENV CAPYBARA_DRIVER poltergeist
CMD ./script/start.sh
