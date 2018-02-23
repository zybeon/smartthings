#!/bin/sh

Rodney=Away
Virginia=Away
Sarah=Away

macaddress="`wl -i eth1 assoclist` `wl -i eth2 assoclist` `wl -i eth3 assoclist`"

case "$macaddress" in
	*XX:XX:XX:XX:XX:XX*)
	Rodney=Home
	;;
esac

case "$macaddress" in
	*XX:XX:XX:XX:XX:XX*)
	Virginia=Home
	;;
esac

case "$macaddress" in
	*XX:XX:XX:XX:XX:XX*)
	Sarah=Home
	;;
esac

if [ "$Rodney" = Home ]
then
	if [ ! -f /jffs/scripts/users/chad ]
	then
		touch /jffs/scripts/users/rodney
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/home"
	fi
else
	if [ -f /jffs/scripts/users/chad ]
	then
		rm -f /jffs/scripts/users/rodney
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/away"
	fi
fi

if [ "$Virignia" = Home ]
then
	if [ ! -f /jffs/scripts/users/alanna ]
	then
		touch /jffs/scripts/users/virginia
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/home"
	fi
else
	if [ -f /jffs/scripts/users/alanna ]
	then
		rm -f /jffs/scripts/users/virginia
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/away"
	fi
fi

if [ "$Sarah" = Home ]
then
	if [ ! -f /jffs/scripts/users/alanna ]
	then
		touch /jffs/scripts/users/sarah
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/home"
	fi
else
	if [ -f /jffs/scripts/users/alanna ]
	then
		rm -f /jffs/scripts/users/sarah
		curl -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST "https://<BASE_URL>/api/smartapps/installations/<APP_ID>/away"
	fi
fi
