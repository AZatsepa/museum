#!/bin/bash
bundle exec rubocop
bin/slim-lint . -c .slim_lint.yml
bundle exec rspec
bundle exec cucumber
