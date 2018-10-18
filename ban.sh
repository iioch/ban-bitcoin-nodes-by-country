#!/bin/bash

# ban.sh
# shell script to automatically identify and ban bitcoin clients by country

# You need to install jq in order to use this script
command -v jq >/dev/null 2>&1 || { echo >&2 "Please install \"jq\" first. Aborting."; exit 1; }

# You need to install geoiplookup in order to use this script
command -v geoiplookup >/dev/null 2>&1 || { echo >&2 "Please install \"geopiplookup\" first. Aborting."; exit 1; }

# Adjust CLIENT variable so it calls bitcoin-cli with the right parameters
# Non standart installations need to add -conf=/PATHtoYOUR/bitcoin.conf -datadir=/PATH/to/YOUR/Datadir/
CLIENT=/usr/local/bin/bitcoin-cli

# Ban Time in seconds, 36000 = 10h, 2592000 = 30 days
BAN_TIME="36000"

# Temp files
NODES_FILE="`mktemp /tmp/connected-nodes.XXXXXXXXXX`"
BANNED_FILE="`mktemp /tmp/banned-nodes.XXXXXXXXXX`"

# Counter
COUNTER=0

# Write connected nodes to NODES_FILE
$CLIENT getpeerinfo >$NODES_FILE

# Extract IP address
NODES_TO_BAN=`jq -r '.[] | .addr'  $NODES_FILE`

# Country shortcode to ban, eg. CN is China, in ISO 3166 Country Code Format
Shortcode=CN

# geoiplookup function
func () {
geoiplookup $1 | cut -d " " -f4 | cut -c -2
}

# Ban clients with IP address from $Shortcode
for NODE in ${NODES_TO_BAN[@]}; do
        IP=$NODE
        temp_var=$(func ${IP%:*})
        if [[ "$temp_var" == "$Shortcode" ]]; then
                COUNTER=$((COUNTER + 1))
                $($CLIENT setban ${IP%:*} "add" ${BAN_TIME})
                echo Banned client with IP: $IP >> $BANNED_FILE
        fi
done

#Show result
cat $BANNED_FILE
echo Found and banned $COUNTER nodes.

#Clean up
rm $NODES_FILE
rm $BANNED_FILE

exit 1
