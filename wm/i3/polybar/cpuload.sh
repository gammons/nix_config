#!/usr/bin/env bash

PATH=/run/current-system/sw/bin:$PATH

uptime | grep -ohe 'load average[s:][: ].*' | sed 's/,//g' | awk '{print $3" "$4" "$5}'
