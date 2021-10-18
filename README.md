# ShellScripts

This repository will contain my work towards automation using shell script to avoid manual work.

Example: The backupfile check script which runs weekly will check for Backup file name using pattern and send mail with name of file and size of the file so that Administrators can easily verify from mail if backup is successful without the need to login to FTP server. Backup file is utmost important for Cisco ISE without which it is impossible to get back the previous configuration (which require heavy manual work).
{ Runs weekly on Monday at 00:00 using cron job:: 0 0 * * MON /path/script.sh > /dev/null 2>&1 }
