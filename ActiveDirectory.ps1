# Active Directory
Add-WindowsFeature AD-Domain-Services

# Criar Dominio
Import-Module ADDSDeployment
Install-ADDSForest -DomainName thiago.local -InstallDNS

# Criando uma OU
Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name "Senai" -Path "DC=thiago,DC=local" -ProtectedFromAccidentalDeletion $False

# Cria um usuario AD
$Senha = ConvertTo-SecureString "password_with_policy" -AsPlainText -Force
New-ADUser -Name "Thiago" -SamAccountName "thiago.nascimento" -AccountPassword $Senha -Enabled $true -Path "OU=Senai,DC=thiago,DC=local" -ChangePasswordAtLogon $true 

# Cria um Grupo de Usuarios AD 
New-ADGroup -Name "Admins" -SamAccountName "Admins" -GroupCategory "Security" -GroupScope "Global" -DisplayName "Administrators" -Path "OU=Senai,DC=thiago,DC=local" -Description "Members of this group are Administrators"

# Adiciona usuario à grupo
Add-ADGroupMember -Identity Admins -Members thiago.nascimento

# Deleta OU protegida contra exclusão acidental
Get-ADOrganizationalUnit -Identity 'OU=Senai,DC=thiago,DC=local' | Set-ADObject -ProtectedFromAccidentalDeletion $False
Remove-ADOrganizationalUnit -Identity 'OU=Senai,DC=thiago,DC=local'