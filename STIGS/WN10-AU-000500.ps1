<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : LaDarius McCord
    LinkedIn        : linkedin.com/in/mccord05/
    GitHub          : github.com/LaDariusM
    Date Created    : 2024-04-26
    Last Modified   : 2024-04-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE
# Define the registry path and key
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$MinValue = 32768

# Check if the path exists
if (-not (Test-Path $RegPath)) {
    # Create the path if it doesn't exist
    New-Item -Path $RegPath -Force | Out-Null
}

# Check if the value exists and is compliant
if (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue) {
    $CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName).$ValueName
    if ($CurrentValue -lt $MinValue) {
        # Update the value if it's too low
        Set-ItemProperty -Path $RegPath -Name $ValueName -Value $MinValue
        Write-Output "Updated '$ValueName' to $MinValue at $RegPath."
    } else {
        Write-Output "'$ValueName' is already set correctly (Current value: $CurrentValue)."
    }
} else {
    # Set the value if it doesn't exist
    New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWORD -Value $MinValue -Force | Out-Null
    Write-Output "Created '$ValueName' with value $MinValue at $RegPath."
}
