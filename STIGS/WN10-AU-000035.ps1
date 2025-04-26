<#
.SYNOPSIS
    This PowerShell script checks if "Audit User Account Management" is configured to log failures (or successes and failures) and automatically corrects it if not, 
    ensuring compliance with security audit policies.
.NOTES
    Author          : LaDarius McCord
    LinkedIn        : linkedin.com/in/mccord05/
    GitHub          : github.com/LaDariusM
    Date Created    : 2024-04-26
    Last Modified   : 2024-04-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000035).ps1 
#>

# YOUR CODE GOES HERE
# Ensure the 'Audit User Account Management' policy is set to 'Failure' or 'Success and Failure'

# Function to check current setting
function Get-AuditPolicySetting {
    param (
        [string]$Subcategory
    )
    $auditSetting = (auditpol /get /subcategory:"$Subcategory" 2>$null | Select-String "$Subcategory")
    return $auditSetting.ToString()
}

# Function to set audit policy
function Set-AuditPolicySetting {
    param (
        [string]$Subcategory,
        [string]$Setting
    )
    if ($Setting -eq "Failure") {
        auditpol /set /subcategory:"$Subcategory" /failure:enable
    }
    elseif ($Setting -eq "Success,Failure") {
        auditpol /set /subcategory:"$Subcategory" /success:enable /failure:enable
    }
}

# Define the subcategory
$Subcategory = "User Account Management"

# Get the current setting
$currentSetting = Get-AuditPolicySetting -Subcategory $Subcategory

if ($currentSetting -match "Failure" -or $currentSetting -match "Success and Failure") {
    Write-Output "'$Subcategory' auditing is already configured correctly."
} else {
    Write-Output "'$Subcategory' auditing is not configured correctly. Updating now..."
    # Set to Success and Failure
    Set-AuditPolicySetting -Subcategory $Subcategory -Setting "Success,Failure"
    Write-Output "'$Subcategory' auditing has been configured to 'Success and Failure'."
}

