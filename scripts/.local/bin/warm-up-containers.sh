#!/usr/bin/env bash

# Running the distrobox command in the background and disconnecting it from the script/terminal
nohup distrobox enter general > /dev/null 2>&1 &
disown
