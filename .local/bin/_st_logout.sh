#!/usr/bin/env bash

# I use the laptop's speakers from time to time and I don't want no suprises, so
# we use wireplumber to set the volume down when logging out
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%

# Reset the powerprofile to balanced
powerprofilesctl set balanced
