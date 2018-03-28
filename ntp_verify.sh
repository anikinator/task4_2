#!/bin/bash

# Verify NTP service and configuration

# Check service status and run if not active /////////////////////////

NTPState=`systemctl is-active ntp` 

if [ -n "$NTPState" -a "$NTPState" != "active" ]
	then
		systemctl start ntp
fi
