#!/bin/bash

# Deploy NTP service


# Check if NTP already installed /////////////////////////////////////////////
Installed=`dpkg -l | grep ntp`
if [ -z "$Installed" ]
	then
		apt install ntp -y
#	else
#		echo "NTP Already installed"
fi

# Rewrite NTP server's DNS name if /etc/ntp.conf exists ////////////////////////
# and make backup /etc/ntp.conf
#sed -i.backup '/pool/d' /etc/ntp.conf
if [ -f /etc/ntp.conf ]
	then
		sed -i.backup '/pool /d; /more information/a pool ua.pool.ntp.org iburst' /etc/ntp.conf

		systemctl restart ntp
fi

# Check and install ntp_verify.sh at crontab ///////////////////////////////////
WD=`pwd`
CTP='/var/spool/cron/crontabs/root'
PATH="PATH=$WD:$PATH"
CRONJOB="* * * * * /bin/bash $WD/ntp_verify.sh"
#echo "${PATH}";"${WD}/ntp_verify.sh" | crontab -
#(echo -e "${PATH}${CRONJOB}") | crontab -
#echo "$CRONJOB" | crontab -
#$CRONS=`crontab -l`
echo "$PATH" > "$CTP"
#echo $CRONS >> "$CTP" 
echo "$CRONJOB" >> "$CTP"
