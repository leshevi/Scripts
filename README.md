Script top_ip_docker_nginx.sh. We register in crontab -e 

0 9 * * 1 /home/leshevi/nginx/top_ip_docker_nginx.sh

Script cpu_monitor.sh. You can monitor the CPU load.

Script test_db_connection.php check connection to database mysql

Script banssh.sh blocks IP addresses trying to get to the server with an error

Script ping.sh scans the network for available hosts

du -h --max-depth=1 | sort -hr | head -n 10

Script find_deleted.sh we are looking for processes that hold open deleted files.

Script DisableForwarding.ps1
 Run PowerShell as administrator and run this block of code. This will create a task that will run whenever any user logs in with maximum privileges:
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Scripts\DisableForwarding.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName "DisableEthernetForwarding" -Action $action -Trigger $trigger -Principal $principal
