#!/bin/sh
cru a CheckIfHome "* * * * * /opt/scripts/check-home"
cru a CheckIfHome15 "* * * * * sleep 15; /opt/scripts/check-home"
cru a CheckIfHome30 "* * * * * sleep 30; /opt/scripts/check-home"
cru a CheckIfHome45 "* * * * * sleep 45; /opt/scripts/check-home"
