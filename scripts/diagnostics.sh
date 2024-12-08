# Shebang - Indicates which interpreter to use to run script (bash)
#! /usr/bin/bash

# Sets a variable to store the path of the log file where results will be written
LOG_FILE=~/linux_project/logs/diagnostics.log
# Sets a variable to store the path of the input file that contains the list of device IP addresses
DEVICES_FILE=~/linux_project/configs/devices.txt # Sets DEVICES_FILE to file with list of devices
# An array of services to check 
SERVICES=("sshd" "httpd")

echo "Running Diagnostics - $(date)"
# Base script to automate 
# -----------------------------------------
# echo : Ouputs text to a file or terminal 
# $(date) : Runs the date command to get the current date and time
# > : Redirects the output to the file specified by $LOG_FILE. If the file exists, it overwrites.
echo "Running Diagnostics - $(date)" > $LOG_FILE

# Test Device Connectivity 
# >> : Appends the text to the end of the $LOG_FILE instead of overwriting it
echo "Checking device connectivity:" >> $LOG_FILE
# Starts loop that runs as long as there are lines to read
# IFS= : Temporarily disables the default input field separators so lines with spaces aren't split incorrectly
# read -r device : Reads each line from the input file into the variable "device"
while IFS= read -r device; do
	# ping : sends a small packet to the target device and waits for reply to check if its reachable
	# -c 3 : Sends exactly 3 packets and then stops
	# &> /dev/null : Redirects both standard output (normal messages) and standard error (error messages) 
	# 		 to /dev/null, which discards them. 
	ping -c 3 $device &> /dev/null
	# $? : Stores the exit code of the last command (ping in this case). A value of zero means success, while anything 
	#      else indicates failure
	# -eq 0 : Compares the exit code to 0 (-eq = equal)	
	if [ $? -eq 0 ]; then 
		echo "$device is reachable" >> $LOG_FILE
	else 
		echo "ERROR: $device is unreachable" >> $LOG_FILE
	fi 
	
	# df -h : Displays the disk space usage in a human-readable format(-h) 
	echo "Disk Usage:" >> $LOG_FILE
	df -h >> $LOG_FILE
	# free -m : Shows memory usage in megabytes(-m)  
	echo "MEMORY USAGE:" >> $LOG_FILE
	free -m >> $LOG_FILE
	
	# Iterate through each service in the array 
	for service in "${SERVICES[@]}"; do
		# Checks if the service is runnning 
		# --quiet : supresses the output to the terminal; exit code used instead
		systemctl is-active --quiet $service
		if [ $? -eq 0 ]; then 
			echo "$service is running" >> $LOG_FILE
		else
			echo "ERROR: $service is not running" >> $LOG_FILE
		fi
	done

# done : Marks the end of the loop 
# < $DEVICES_FILE : Feeds the content of the input file into the loop
done < $DEVICES_FILE

echo "Diagnostics complete. Results saved to $LOG_FILE"
