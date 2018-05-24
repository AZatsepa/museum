FROM ruby:2.5.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
    nodejs \
    xvfb \
    xauth \
    qt5-default \
    libqt5webkit5-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-tools \
    gstreamer1.0-x \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install bundler && bundle install
COPY . .
CMD ./script/start.sh
