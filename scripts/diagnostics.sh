#! /usr/bin/bash
LOG_FILE=~/linux_project/logs/diagnostics.log
DEVICES_FILE=~/linux_project/configs/devices.txt
SERVICES=("sshd" "httpd")

echo "Running Diagnostics -($date)" > $LOG_FILE

# Test Device Connectivity 
echo "Checking device connectivity:" >> $LOG_FILE
while IFS= read -r device; do
	ping -c 3 $device &> /dev/null
	if [ $? -eq 0 ]; then 
		echo "$device is reachable" >> $LOG_FILE
	else 
		echo "ERROR: $device is unreachable" >> $LOG_FILE
	fi 

	echo "Disk Usage:" >> $LOG_FILE
	df -h >> $LOG_FILE
	echo "MEMORY USAGE:" >> $LOG_FILE
	free -m >> $LOG_FILE

	for service in "$SERVICES"; do
		systemctl is-active --quiet $service
		if [ $? -eq 0 ]; then 
			echo "$service is running" >> $LOG_FILE
		else
			echo "ERROR: $service is not running" >> $LOG_FILE
		fi
	done
done < $DEVICES_FILE

echo "Diagnostics complete. Results saved to $LOG_FILE"
