<#
.SYNOPSIS
This script ensures the Windows Telemetry setting is compliant by checking if it's set to Security (0), Basic (1), or Enhanced (2), and if not, 
it updates the setting to Basic (1) to meet STIG requirements.
.NOTES
    Author          : LaDarius McCord
    LinkedIn        : linkedin.com/in/mccord05/
    GitHub          : github.com/LaDariusM
    Date Created    : 2024-04-26
    Last Modified   : 2024-04-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000205).ps1 
#>

# YOUR CODE GOES HERE
# Define registry path and key
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$ValueName = "AllowTelemetry"
$CompliantValues = @(0, 1, 2) # Security, Basic, or Enhanced are acceptable

# Check if the path exists
if (-not (Test-Path $RegPath)) {
    # Create the path if it doesn't exist
    New-Item -Path $RegPath -Force | Out-Null
}
