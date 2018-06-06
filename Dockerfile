FROM ruby:2.5.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
    nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists
RUN cd /usr/local/share \
  && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && export PATH="$PATH:/usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/"
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install bundler && bundle install
COPY . .
CMD ./script/start.sh
