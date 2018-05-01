#!/usr/bin/env bash

#
# {{ ansible_managed }}
#

name="{{ elasticsearch_service_name }}"
bin_file="{{ elasticsearch_path }}/bin/elasticsearch"
pid_file="{{ elasticsearch_path }}/elasticsearch.pid"
log_file="{{ elasticsearch_path }}/logs/"

get_pid() {
    cat "$pid_file"
}

is_running() {
    [ -f "$pid_file" ] && ps -p `get_pid` > /dev/null 2>&1
}

if is_running; then
    echo "Already started"
    exit 0
else
    echo "Starting $name"
    "$bin_file" -d -p "$pid_file"
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        if is_running; then
            exit 0
        fi
        echo -n "."
        sleep 1
    done
    if ! is_running; then
        echo "Failed to start. See $log_file for details"
        exit 1
    fi
fi
