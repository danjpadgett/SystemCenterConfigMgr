#Source - http://apppackagetips.blogspot.de/2015/11/windows-10-task-sequence-bitlocker-steps.html
#Script will apply HP Bios RPSET files to each model when found, see above link for more info and screenshots
#Author: Dan Padgett

#CopyFiles
New-Item -Path X:\windows\temp\bios -Force -ItemType Directory
Xcopy.exe *.* X:\windows\temp\bios /S /E /I /Y /D /C
Set-Location -Path X:\windows\temp\bios
#Set BIOS Password
$query = "Select * from Win32_ComputerSystem"
$model = Get-WmiObject -Query $query
if ($model.model -eq "HP Probook 450 G3") 
{
$fullcommand = "X:\windows\temp\bios\biosconfigutility64.exe"
$switches = "/NewSetupPasswordFile:password.bin /setconfig:TPMEnable-450G3.REPSET"
$proc = [Diagnostics.Process]::Start($fullcommand, $switches)
$proc.WaitForExit()
Write-Host "HP Probook 400 G3 Bios Applied"
}
if ($model.model -eq "HP Probook 470 G3") 
{
$fullcommand = "X:\windows\temp\bios\biosconfigutility64.exe"
$switches = "/NewSetupPasswordFile:password.bin /setconfig:TPMEnable-470G3.REPSET"
$proc = [Diagnostics.Process]::Start($fullcommand, $switches)
$proc.WaitForExit()
Write-Host "HP Probook 470 G3 Bios Applied"
}
if ($model.model -eq "HP Probook 450 G2") 
{
$fullcommand = "X:\windows\temp\bios\biosconfigutility64.exe"
$switches = "/NewSetupPasswordFile:password.bin /setconfig:TPMEnable.REPSET"
$proc = [Diagnostics.Process]::Start($fullcommand, $switches)
$proc.WaitForExit()
Write-Host "HP Probook 450 G2 Bios Applied"
}
if ($model.model -eq "HP EliteBook 850 G2") 
{
$fullcommand = "X:\windows\temp\bios\biosconfigutility64.exe"
$switches = "/NewSetupPasswordFile:password.bin /setconfig:TPMEnable-850G2.REPSET"
$proc = [Diagnostics.Process]::Start($fullcommand, $switches)
$proc.WaitForExit()
Write-Host "HP Probook 450 G2 Bios Applied"
}
$fullcommand = "X:\windows\temp\bios\biosconfigutility64.exe"
$switches = "/cspwdFile:password.bin /NewSetupPasswordFile:RemovePassword.bin"
$proc = [Diagnostics.Process]::Start($fullcommand, $switches)
$proc.WaitForExit()
Set-Location X:\windows\temp
Remove-Item -Path X:\windows\temp\bios -Force -Recurse
