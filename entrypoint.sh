#!/usr/bin/env bash
APP_DIR="/app"

if [[ -z "$WEBSITE" ]]; then
  echo "[-] Make sure you have specified WEBSITE environment variable."
  exit 1
fi

echo "[+] Running clone for $WEBSITE"

OUTPUT_FILE=$(echo $WEBSITE | sed "s~http[s]*://~~g")

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
