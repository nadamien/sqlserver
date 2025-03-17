SQL Server Backup Scripts
=========================
- Backup_DB_Genric.ps1 (Container based full backup)
- local_backup.ps1 (Local full backup)


1) Backup_DB_Genric.ps1 is a Script Which can be used to backup SQL server databases on Docker containers.

Script will take 3 input parameetrs.

i.e. Backup_DB_Genric.ps1 "container name" "database name" "SA password"

2) Generic backup, no inpur parms, you can schedule this in Windows Task Scheduler to automate the backups.

Run the local_backup.ps1 on powershell, this will invoke a full backup of the database specified.

Bellow constant varibles should be changed, accrodingly.

$ServerName = "host\instance"  # Replace with your SQL Server instance name
$DatabaseName = "DB_Name"  # Replace with your database name
$BackupPath = "C:\backups\"  # Ensure this directory exists


i.e. local_backup.ps1

3) Housekeeping job to compress old backups

local_backup_housekeep.ps1

To automate the process we can use Windows Task Scheduler, bellow are the steps if needed.

- Open Task Scheduler
- Create a basic task and give a name
- Select the trigger (Daily, Weekly..etc)
  
![image](https://github.com/user-attachments/assets/03d8b157-f82c-4843-9b11-9407009d0ec1)

![image](https://github.com/user-attachments/assets/c59b6dc6-d469-4f12-92f6-f3fa5bde9ece)

 
- Add the action as Start a Program
  
![image](https://github.com/user-attachments/assets/91c549f1-faf2-468e-a400-103bfbcf6243)


- For the program give powershell.exe
- Pass the arguments as script location "-file "C:\pw-ops\local_bkp.ps1" "
  
![image](https://github.com/user-attachments/assets/52e22676-3342-4b62-bfd9-3791533b620f)

Finish and the new task should be avaiable on schduler window

*** Run the task and test before hand.

  



