# Criar Item: Directory or File
New-Item -Path 'C:\temp\New Folder' -ItemType Directory

# Copiar Item: -Force Se o arquivo de destino já existir, sobrescreve
Copy-Item -Path C:\boot.ini -Destination C:\boot.bak -Force

# Comaprtilhar "New Folder" como "SharedFolder"
New-SMBShare –Name "SharedFolder" –Path "C:\temp\New Folder" –FullAccess "Administrators", "Server Operators" 

# Instalar FSRM (Quota)
Install-WindowsFeature –Name FS-Resource-Manager –IncludeManagementTools

# Cria template de cota
New-FsrmQuotaTemplate -Name "Limite 1GB" -Description "limit usage to 1 GB." -Size 1GB  # Hard 
New-FsrmQuotaTemplate -Name "Limite 500MB" -Description "limit usage to 500MB." -Size 500MB -SoftLimit # Soft, Threshold => Monitoramento

# Cria cota de acordo com um template
New-FsrmQuota -Path "C:\Shares" -Description "limit usage to 100 MB based on template." -Template "100 MB Limit"

# Cria nova triagem de arquivo a partir de um template
New-FsrmFileScreen -Path "C:\shares\ctrshare03" -Template "Block Image Files"

# Cria novo modelo de triagem
New-FsrmFileScreenTemplate "Bloqueio ZIP e EXE" -IncludeGroup "*.zip", "*.exe"