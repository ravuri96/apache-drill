#!/bin/sh
#subistute the environment varibles

envsubst < "$CONFIG_FILE_TEMPLATE_PATH" > "$CONFIG_FILE_PATH"

#show the config file

cat $CONFIG_FILE_PATH

#start the Drillbit && tailing Logs

/apache-drill/bin/drillbit.sh start && sleep 2 && tail -f /dev/null /apache-drill/log/*