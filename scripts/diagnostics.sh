# Shebang - Indicates which interpreter to use to run script (bash)
#! /usr/bin/bash

LOG_FILE=~/linux_project/logs/diagnostics.log
DEVICES_FILE=~/linux_project/configs/devices.txt # Sets DEVICES_FILE to file with list of devices
SERVICES=("sshd" "httpd")

# $(date): Command to display date and time
echo "Running Diagnostics - $(date)"
echo "Running Diagnostics - $(date)" > $LOG_FILE

# Test Device Connectivity
echo -e "\nChecking device connectivity:" >> $LOG_FILE

# IFS= : Temporarily disables the default input field separators so lines with spaces aren't split incorrectly
while IFS= read -r device; do
	# Ping the device
	ping -c 3 $device &> /dev/null

	# Check if ping command returns a 0 (success) or fail(>0)	
	if [ $? -eq 0 ]; then 
		echo "$device is reachable" >> $LOG_FILE
	else 
		echo "ERROR: $device is unreachable" >> $LOG_FILE
	fi 
# Marks the end of the loop and feeds the content of the input file into the loop
done < $DEVICES_FILE

# Run system memory check
echo -e "\nRunning System Memory Check - $(date)" >> $LOG_FILE

# Display the disk space usage in a human-readable format(-h)
echo "Disk Usage:" >> $LOG_FILE
df -h >> $LOG_FILE
# Shows memory usage in megabytes(-m)
echo "MEMORY USAGE:" >> $LOG_FILE
free -m >> $LOG_FILE

# Run service check 
echo -e "\nRunning Service Check - $(date)" >> $LOG_FILE

# Iterate through each service in the SERVICES array
for service in "${SERVICES[@]}"; do
	# Checks if the service is runnning
	systemctl is-active --quiet $service
	# Check if systemctl returns success or fail
	if [ $? -eq 0 ]; then 
		echo "$service is running" >> $LOG_FILE
	else
        	echo "ERROR: $service is not running" >> $LOG_FILE
	fi
done


echo "Diagnostics complete. Results saved to $LOG_FILE"
