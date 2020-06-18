# Active Directory

install-windowsfeature AD-Domain-Services

# Criar Dominio
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "thiago.local" -DomainNetbiosName "THIAGO" -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true

# Adicionando um computador ao dominio
Add-Computer -DomainName "thiago-local"
Add-Computer -ComputerName "Server01" -LocalCredential Server01\Admin01 -Restart -Force # With Credentials

# Criando uma OU
New-ADOrganizationalUnit -Name "Senai" -Path "DC=THIAGO" -ProtectedFromAccidentalDeletion $False

# Cria um usuario AD
New-ADUser -Name "Thiago" -AccountPassword "password_with_policy" -Enabled $true -PasswordNeverExpires $true -PasswordNotRequired $true -Path "DC=THIAGO/Users" -CannotChangePassword $true -ChangePasswordAtLogon $true -ScriptPath "DC=THIAGO/Scripts" -UserPrincipalName "thiago.rocha@thiago.local"

# Cria um Grupo de Usuarios AD 
New-ADGroup -Name "Admins" -SamAccountName "Admins" -GroupCategory "Security" -GroupScope "Global" -DisplayName "Administrators" -Path "DC=THIAGO/Groups" -Description "Members of this group are Administrators"

