tell application "Terminal"
	
	set question to display dialog "PTY Devices will usually only allow one active connection. If there are detached screen sessions that are still using the target PTY, it will fail and display a BUSY or COULD NOT FIND PTY error. Would you like to attempt to detect and kill any previously running detached screen sessions?" buttons {"No", "Yes"} default button 2
	
	set answer to button returned of question
	
	if answer is equal to "Yes" then
		do shell script "screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill "
	end if
	
	display dialog "Please choose an interface:"
	
	
	set serialDevices to (do shell script "ls /dev/tty.usb*")
	
	set deviceList to (paragraphs of serialDevices) as list
	
	set theDevice to (choose from list deviceList)
	
	
	
	do script "screen " & theDevice & " "
	
	
	display dialog "NOTE: You may need to press the ENTER key to see PTY terminal text. To quit your terminal session type <ctrl-a> then <ctrl-\\>"
	
end tell