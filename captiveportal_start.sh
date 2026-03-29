#!/bin/bash
echo "Run starthostapd.sh $(date)" >> hostapd_log
./starthostapd.sh >> hostapd_log 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -eq 2 ]; then
    echo "Already connected to Wi-Fi. Captive portal not started." >> hostapd_log
    exit 0
elif [ $EXIT_CODE -ne 0 ]; then
    echo "starthostapd.sh failed with exit code $EXIT_CODE. Captive portal not started." >> hostapd_log
    exit 1
fi

python3 captiveserver.py
