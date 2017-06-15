<#
.SYNOPSIS
  Enables TPM while setting BIOS options for HP Laptop Models
.DESCRIPTION
  Script is intended to be used for HP Laptops during SCCM OSD to enable TPM;
  Full explination of the script and its use can be found here: http://apppackagetips.blogspot.com.au/2015/11/windows-10-task-sequence-bitlocker-steps.html;
  Script will set a temp password for BIOS, configure the BIOS, then remove the temp password;
  REPSET files may need to be created for each model as BIOS options change between ranges;
  Link to BIOS Config Guide: http://whp-aus1.cold.extweb.hp.com/pub/caps-softpaq/cmit/whitepapers/BIOS_Configuration_Utility_User_Guide.pdf.

.NOTES
  Version:        1.0
  Author:         dpadgett
  Creation Date:  07/02/17
  Purpose/Change: General Release
  
.EXAMPLE
  %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy Bypass -file .\TPMEnable.ps1
#>


#region CopyFiles

New-Item -Path X:\windows\temp\bios -Force -ItemType Directory
Xcopy.exe *.* X:\windows\temp\bios /S /E /I /Y /D /C
Set-Location -Path X:\windows\temp\bios

#endregion




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
