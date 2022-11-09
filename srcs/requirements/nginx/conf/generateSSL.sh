#!/bin/bash

DOMAIN="anasr"
KEY_FILE="$DOMAIN.key"
CSR_FILE="$DOMAIN.csr"
CRT_FILE="$DOMAIN.crt"
CONF_FILE="csrDetails.conf"


#Generate the key pair
openssl genrsa -out $KEY_FILE 2048 2>/dev/null
if [[ $? != 0 ]]; then
	echo "Error: generating the key"
	exit
fi

# #Generate the Certificate Signing Request (CSR)
openssl req -new -key $KEY_FILE -out $CSR_FILE -config $CONF_FILE 2>/dev/null
if [[ $? != 0 ]]; then
	echo "Error: generating the key"
	exit
fi

# #Generate Self-Signed Certificate
openssl x509 -req -in $CSR_FILE -signkey $KEY_FILE -out $CRT_FILE -days 365 2>/dev/null
if [[ $? != 0 ]]; then
	echo "Error: generating the key"
	exit
fi
