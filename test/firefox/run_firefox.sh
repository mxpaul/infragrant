#!/bin/sh
PULSE_GROUP="$(getent group audio | cut -d: -f3)" XDG_RUNTIME_DIR="/run/user/$UID" \
	docker-compose run -e "DISPLAY=$DISPLAY" firefox -rm

