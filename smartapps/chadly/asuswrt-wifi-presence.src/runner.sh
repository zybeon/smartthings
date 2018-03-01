#https://github.com/jaytarang92/STwifiPresence
#!/bin/ash
# gettings the mac, appID, token from environment variables
# should create a service to keep running all the time
# ** dont forget to chmod this file
while true; do
python STwifi.py $MYMAC $STAPPID $SMARTTOKEN
done
