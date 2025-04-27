<#
.SYNOPSIS
This script ensures that Windows forces the use of advanced audit policy subcategories by setting the SCENoApplyLegacyAuditPolicy registry value to 1,
making it compliant with STIG WN10-SO-000030.
.NOTES
    Author          : LaDarius McCord
    LinkedIn        : linkedin.com/in/mccord05/
    GitHub          : github.com/LaDariusM
    Date Created    : 2024-04-26
    Last Modified   : 2024-04-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000030).ps1 
#># Define the registry path and key
$RegPath = "HKLM:\System\CurrentControlSet\Control\Lsa"
$ValueName = "SCENoApplyLegacyAuditPolicy"

# Correct setting value
# 1 = Enabled (Force subcategory audit policies)
$CorrectValue = 1

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    Write-Output "Registry path not found: $RegPath"
    exit
}

# Get the current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Check compliance
if ($currentValue -eq $CorrectValue) {
    Write-Output "Audit policy subcategory enforcement is already enabled (Compliant)."
} else {
    Write-Output "Audit policy subcategory enforcement is NOT enabled (Non-compliant). Updating..."
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $CorrectValue
    Write-Output "Audit policy subcategory enforcement has been enabled (Now compliant)."
}

# Optional: Force a policy update
# gpupdate /force
