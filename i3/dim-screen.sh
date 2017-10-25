#!/bin/bash

trap "exit 0" INT TERM
# figure out something to do here
sleep 2147483647 &
wait
