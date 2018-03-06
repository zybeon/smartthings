#!/bin/sh
$APP_ID1
$ACCESS_TOKEN1
$APP_ID1
$ACCESS_TOKEN2
$APP_ID1
$ACCESS_TOKEN3

$BASE_URL

Rodney=Away
Virginia=Away
Sarah=Away

macaddress="`wl -i eth1 assoclist` `wl -i eth2 assoclist` `wl -i eth3 assoclist`"

case "$macaddress" in
	*90:E7:C4:DB:03:61*)
	Rodney=Home
	;;
esac

case "$macaddress" in
	*AC:5F:3E:7E:D1:57*)
	Virginia=Home
	;;
esac

case "$macaddress" in
	*7C:7A:91:B7:3E:19*)
	Sarah=Home
	;;
esac

if [ "$Rodney" = Home ]
then
	if [ ! -f /opt/scripts/users/rodney ]
	then
		touch /opt/scripts/users/rodney
		curl -H "Authorization: Bearer $ACCESS_TOKEN1" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID1/home"
	fi
else
	if [ -f /opt/scripts/users/rodney ]
	then
		rm -f /opt/scripts/users/rodney
		curl -H "Authorization: Bearer $ACCESS_TOKEN1" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID1/away"
	fi
fi

if [ "$Virignia" = Home ]
then
	if [ ! -f /opt/scripts/users/virginia ]
	then
		touch /opt/scripts/users/virginia
		curl -H "Authorization: Bearer $ACCESS_TOKEN2" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID2/home"
	fi
else
	if [ -f /opt/scripts/users/virginia ]
	then
		rm -f /opt/scripts/users/virginia
		curl -H "Authorization: Bearer $ACCESS_TOKEN2" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID2/away"
	fi
fi

if [ "$Sarah" = Home ]
then
	if [ ! -f /opt/scripts/users/sarah ]
	then
		touch /opt/scripts/users/sarah
		curl -H "Authorization: Bearer $ACCESS_TOKEN3" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID3/home"
	fi
else
	if [ -f /opt/scripts/users/sarah ]
	then
		rm -f /opt/scripts/users/sarah
		curl -H "Authorization: Bearer $ACCESS_TOKEN3" -X POST "https://$BASE_URL/api/smartapps/installations/$APP_ID3/away"
	fi
fi
