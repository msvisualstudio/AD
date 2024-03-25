#To export the list of inactive users use this command

$When = ((Get-Date).AddDays(-90)).Date
Get-ADUser -Filter {LastLogonDate -lt $When} -Properties * | select-object samaccountname,givenname,surname,LastLogonDate | export-csv -path c:\temp\inactiveusers.csv
