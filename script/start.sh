#!/bin/bash
if [[ -a './tmp/pids/server.pid' ]]; then
  rm ./tmp/pids/server.pid
fi
rails server -b 0.0.0.0 -P ./tmp/pids/server.pid
