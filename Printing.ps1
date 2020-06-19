# Instala Print and Document Services
Install-WindowsFeature Print-Services

# Instalando Impressora
Add-Printer -Name "Lexmark CS310 - Financeiro" -DriverName "Lexmark CS310 Series Class Driver" -PortName "LPT1:"

# Lista Impressoras 
Get-Printer 

# Retorna Informações de uma impressora específica
Get-Printer -Name "Lexmark CS310 - Financeiro"
Get-Printer -Name "Lexmark CS310 - Financeiro" | Format-List    # Mais detalhadamente

