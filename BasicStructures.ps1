# Variables
$frase = "Hello World"
Write-Output $frase

$data = Get-Date
Write-Output "Hoje é dia: " $data

[int]$num1 = 2
[int]$num2 = 3
[int]$total = $num1 + $num2
Write-Output $total

# Using WScript class
$shell = New-Object -com WScript.shell
$shell.Run("notepad")
Start-Sleep 1
$shell.SendKeys("PowerShell testing")

# Conditional Structure
if (Get-ChildItem -File = C:\testing.txt) {
    Write-Output OK
} else {
    Write-Output "File is missing..."
}

# Repetition block
for ($i = 0; $i -le 5; $i++) {
    ping 172.10.100.$i
}

foreach ($number in 1,2,3,4,5,6) {
    Write-Output $number
}

foreach ($file in Get-ChildItem) {
    if ($file.IsReadOnly) {
        Write-Host $file.FullName
    }
}

Get-Process Notepad | foreach kill
# Get-Process Notepad | ForEach-Object kill

# Function
function MyProcess {
    $processes = Get-Process
    $processes.Name
}

MyProcess

# Parallel Workflow
workflow Editores {
    Parallel {
        Start-Process -FilePath Notepad
        Start-Process -FilePath Wordpad
    }
}

Editores

# Job
Start-Job {
    while ($true) {
        Get-Random; Start-Sleep 5
    }
} -Name Sleepy

Stop-Job Sleepy
Get-Job
Remove-Job Sleepy

# Progress
for ($i = 0; $i -le 100; $i++) {
    Write-Progress -Activity "Counting to 100" -Status "Finish" -PercentComplete (($i / 100) * 100)
    sleep 1
}

# Schedule
$schedule = New-JobTrigger -Daily -At 4pm
Register-ScheduledJob -Name Test_Scheduled_Job -ScriptBlock {Get-Process} -Trigger $schedule