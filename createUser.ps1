#-------------------Import modules--------------------------#

Import-Module ActiveDirectory

#-------------------Define variables--------------------------#

#first name
$firstName = Read-Host "Wprowadź imię użytkownika"

#last name
$lastName = Read-Host "Wprowadź nazwisko użytkownika"

#username
$username = $firstName.Substring(0,1).ToLower() + $lastName.ToLower()

# password
$password = $firstName.Substring(0,1).ToUpper() + $lastName.Substring(0,1).ToUpper() + "61749pn."

#Security Group - Replace with the name of the security group - BY DEFAULT PRACOWNICY
$group = "PRACOWNICY" 

#organizational unit (To add a user to an Organizational Unit (OU) within another Organizational Unit (nested OU))
$parentOu = "OU=Pracownicy,DC=tog,DC=local"
$childOu = "OU=Centrala, $parentOu"

#e-mail
$email = $firstName.Substring(0,1).ToLower() +"."+ $lastName.Tolower() + "@torpoloilgas.pl"

# job title
$jobtitle = Read-Host "Wprowadz stanowisko"

#-------------------Program--------------------------#

# Create the user in the OU

New-ADUser -Name "$firstName $lastName" `
	-GivenName $firstName -Surname $lastName `
    -SamAccountName $username `
    -UserPrincipalName "$username@torpoloilgas.pl" `
	-AccountPassword $password `
	-Path "LDAP://$childOu" `
	-Enabled $true `
	-EmailAddress $email `
	-DisplayName "$firstName $lastName" `
	-Company "Torpol Oil & Gas Sp. z o.o." `
    -Title $jobtitle `

# Add the user to the security group 
# BY DEFAULT PRACOWNICY
Add-ADGroupMember -Identity $group -Members $username


