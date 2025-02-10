#!/bin/bash

#Keep backup file counter to zero initially
backupfilecount=0
#Below command to find files modified in last 7 days
filesvar=`find /ftp/backups -mtime -6 -printf '%T+\t%s\t%p\n' 2>/dev/null`
echo $filesvar
#
##===========================================================
## Matching the filename with below string from list of files
##===========================================================
for word in $filesvar;do
    echo "$word"
	if echo $word | grep -q "ISE_Backup" | sort -r ; then
	echo "String Matched"
	((backupfilecount++))
	filesize=`du -h $word`
	filetime=`ls -l --time-style="+%Y%m%d" $word | cut -d' ' -f6`
	break
	else
	echo "String NOT Matched"
	fi
done
#Recipient="abcd@gmail.com"
TodayDate=$(date +"%m-%d-%Y")
str1="Backup-status-ISE-Cluster-this-week-Executed-on"
str2="$str1-$TodayDate"
#echo $str2
Subject=`echo $str2`
#echo $Subject

MessageSuccess=`echo -e "Stage Backup completed successfully. Filesize and filename is:: " $filesize`
MessageSuccess+=`echo -e ". File backup date in YYYYMMDD format" $filetime`

MessageFail="Stage Backup Failed - Please check and take necessary action"
# Sending mail with status
if [ $backupfilecount -gt 0 ]; then
	echo "Backup Success"
	#There is a bug in mail command - please do not use space in Subject
	#Example instead of using "Backup status ISE Cluster Date" use "Backup-status-ISE-Cluster-Date"
	`mail -s $Subject xyz@company.com <<< $MessageSuccess`
else
	echo "Backup Failed"
	#There is a bug in mail command - please do not use space in Subject
	#Example instead of using "Backup status ISE Cluster Date" use "Backup-status-ISE-Cluster-Date"
	`mail -s $Subject xyz@company.com <<< $MessageFail`
fi

#CRON JOB used
0 0 * * MON /path/Backup-status-send-mail.sh > /dev/null 2>&1
{Runs every Week Monday at 00:00}
##END
