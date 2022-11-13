#!/bin/bash

DOMAIN="anasr"
SSL_DIR="/etc/nginx/ssl"
KEY_FILE="$SSL_DIR/$DOMAIN.key"
CSR_FILE="$SSL_DIR/$DOMAIN.csr"
CRT_FILE="$SSL_DIR/$DOMAIN.crt"
CONF_FILE="/etc/nginx/csrDetails.conf"

#Create an SSL Directory 
mkdir -p $SSL_DIR
chmod 700 $SSL_DIR

#Generate the key pair
openssl genrsa -out $KEY_FILE 2048 2>/dev/null
if [[ $? != 0 ]]; then
	echo "Error: generating the key"
	exit
fi

#Generate the Certificate Signing Request (CSR)
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
