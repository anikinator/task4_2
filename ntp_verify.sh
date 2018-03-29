#!/bin/bash

# Verify NTP service and configuration

# Check service status and run if not active /////////////////////////

NTPState=`systemctl is-active ntp` 

if [ -n "$NTPState" -a "$NTPState" != "active" ]
	then
		systemctl start ntp
fi

# Get changes and restore ntp.conf
if [ -f /etc/ntp.conf.backup ]
 then
	GETDIFF=`diff /etc/ntp.conf /etc/ntp.conf.backup`
	if [ -n "$GETDIFF" ]
	 then
		echo $GETDIFF
		cp /etc/ntp.conf.backup /etc/ntp.conf
	fi
fi
