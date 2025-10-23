Get-LocalUser | Select-Object Name | Out-File .\EnabledUsers.txt

$file = Get-Content .\EnabledUsers.txt
echo($file)




