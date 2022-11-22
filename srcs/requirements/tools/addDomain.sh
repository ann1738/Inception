#!/bin/bash
DOMAIN="anasr.42.fr"

#Add domain to /etc/hosts if it doesn't exist
cat /etc/hosts | grep "127.0.0.1" &> /dev/null && cat /etc/hosts | grep $DOMAIN &> /dev/null
if [[ $? -ne 0 ]]; then
	echo -e "127.0.0.1\t$DOMAIN" >> /etc/hosts
	echo "Added domain '$DOMAIN'"
fi