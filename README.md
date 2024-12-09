Project Title: Linux Diagnostics Script

Purpose: I created this project to start learning Linux, as I have little to no prior experience with it. I am using the RHEL operating system on a virtual machine set up with Oracle VirtualBox.  

Features: 
1. Monitors the connectivity and status of network devices
2. Monitors the services on a system

Commands:
echo: Outputs a text to a file or terminal
	> $FILE_NAME : Redirects the output to the file specified. If the file exists, it overwrites
	>> $FILE_NAME: Appends the text to the end of the file specified instead of overwriting it

ping: Sends a small packet to the target device and waits for reply to check if its reachable
	-c #: Sends exactly # of packets and then stops
	&> /dev/null: Redirects standard output and standard error messsages to /dev/null, which discards them

df: Displays the disk space usage
	-h: Displays the disk space usage in human readable format

free: Shows memory usage
	-m: Shows memory usage in megabytes

systemctl: Check status of any systemd service running
	is-active: Checks if a particular service is currently running (returns active or inactive status)
	--quiet: Supresses the output to the terminal 

How To Run:
1. Use ./diagnostics.sh to run script
2. View diagnostics.log

What I learned:
1. I learned how to use Oracle VirtualBox to create my own virtual machine and how to utilize the RHEL (Red Hat Enterprise Linux) OS
2. I learned the basics of the terminal using commands like cd, ls, touch... and more
3. I learned the basics of scripting using commands like echo, ping, curl... and more
4. I learned how to utilize an SSH key and connect it to my Git account to push my changes 
5. I learned how to use VIM to edit files in the terminal
6. I learned when a Linux OS would be used in an embedded system and how to utilize it.
