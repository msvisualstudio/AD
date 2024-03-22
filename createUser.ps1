#-------------------Import modules--------------------------#

Import-Module ActiveDirectory

#-------------------Define variables--------------------------#

#first name
$firstName = Read-Host "Wprowadź imię użytkownika"
#Capitalize the first letter of first name
$capitalizeFirstName = $firstName.Substring(0,1).ToUpper() + $firstName.Substring(1)

#last name
$lastName = Read-Host "Wprowadź nazwisko użytkownika"

#Capitalize the first letter of last name
$capitalizeLastName = $lastName.Substring(0,1).ToUpper() + $lastName.Substring(1)

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

# Create the user in the Organizational Unit

New-ADUser -Name "$capitalizeFirstName $capitalizeLastName" `
	-GivenName $capitalizeFirstName -Surname $capitalizeLastName `
    -SamAccountName $username `
    -UserPrincipalName "$username@torpoloilgas.pl" `
	-AccountPassword $password `
	-Path "LDAP://$childOu" `
	-Enabled $true `
	-EmailAddress $email `
	-DisplayName "$capitalizeFirstName $capitalizeLastName" `
	-Company "Torpol Oil & Gas Sp. z o.o." `
    -Title $jobtitle `

# Add the user to the security group 
# BY DEFAULT PRACOWNICY
Add-ADGroupMember -Identity $group -Members $username
