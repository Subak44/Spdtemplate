install-Module -Name "PnP.PowerShell" -Force 
Get-Command -Module PnP.PowerShell  
Register-PnPEntraIDAppForInteractiveLogin -ApplicationName "SPD Template" -Tenant <tenantname>.onmicrosoft.com -Interactive
Connect-PnPOnline -Url "https://<tenantname>-admin.sharepoint.com" -Interactive -ClientId <clientid>