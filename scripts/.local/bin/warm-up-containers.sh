#!/usr/bin/env bash

systemctl --user start open-webui-quadlet

# Running the distrobox command in the background and disconnecting it from the script/terminal
nohup distrobox enter general > /dev/null 2>&1 &
disown
