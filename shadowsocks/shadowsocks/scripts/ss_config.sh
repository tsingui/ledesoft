#!/bin/sh

alias echo_date1='echo $(date +%Y年%m月%d日\ %X)'
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export ss_`

# this part for start up
case $1 in
start)
	# the soft link should be create after boot
	[ "$ss_basic_enable" == "1" ] && sh /koolshare/ss/ssstart.sh start_all > /tmp/upload/ss_log.txt
	;;
stop)
	sh /koolshare/koolproxy/kp_config.sh stop > /tmp/upload/kp_log.txt
	;;
esac

# this part for web runing using httpdb
case $2 in
1)
	if [ "$ss_basic_enable" == "1" ];then
		sh /koolshare/ss/ssstart.sh start_all > /tmp/upload/ss_log.txt
	else
		sh /koolshare/ss/ssstart.sh stop > /tmp/upload/ss_log.txt
	fi
	http_response $1
	;;
10)
	# do not delete this, it's usefull when saving ss_node data
	http_response "$1"
	;;
esac