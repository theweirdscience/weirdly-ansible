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
    echo -n "Stopping $name"
    kill `get_pid`
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        if ! is_running; then
            break
        fi

        echo -n "."
        sleep 1
    done
    echo

    if is_running; then
        echo "Not stopped; may still be shutting down or shutdown may have failed"
        exit 1
    else
        echo "Stopped"
        if [ -f "$pid_file" ]; then
            rm "$pid_file"
        fi
    fi
else
    echo "Not running"
fi
