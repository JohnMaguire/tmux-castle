#!/bin/bash

sess="irc"

function start_tmux() {
	tmux -2 new-session -d \
		-s "$sess" \
		-n "irc" \
		"/usr/bin/weechat"

	tmux new-window -d \
		-t "$sess:1" \
		-n "cardinal logs" \
		-c "/home/jmaguire/src/Cardinal/" \
		"sudo docker-compose -p cardinal-darkscience -f docker-compose.yml -f docker-compose.darkscience.yml logs -f --tail=1000"
}

function stop_tmux() {
	tmux kill-session -t "$sess"
}

case "$1" in
	start) start_tmux ;;
	stop) stop_tmux ;;
	restart) stop_tmux; start_tmux ;;
	*) echo "usage: $0 start|stop|restart" >&2
		exit 1
		;;
esac
