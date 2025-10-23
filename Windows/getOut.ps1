Get-LocalUser | Select-Object Name | Out-File .\EnabledUsers.txt

$uniqueFile1 = (Get-Content ".\allowedUsers.txt")
(Get-Content ".\EnabledUsers.txt") | Where-Object { $uniqueFile1 -notcontains $_ } | Out-File ".\EnabledUsers.txt"







