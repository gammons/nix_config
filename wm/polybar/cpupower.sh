#!/bin/sh

PATH=/run/current-system/sw/bin:$PATH

cpupower frequency-info -fm | grep -oP '(?<=frequency: )([^ ]+ [^ ]+)'
