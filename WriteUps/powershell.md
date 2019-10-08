# PowerShell for US Government O365 Environments
Below are samples to connect to US Government O365 environments (GCC, GCC High and GCC DoD) using various PowerShell modules.

## Power BI Admin Module

https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps

If you have not already done so, install the Power BI Admin module for PowerShell.  Note that you need to run this as an administrator.

```
Install-Module -Name MicrosoftPowerBIMgmt
```

If you have already installed it, make sure to update to the latest version

```
Update-Module -Name MicrosoftPowerBIMgmt
```

To connect to a Power BI environment in a US Government O365 Environment,

```
# Login for GCC Moderate
Login-PowerBI -Environment USGov

# Login for GCC High
Login-PowerBI -Environment USGovHigh

# Login for GCC DoD
Login-PowerBI -Environment USGovMil
```

## Exchange Online

https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps

```
# Set the user credentials
$userCredential = Get-Credential

# Setup the session (GCC Moderate)
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Setup the session (GCC High)
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.us/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Setup the session (GCC DoD)
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://webmail.apps.mil/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Import the session
Import-PSSession $Session -DisableNameChecking

```

## Exhange Online with Multi-Factor Authentication (MFA)

https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps

```
# Set the UserPrincipalName
$upn = <john@contoso.com> # set this to your actual UPN

# GCC
Connect-EXOPSSession -UserPrincipalName $upn

# GCC High
Connect-EXOPSSession -UserPrincipalName $upn -ConnectionUri https://outlook.office365.us/powershell-liveid -AzureADAuthorizationEndPointUri https://login.microsoftonline.us/common

# GCC DoD
Connect-EXOPSSession -UserPrincipalName $upn -ConnectionUri https://webmail.apps.mil/powershell-liveid -AzureADAuthorizationEndPointUri https://login.microsoftonline.us/common

```