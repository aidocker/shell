#! /bin/sh
. ./env.properties
. ./env.sh
 
pids=`ps -ef|grep "$RUN_COMMAND" | grep -v "grep"|awk '{print $2}'`
if [ "$pids" = "" ]; then
 echo "[INFO]: $APP_NAME has stoped before !"
else
	 for pid in ${pids}; do
	 	kill -9 $pid 1>/dev/null 2>&1
 		echo "[INFO]: $APP_NAME[pid=$pid] has stoped!"
	 done
fi