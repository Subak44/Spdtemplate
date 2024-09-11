$Sitename="<sitename>"
$Tenantname="<tenantname>"
$TenantUrl="https://$Tenantname-admin.sharepoint.com"
$SiteUrl="https://$Tenantname.sharepoint.com/sites/$Sitename"
$clientId="82df710e-f4f0-4da2-aaf8-fa35547387ea"
#Parameter
$AdminCenterURL = $TenantUrl
 
#Connect to Admin Center
 Connect-PnPOnline -Url $AdminCenterURL -Interactive -ClientId $clientId
#Create a modern communication site
New-PnPSite -Type CommunicationSite -Title $Sitename -Url $SiteUrl -SiteDesign Blank

#Define Theme
$themeName = "Corporate Theme"
$ThemePalette = @{
"themePrimary" = "#0d6efd";
"themeLighterAlt" = "#f5f9ff";
"themeLighter" = "#d8e7ff";
"themeLight" = "#b6d3fe";
"themeTertiary" = "#6da7fd";
"themeSecondary" = "#297efd";
"themeDarkAlt" = "#0b62e3";
"themeDark" = "#0a53c0";
"themeDarker" = "#073d8d";
"neutralLighterAlt" = "#eeeeee";
"neutralLighter" = "#eaeaea";
"neutralLight" = "#e1e1e1";
"neutralQuaternaryAlt" = "#d1d1d1";
"neutralQuaternary" = "#c8c8c8";
"neutralTertiaryAlt" = "#c0c0c0";
"neutralTertiary" = "#a19f9d";
"neutralSecondary" = "#605e5c";
"neutralSecondaryAlt" = "#8a8886";
"neutralPrimaryAlt" = "#3b3a39";
"neutralPrimary" = "#323130";
"neutralDark" = "#201f1e";
"black" = "#000000";
"white" = "#f5f5f5";
}
 Try {
    $nTheme = Get-PnPTenantTheme -Name $themeName
} catch {
    #powershell to add custom theme in sharepoint online
    Add-PnPTenantTheme -Identity $themeName -Palette $themepalette -IsInverted $false
    $nTheme = Get-PnPTenantTheme -Name $themeName
}

Set-PnPWebTheme -Theme $themeName -WebUrl $SiteUrl
Write-Host "Set $themeName theme successfull!" -ForegroundColor Green

$SiteURL = $SiteUrl
#Connect to SharePoint Online App Catalog site
Connect-PnPOnline -Url $SiteURL -Interactive -ClientId $clientId
#Enable site collection app catalog
Add-PnPSiteCollectionAppCatalog -Site $SiteUrl
Write-Host "SiteCollection AppCatalog created successfull!" -ForegroundColor Green

#FAQs List
$FaqListName = "FAQs" 
$FaqListURL="Lists/FAQs"
$Template ="GenericList"
New-PnPList -Title $FaqListName -Url $FaqListURL -Template $Template

#Get List
$FaqGetList = Get-PnPList -Identity $FaqListName
$FaqListId =  $FaqGetList.Id

#Add Columns(Field) from xml
$xml1='<Field AppendOnly="FALSE" ClientSideComponentId="00000000-0000-0000-0000-000000000000" DisplayName="Description" Format="Dropdown" IsolateStyles="FALSE" Name="Description" RichText="FALSE" RichTextMode="Compatible" Title="Description" Type="Note" ID="{4f19e3ab-f32b-4bb6-8eb4-637c1a9d2953}" StaticName="Description" ColName="ntext2" RowOrdinal="0" SourceID="{05624ECE-F826-43A3-8F6D-48AB11D47274}" />'
$xml2='<Field CommaSeparator="TRUE" CustomUnitOnRight="TRUE" DisplayName="Order" Format="Dropdown" IsModern="TRUE" Name="Orders" Percentage="FALSE" Title="Order" Type="Number" Unit="None" ID="{4d1835b9-7521-4121-a26d-13b9c46ede8a}" StaticName="Orders" CustomFormatter="" Required="FALSE" EnforceUniqueValues="FALSE" Indexed="FALSE" ColName="float1" RowOrdinal="0" SourceID="{5C4C6B3F-801C-4881-AD6F-28A3DD7F6D07}" />'

Add-PnPFieldFromXml -List $FaqListName -FieldXml $xml1
Add-PnPFieldFromXml -List $FaqListName -FieldXml $xml2


#Add fields in Default View
Set-PnPView -List $FaqListName -Identity "All Items" -Fields "Title","Description","Orders"

Write-Host "FAQs List All Fields Created Successfully!" -ForegroundColor Green

#Add FAQs List Items
Add-PnPListItem -List $FaqListName -Values @{"Title" = "Q. Who do I call to report a water or sewer emergency such as a leaking meter, overflowing manhole or water line break?"; "Description"="During office hours (8 a.m. - 5 p.m. Monday - Friday) contact the Public Operations Center at 704-664-4278. If the emergency is not during these times, call the Mooresville Police Department's non-emergency number at 704-664-3311. The Public Utilities Department has staff on-call 24 hours a day, seven days a week to respond to emergencies.";  "Orders"="1"}
Add-PnPListItem -List $FaqListName -Values @{"Title" = "Q. Who do I contact with questions about my water/sewer bill, or about setting up a new account?"; "Description"="Visit the utility billing office at Town Hall, 413 North Main Street, or call 704-663-3800. For more information, click the link below.";  "Orders"="2"}
Add-PnPListItem -List $FaqListName -Values @{"Title" = "Q. How do I know if my property is inside or outside of the town limits?"; "Description"="The current map of Mooresville’s town limits can be viewed at Iredell County Geographic Information Service to help you locate your parcel. If you have additional questions, call 704-662-7040.";  "Orders"="3"}
Add-PnPListItem -List $FaqListName -Values @{"Title" = "Q. How do I sign up for trash collection or recycling services?"; "Description"="To register for Sanitation Services, please call 704-664-4278 or click here to request Sanitation services online.";  "Orders"="4"}
Add-PnPListItem -List $FaqListName -Values @{"Title" = "Q. What Town department handles drainage issues?"; "Description"="If you live within the town limits and your drainage problems, complaints, or questions are related to a maintenance issue.";  "Orders"="5"}
Write-Host "FAQs List Items Created Successfully!" -ForegroundColor Green


#BreakingNews List
$BreakingnewsListName = "BreakingNews" 
$BreakingnewsListURL="Lists/BreakingNews"
$Template ="GenericList"
New-PnPList -Title $BreakingnewsListName -Url $BreakingnewsListURL -Template $Template

#Get List
$BreakingnewsGetList = Get-PnPList -Identity $BreakingnewsListName
$BreakingnewsListId =  $BreakingnewsGetList.Id

#Add Columns(Field) from xml
$xml1='<Field AppendOnly="FALSE" ClientSideComponentId="00000000-0000-0000-0000-000000000000" DisplayName="Description" Format="Dropdown" IsolateStyles="FALSE" Name="Description" RichText="FALSE" RichTextMode="Compatible" Title="Description" Type="Note" ID="{4f19e3ab-f32b-4bb6-8eb4-637c1a9d2953}" StaticName="Description" ColName="ntext2" RowOrdinal="0" SourceID="{05624ECE-F826-43A3-8F6D-48AB11D47274}" />'
$xml2='<Field DisplayName="Link" Format="Hyperlink" IsModern="TRUE" Name="Link" Required="TRUE" Title="Link" Type="URL" ID="{b0f23622-9ddd-44ae-b727-808fcbda2bea}" SourceID="{857966e8-6c62-4701-8b99-8f4efd9e4655}" StaticName="Link" ColName="nvarchar7" RowOrdinal="0" ColName2="nvarchar8" RowOrdinal2="0" />'
$xml3='<Field ClientSideComponentId="00000000-0000-0000-0000-000000000000" DisplayName="ExpiryDate" FriendlyDisplayFormat="Disabled" Format="DateOnly" Name="ExpiryDate" Title="Expiry Date" Type="DateTime" ID="{29519a95-bef1-4b79-ac66-6c592fc002f6}" Version="2" StaticName="ExpiryDate" SourceID="{85417174-7d77-4bde-89d0-fc54730a1229}" ColName="datetime1" RowOrdinal="0" />'
$xml4='<Field ClientSideComponentId="00000000-0000-0000-0000-000000000000" CustomFormatter="{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;flex-wrap&quot;:&quot;wrap&quot;,&quot;display&quot;:&quot;flex&quot;},&quot;children&quot;:[{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;box-sizing&quot;:&quot;border-box&quot;,&quot;padding&quot;:&quot;4px 8px 5px 8px&quot;,&quot;overflow&quot;:&quot;hidden&quot;,&quot;text-overflow&quot;:&quot;ellipsis&quot;,&quot;display&quot;:&quot;flex&quot;,&quot;border-radius&quot;:&quot;16px&quot;,&quot;height&quot;:&quot;24px&quot;,&quot;align-items&quot;:&quot;center&quot;,&quot;white-space&quot;:&quot;nowrap&quot;,&quot;margin&quot;:&quot;4px 4px 4px 4px&quot;},&quot;attributes&quot;:{&quot;class&quot;:{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$TargetWindow]&quot;,&quot;Open New Page&quot;]},&quot;sp-css-backgroundColor-BgCornflowerBlue sp-css-color-CornflowerBlueFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$TargetWindow]&quot;,&quot;Open Same Page&quot;]},&quot;sp-css-backgroundColor-BgMintGreen sp-css-color-MintGreenFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$TargetWindow]&quot;,&quot;&quot;]},&quot;&quot;,&quot;sp-field-borderAllRegular sp-field-borderAllSolid sp-css-borderColor-neutralSecondary&quot;]}]}]}},&quot;txtContent&quot;:&quot;[$TargetWindow]&quot;}],&quot;templateId&quot;:&quot;BgColorChoicePill&quot;}" DisplayName="Target Window" FillInChoice="FALSE" Format="Dropdown" Name="TargetWindow" Title="Target Window" Type="Choice" ID="{f4d024fa-7673-4fc0-8704-2fccc612600d}" Version="2" StaticName="TargetWindow" SourceID="{85417174-7d77-4bde-89d0-fc54730a1229}" ColName="nvarchar23" RowOrdinal="0"><CHOICES><CHOICE>open in new tab</CHOICE><CHOICE>open in same tab</CHOICE></CHOICES></Field>'

Add-PnPFieldFromXml -List $BreakingnewsListName -FieldXml $xml1
Add-PnPFieldFromXml -List $BreakingnewsListName -FieldXml $xml2
Add-PnPFieldFromXml -List $BreakingnewsListName -FieldXml $xml3
Add-PnPFieldFromXml -List $BreakingnewsListName -FieldXml $xml4

#Add fields in Default View
Set-PnPView -List $BreakingnewsListName -Identity "All Items" -Fields "Title","Description","Link","ExpiryDate","TargetWindow"

Write-Host "BreakingNews List All Fields Created Successfully!" -ForegroundColor Green

#Add BreakingNews List Items
Add-PnPListItem -List $BreakingnewsListName -Values @{"Title" = "The Ethical Life podcast: Which jobs get top marks for honesty, ethics?"; "Description"="test descriptioh";  "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/";"ExpiryDate"="2025-01-01";"TargetWindow"="open in new tab"}
Add-PnPListItem -List $BreakingnewsListName -Values @{"Title" = "Russia says it's ready to keep talking about Ukraine crisis"; "Description"="test descriptioh";  "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"ExpiryDate"="2025-01-01";"TargetWindow"="open in new tab"}
Add-PnPListItem -List $BreakingnewsListName -Values @{"Title" = "Community celebrates groundbreaking for Liberty Park Phase 2"; "Description"="test descriptioh";  "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"ExpiryDate"="2025-01-01";"TargetWindow"="open in new tab"}
Write-Host "BreakingNews List Items Created Successfully!" -ForegroundColor Green

#Quicklinks List
$QlinksListName = "Quicklinks" 
$QlinksListURL="Lists/Quicklinks"
$Template ="GenericList"
New-PnPList -Title $QlinksListName -Url $QlinksListURL -Template $Template

#Get List
$QlinksGetList = Get-PnPList -Identity $QlinksListName
$QlinksListId =  $QlinksGetList.Id



$libraryName = "SiteAssets"

# Check if the library exists
$library = Get-PnPList | Where-Object { $_.Title -eq $libraryName }

if ($null -ne $library) {
    Write-Output "The library '$libraryName' exists."
Add-PnPFolder -Name "Lists" -Folder "SiteAssets"
Add-PnPFolder -Name $QlinksListId -Folder "SiteAssets/Lists"
} else {
    Write-Output "The library '$libraryName' does not exist."
   New-PnPList -Title "SiteAssets" -Template DocumentLibrary
Add-PnPFolder -Name "Lists" -Folder "SiteAssets"
Add-PnPFolder -Name $QlinksListId -Folder "SiteAssets/Lists"

}


Add-PnPFile -Path .\QuicklinksIcons\form-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\form.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\gps-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\gps.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\facility-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\facility.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\service-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\service.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\contract-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\contract.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\mail-white.png -Folder "SiteAssets/Lists/$QlinksListId"
Add-PnPFile -Path .\QuicklinksIcons\mail.png -Folder "SiteAssets/Lists/$QlinksListId"

#Add Columns(Field) from xml
$xml1="<Field CommaSeparator='TRUE' CustomUnitOnRight='TRUE' DisplayName='Orders' Format='Dropdown' IsModern='TRUE' Name='Orders' Percentage='FALSE' Title='Orders' Type='Number' Unit='None' ID='{4d1835b9-7521-4121-a26d-13b9c46ede8a}' StaticName='Orders' />"
$xml2="<Field DisplayName='Link' Format='Hyperlink' IsModern='TRUE' Name='Link' Title='Link' Type='URL' ID='{8f512e01-d26c-41f4-9848-56c9a7222a72}' StaticName='Link' />"
$xml3="<Field DisplayName='Img' Format='Thumbnail' IsModern='TRUE' Name='Img' Title='Img' Type='Thumbnail' ID='{c29b1d77-ae9a-4fa8-8805-5a6db61854d2}' StaticName='Img' />"
$xml4="<Field DisplayName='ImgHover' Format='Thumbnail' IsModern='TRUE' Name='ImgHover' Title='ImgHover' Type='Thumbnail' ID='{fd355903-f15d-448f-98cb-5d3146157b48}' StaticName='ImgHover' />"
$xml5="<Field CustomFormatter='{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;flex-wrap&quot;:&quot;wrap&quot;,&quot;display&quot;:&quot;flex&quot;},&quot;children&quot;:[{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;box-sizing&quot;:&quot;border-box&quot;,&quot;padding&quot;:&quot;4px 8px 5px 8px&quot;,&quot;overflow&quot;:&quot;hidden&quot;,&quot;text-overflow&quot;:&quot;ellipsis&quot;,&quot;display&quot;:&quot;flex&quot;,&quot;border-radius&quot;:&quot;16px&quot;,&quot;height&quot;:&quot;24px&quot;,&quot;align-items&quot;:&quot;center&quot;,&quot;white-space&quot;:&quot;nowrap&quot;,&quot;margin&quot;:&quot;4px 4px 4px 4px&quot;},&quot;attributes&quot;:{&quot;class&quot;:{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;Yes&quot;]},&quot;sp-css-backgroundColor-BgCornflowerBlue sp-field-fontSizeSmall sp-css-color-CornflowerBlueFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;No&quot;]},&quot;sp-css-backgroundColor-BgMintGreen sp-field-fontSizeSmall sp-css-color-MintGreenFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;&quot;]},&quot;&quot;,&quot;sp-field-borderAllRegular sp-field-borderAllSolid sp-css-borderColor-neutralSecondary&quot;]}]}]}},&quot;txtContent&quot;:&quot;@currentField&quot;}],&quot;templateId&quot;:&quot;BgColorChoicePill&quot;}' DisplayName='TargetWindow' FillInChoice='FALSE' Format='Dropdown' IsModern='TRUE' Name='TargetWindow' Title='TargetWindow' Type='Choice' ID='{f334f3ad-2b0e-4b9d-a894-324b2a02cbb1}' StaticName='TargetWindow'><CHOICES><CHOICE>Yes</CHOICE><CHOICE>No</CHOICE></CHOICES></Field>"

Add-PnPFieldFromXml -List $QlinksListName -FieldXml $xml1
Add-PnPFieldFromXml -List $QlinksListName -FieldXml $xml2
Add-PnPFieldFromXml -List $QlinksListName -FieldXml $xml3
Add-PnPFieldFromXml -List $QlinksListName -FieldXml $xml4
Add-PnPFieldFromXml -List $QlinksListName -FieldXml $xml5
#Add fields in Default View
Set-PnPView -List $QlinksListName -Identity "All Items" -Fields "Title","Orders","Link","Img","ImgHover","TargetWindow"


Write-Host "Quicklinks List All Fields Created Successfully!" -ForegroundColor Green
$mailimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/mail.png" -AsListItem)["UniqueId"]
$mailhoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/mail-white.png" -AsListItem)["UniqueId"]
$contractimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/contract.png" -AsListItem)["UniqueId"]
$contracthoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/contract-white.png" -AsListItem)["UniqueId"]
$serviceimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/service.png" -AsListItem)["UniqueId"]
$servicehoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/service-white.png" -AsListItem)["UniqueId"]
$facilityimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/facility.png" -AsListItem)["UniqueId"]
$facilityhoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/facility-white.png" -AsListItem)["UniqueId"]
$gpsimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/gps.png" -AsListItem)["UniqueId"]
$gpshoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/gps-white.png" -AsListItem)["UniqueId"]
$formimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/form.png" -AsListItem)["UniqueId"]
$formhoverimg=(Get-PnPFile -Url "/SiteAssets/Lists/$QlinksListId/form-white.png" -AsListItem)["UniqueId"]

# Construct the image field value separately
$mailimgValue = @{
    type = 'thumbnail'
    fileName = 'mail.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/mail.png'
    id = $mailhoverimg
} | ConvertTo-Json -Compress
$mailhoverValue = @{
    type = 'thumbnail'
    fileName = 'mail-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/mail-white.png'
    id = $mailhoverimg
} | ConvertTo-Json -Compress
$contractimgValue = @{
    type = 'thumbnail'
    fileName = 'contract.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/contract.png'
    id = $contractimg
} | ConvertTo-Json -Compress
$contracthoverimgValue = @{
    type = 'thumbnail'
    fileName = 'contract-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/contract-white.png'
    id = $contracthoverimg
} | ConvertTo-Json -Compress
$serviceimgValue = @{
    type = 'thumbnail'
    fileName = 'service.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/service.png'
    id = $serviceimg
} | ConvertTo-Json -Compress
$servicehoverimgValue = @{
    type = 'thumbnail'
    fileName = 'service-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/service-white.png'
    id = $servicehoverimg
} | ConvertTo-Json -Compress
$facilityimgValue = @{
    type = 'thumbnail'
    fileName = 'facility.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/facility.png'
    id = $facilityimg
} | ConvertTo-Json -Compress
$facilityhoverimgValue = @{
    type = 'thumbnail'
    fileName = 'facility-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/facility-white.png'
    id = $facilityhoverimg
} | ConvertTo-Json -Compress
$gpsimgValue = @{
    type = 'thumbnail'
    fileName = 'gps.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/gps.png'
    id = $gpsimg
} | ConvertTo-Json -Compress
$gpshoverimgValue = @{
    type = 'thumbnail'
    fileName = 'gps-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/gps-white.png'
    id = $gpshoverimg
} | ConvertTo-Json -Compress
$formimgValue = @{
    type = 'thumbnail'
    fileName = 'form.png'
    fieldName = 'Img'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/form.png'
    id = $formimg
} | ConvertTo-Json -Compress
$formhoverimgValue = @{
    type = 'thumbnail'
    fileName = 'form-white.png'
    fieldName = 'ImgHover'
    serverUrl = 'https://'+$Tenantname+'.sharepoint.com'
    serverRelativeUrl = '/sites/'+$Sitename+'/SiteAssets/Lists/'+$QlinksListId+'/form-white.png'
    id = $formhoverimg
} | ConvertTo-Json -Compress
#Add Quicklinks List Items
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "MAIL"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/";"TargetWindow"="open in new tab";"Orders"=1;"Img" = $mailimgValue;"ImgHover" = $mailhoverValue}
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "CONTRACT"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"TargetWindow"="open in new tab";"Orders"=2;"Img" = $contractimgValue;"ImgHover" = $contracthoverimgValue }
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "SELF SERVICE"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"TargetWindow"="open in new tab";"Orders"=3;"Img" = $serviceimgValue;"ImgHover" = $servicehoverimgValue}
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "FACILITYDUDE"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"TargetWindow"="open in new tab";"Orders"=4;"Img" = $facilityimgValue;"ImgHover" = $facilityhoverimgValue }
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "GIS MAPS"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"TargetWindow"="open in new tab";"Orders"=5;"Img" = $gpsimgValue;"ImgHover" = $gpshoverimgValue }
Add-PnPListItem -List $QlinksListName -Values @{"Title" = "LASERFICHE FORMS"; "Link"="https://www.sefalana.com/p/corporate/corporate-strategy/" ;"TargetWindow"="open in new tab";"Orders"=6;"Img"=$formimgValue;"ImgHover" = $formhoverimgValue }
Write-Host "Quicklinks List Items Created Successfully!" -ForegroundColor Green

#Sample Events creation
$eventslistName = "Events"

# Define sample events data
$events = @(
    @{
        Title = "Event 1"
         EventDate = (Get-Date).AddDays(1).AddHours(14)  # Tomorrow at 2:00 PM
        EndDate = (Get-Date).AddDays(1).AddHours(15)    # Tomorrow at 3:00 PM
        Location = "Conference Room A"
        Category = "Meeting"
        Description = "Discussion about Q3 goals"
    },
    @{
        Title = "Event 2"
        EventDate = (Get-Date).AddDays(3).AddHours(14)  # Tomorrow at 2:00 PM
        EndDate = (Get-Date).AddDays(3).AddHours(15)    # Tomorrow at 3:00 PM
        Location = "Conference Room B"
        Category = "Training"
        Description = "Technical training session"
    },
    @{
        Title = "Event 3"
        EventDate = (Get-Date).AddDays(5).AddHours(11)  # 3 days from now at 11:00 AM
        EndDate = (Get-Date).AddDays(5).AddHours(12)    # 3 days from now at 12:00 PM
        Location = "Online"
        Category = "Webinar"
        Description = "Monthly webinar on product updates"
    }
)

# Add each event to the Events list
foreach ($event in $events) {
    Add-PnPListItem -List $eventslistName -Values @{
        Title = $event.Title
        EventDate = $event.EventDate
        EndDate = $event.EndDate
        Location = $event.Location
        Category = $event.Category
        Description = $event.Description
    }
}

Write-Host "Sample events have been created in the SharePoint Events list."

#Create Columns in Site pages
$sitePagesListName = "SitePages" 

$xml1='<Field CustomFormatter="{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;flex-wrap&quot;:&quot;wrap&quot;,&quot;display&quot;:&quot;flex&quot;},&quot;children&quot;:[{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;box-sizing&quot;:&quot;border-box&quot;,&quot;padding&quot;:&quot;4px 8px 5px 8px&quot;,&quot;overflow&quot;:&quot;hidden&quot;,&quot;text-overflow&quot;:&quot;ellipsis&quot;,&quot;display&quot;:&quot;flex&quot;,&quot;border-radius&quot;:&quot;16px&quot;,&quot;height&quot;:&quot;24px&quot;,&quot;align-items&quot;:&quot;center&quot;,&quot;white-space&quot;:&quot;nowrap&quot;,&quot;margin&quot;:&quot;4px 4px 4px 4px&quot;},&quot;attributes&quot;:{&quot;class&quot;:{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;Announcement&quot;]},&quot;sp-css-backgroundColor-BgCyan sp-css-borderColor-CyanFont sp-field-fontSizeSmall sp-css-color-CyanFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;&quot;]},&quot;&quot;,&quot;sp-field-borderAllRegular sp-field-borderAllSolid sp-css-borderColor-neutralSecondary&quot;]}]}},&quot;children&quot;:[{&quot;elmType&quot;:&quot;span&quot;,&quot;style&quot;:{&quot;overflow&quot;:&quot;hidden&quot;,&quot;text-overflow&quot;:&quot;ellipsis&quot;,&quot;padding&quot;:&quot;0 3px&quot;},&quot;txtContent&quot;:&quot;@currentField&quot;,&quot;attributes&quot;:{&quot;class&quot;:{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;Announcement&quot;]},&quot;sp-field-fontSizeSmall sp-css-color-CyanFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;@currentField&quot;,&quot;&quot;]},&quot;&quot;,&quot;&quot;]}]}}}]}],&quot;templateId&quot;:&quot;BgColorChoicePill&quot;}" DisplayName="ArticleType" FillInChoice="FALSE" Format="Dropdown" IsModern="TRUE" Name="ArticleType" Title="ArticleType" Type="Choice" ID="{678eccf0-6bac-427a-b4ed-2a64f98ab978}" SourceID="{b96f3c4e-7fdd-43ca-ae88-edc7a27aaaac}" StaticName="ArticleType" ColName="nvarchar18" RowOrdinal="0"><CHOICES><CHOICE>Announcement</CHOICE></CHOICES></Field>'
$xml2='<Field ClientSideComponentId="00000000-0000-0000-0000-000000000000" CustomFormatter="{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;flex-wrap&quot;:&quot;wrap&quot;,&quot;display&quot;:&quot;flex&quot;},&quot;children&quot;:[{&quot;elmType&quot;:&quot;div&quot;,&quot;style&quot;:{&quot;box-sizing&quot;:&quot;border-box&quot;,&quot;padding&quot;:&quot;4px 8px 5px 8px&quot;,&quot;overflow&quot;:&quot;hidden&quot;,&quot;text-overflow&quot;:&quot;ellipsis&quot;,&quot;display&quot;:&quot;flex&quot;,&quot;border-radius&quot;:&quot;16px&quot;,&quot;height&quot;:&quot;24px&quot;,&quot;align-items&quot;:&quot;center&quot;,&quot;white-space&quot;:&quot;nowrap&quot;,&quot;margin&quot;:&quot;4px 4px 4px 4px&quot;},&quot;attributes&quot;:{&quot;class&quot;:{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$Tags]&quot;,&quot;Departments&quot;]},&quot;sp-css-backgroundColor-BgCornflowerBlue sp-css-color-CornflowerBlueFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$Tags]&quot;,&quot;Government&quot;]},&quot;sp-css-backgroundColor-BgMintGreen sp-css-color-MintGreenFont&quot;,{&quot;operator&quot;:&quot;:&quot;,&quot;operands&quot;:[{&quot;operator&quot;:&quot;==&quot;,&quot;operands&quot;:[&quot;[$Tags]&quot;,&quot;&quot;]},&quot;&quot;,&quot;sp-field-borderAllRegular sp-field-borderAllSolid sp-css-borderColor-neutralSecondary&quot;]}]}]}},&quot;txtContent&quot;:&quot;[$Tags]&quot;}],&quot;templateId&quot;:&quot;BgColorChoicePill&quot;}" DisplayName="Tags" FillInChoice="FALSE" Format="Dropdown" Name="Tags" Title="Tags" Type="Choice" ID="{f4d024fa-7673-4fc0-8704-2fccc612600e}" Version="2" StaticName="Tags" SourceID="{85417174-7d77-4bde-89d0-fc54730a1229}" ColName="nvarchar23" RowOrdinal="0"><CHOICES><CHOICE>Departments</CHOICE><CHOICE>Government</CHOICE></CHOICES></Field>'

Add-PnPFieldFromXml -List $sitePagesListName -FieldXml $xml1
Add-PnPFieldFromXml -List $sitePagesListName -FieldXml $xml2

Set-PnPView -List $sitePagesListName -Identity "By Author" -Fields "Title","Name","PromotedState","ArticleType","Tags"

Write-Host "Columns added successfully in Site Pages"

$siteAssetslibraryName = "SiteAssets"

# Check if the library exists
$library = Get-PnPList | Where-Object { $_.Title -eq $siteAssetslibraryName }

if ($null -ne $library) {
    Write-Output "The library '$siteAssetslibraryName' exists."

} else {
    Write-Output "The library '$siteAssetslibraryName' does not exist."
    New-PnPList -Title "SiteAssets" -Template DocumentLibrary

}
Add-PnPFile -Path .\AnnouncementImages\announce1.jpg -Folder "SiteAssets"
Add-PnPFile -Path .\AnnouncementImages\announce2.jpg -Folder "SiteAssets"
Add-PnPFile -Path .\AnnouncementImages\announce3.jpg -Folder "SiteAssets"


# Define sample news pages
$pages = @(
    @{
        Title = "FMCG-steps-up-marketing-spends"
        Description = "Fast-moving consumer goods (FMCG) companies in India..."
        Url = "/SitePages/FMCG-steps-up-marketing-spends.aspx"
        bannerimg="announce1.jpg"
    },
    @{
        Title = "Olympics-gets-an-AI-touch"
        Description = "Tech giant Intel is the official AI platform partner for the Paris Olympics,"
        Url = "/SitePages/Olympics-gets-an-AI-touch.aspx"
         bannerimg="announce2.jpg"
    }, 
    @{
        Title = "Rise-of-legal-funding-startups"
        Description = "Litigation funding startups in India are looking to cash in when..."
        Url = "/SitePages/Rise-of-legal-funding-startups.aspx"
         bannerimg="announce3.jpg"
    }
)

# Add each page to the site pages list
foreach ($page in $pages) {
    $pagename=$page.Title
    $pagedescription=$page.Description
    $pageurl=$page.Url
    $pagebannerimg=$page.bannerimg
    # Create new page
    $Page = Add-PnPPage -Name $pagename -LayoutType Article
    
    # Set Page properties
    Set-PnPPage -Identity $Page -Title $pagename -CommentsEnabled:$False -HeaderType Default
    
    # Add Section to the Page
    Add-PnPPageSection -Page $Page -SectionTemplate OneColumn
    
    # Add Text to Page
    Add-PnPPageTextPart -Page $Page -Text $pagedescription -Section 1 -Column 1
    
    # Add News web part to the section
    Add-PnPPageWebPart -Page $Page -DefaultWebPartType News -Section 1 -Column 1
    
    # Add List to Page
    Add-PnPPageWebPart -Page $Page -DefaultWebPartType List -Section 1 -Column 1 -WebPartProperties @{ selectedListId = "21b99d39-834f-4991-b5f9-bd095fa0633c"}

#Get the File from SharePoint
$pFile = Get-PnPFile -Url $pageurl -AsListItem

Set-PnPListItem -List "SitePages" -Identity $pFile.Id -Values @{"ArticleType" = "Announcement"}
$imgurl = "/sites/$Sitename/SiteAssets/$pagebannerimg"
Set-PnPPage -Identity $pagename -HeaderType Custom -ServerRelativeImageUrl $imgurl -ThumbnailUrl  $imgurl

#Publish the page
$Page.Publish()

}
Write-Host "Sample pages added successfully in Site Pages"

# Define sample news pages
$npages = @(
    @{
        Title = "FMCG-steps-up-marketing-spends-News"
        Description = "Quite a few large IT firms in India are encouraging..."
        Url = "/SitePages/FMCG-steps-up-marketing-spends-News.aspx"
        tags="Departments"
        bannerimg="announce1.jpg"
    },
    @{
        Title = "Rise-of-legal-funding-startups-News"
        Description = "Litigation funding startups in India are looking to cash..."
        Url = "/SitePages/Rise-of-legal-funding-startups-News.aspx"
        tags="Departments"
        bannerimg="announce2.jpg"
    }, 
    @{
        Title = "How-retail-giants-fared-in-Q1-News"
        Description = "India’s retail giants have announced their financial..."
        Url = "/SitePages/How-retail-giants-fared-in-Q1-News.aspx"
        tags="Government"
        bannerimg="announce3.jpg"
    },
     @{
        Title = "UNIFIED-DEVELOPMENT-ORDINANCE-INFORMATION"
        Description = "After holding 48 public meetings over 21 months, Mooresville has drafted a new ordinance, called the Mooresville Unified Development Ordinance (UDO), guided by the OneMooresville Comprehensive Plan."
        Url = "/SitePages/UNIFIED-DEVELOPMENT-ORDINANCE-INFORMATION.aspx"
        tags="Government"
        bannerimg="announce1.jpg"
    },
     @{
        Title = "CENSUS-INFORMATION-2024"
        Description = "Once a decade, America comes together to participate in the decennial census, creating national awareness of the census and statistics. This census provides the basis for reapportioning Congressional seats, redistricting, and distributing billions of dollars in federal funding to support your state, county, and community’s vital programs."
        Url = "/SitePages/CENSUS-INFORMATION-2024.aspx"
        tags="Government"
        bannerimg="announce2.jpg"
    }
)

# Add each page to the site pages list
foreach ($page in $npages) {
    $pagename=$page.Title
    $pagedescription=$page.Description
    $pageurl=$page.Url
    $pageTags=$page.tags
    $pagebannerimg=$page.bannerimg
    # Create new page
$NewsPost = Add-PnPPage -Name $pagename -LayoutType Article -PromoteAs NewsArticle

# Set News post properties
Set-PnPPage -Identity $NewsPost -Title $pagename -CommentsEnabled:$False -HeaderType Default

# Add a section to the News post
Add-PnPPageSection -Page $NewsPost -SectionTemplate OneColumn

# Add Text to the News post
Add-PnPPageTextPart -Page $NewsPost -Text $pagedescription -Section 1 -Column 1

# Add News web part to the section
Add-PnPPageWebPart -Page $NewsPost -DefaultWebPartType News -Section 1 -Column 1

# Optionally add a List web part to the News post
Add-PnPPageWebPart -Page $NewsPost -DefaultWebPartType List -Section 1 -Column 1 -WebPartProperties @{ selectedListId = "21b99d39-834f-4991-b5f9-bd095fa0633c"}

#Get the File from SharePoint
$nFile = Get-PnPFile -Url $pageurl -AsListItem

Set-PnPListItem -List "SitePages" -Identity $nFile.Id -Values @{"Tags" = $pageTags}
Set-PnPPage -Identity $pagename -HeaderType Custom -ServerRelativeImageUrl "/sites/$Sitename/SiteAssets/$pagebannerimg"
#Publish the page
$NewsPost.Publish()

}

Write-Host "Sample news post added successfully in Site Pages"

#Get Sitepages 
$sitepagesGetList = Get-PnPList -Identity "Sitepages"
$sitepagesListId = $sitepagesGetList.Id

#Get Events List
$eventsGetList = Get-PnPList -Identity "Events"
$eventsListId = $eventsGetList.Id

#Get Homepage
$homepage = Get-PnPHomepage
$homefile = Get-PnPFile -Url $homepage


#Add App to App catalog - upload app to sharepoint online app catalog using powershell
$Addapp4 = Add-PnPApp -Path ".\sppkg\quicklinks-webpart.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
#Deploy App to the site
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "Quicklinks added to the app catalog" -ForegroundColor Green

$Addapp4 = Add-PnPApp -Path ".\sppkg\news.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "news added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\spfx-msgraph-peoplesearch.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "People Search added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\faqs-webpart.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "FAQs added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\breaking-news.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "Breaking News added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\announcements-webpart.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
 Write-Host "Announcement added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\upcomingevents-calendar-webpart.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "Upcoming Events added to the app catalog" -ForegroundColor Green
$Addapp4 = Add-PnPApp -Path ".\sppkg\react-rssreader.sppkg" -Scope Site -Publish
$appid4 = $Addapp4.Id
Install-PnPApp -Identity $appid4 -Scope Site
Write-Host "RSS Reader added to the app catalog" -ForegroundColor Green
Write-Host "Webparts added in appcatalogue Successfull!" -ForegroundColor Green

$pageName = "Home"

#Add section to the page
Add-PnPPageSection -Page $pageName -SectionTemplate OneColumn -Order 0
Add-PnPPageSection -Page $pageName -SectionTemplate OneColumn -Order 1
Add-PnPPageSection -Page $pageName -SectionTemplate OneColumn -Order 2
Add-PnPPageSection -Page $pageName -SectionTemplate TwoColumnRight -Order 3
Add-PnPPageSection -Page $pageName -SectionTemplate ThreeColumn -Order 4
Add-PnPPageSection -Page $pageName -SectionTemplate OneColumn -Order 5 -ZoneEmphasis 3

Write-Host "Section added Successfull!" -ForegroundColor Green

#Get page
$page = Get-PnPPage $pageName

#Webpart Properties
$wpjson1 = ' {"description":"Announcements","lists":"'+$sitepagesListId+'","viewAll":true,"searchBox":false,"itemsToShow":12,"filter":"All"} '
$wpjson2 = ' {"description":"BreakingNews","SelectSpList":"'+$BreakingnewsListId+'"} '
$wpjson3 = ' {"description":"","SelectSpList":"'+$QlinksListId+'"} '
$wpjson4 = @"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"title":"QUICK LINKS","items[0].title":"Document","items[1].title":"Library","items[2].title":"Report Center","items[3].title":"Teams","items[4].title":"Settings"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp","items[1].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp","items[2].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp","items[3].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp","items[4].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://trimjourney.sharepoint.com/sites/CorporatevLook","items[0].sourceItem.url":"https://www.sharepointdesigns.com/corporate-look","items[1].sourceItem.url":"https://www.sharepointdesigns.com/corporate-look","items[2].sourceItem.url":"https://www.sharepointdesigns.com/corporate-look","items[3].sourceItem.url":"https://www.sharepointdesigns.com/corporate-look","items[4].sourceItem.url":"https://www.sharepointdesigns.com/corporate-look"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767},"items[1].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767},"items[2].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767},"items[3].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767},"items[4].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"document"}},{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":2,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"contactcard"}},{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":3,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"piesingle"}},{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":4,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"people"}},{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":5,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"settings"}}],"isMigrated":true,"layoutId":"CompactCard","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@
$wpjson5 = ' {"description":"News","title":"News","listId":"'+$sitepagesListId+'","layout":"CarouselView","toggleForItems":true,"displayalltab":true,"NewsFilter":"AllNews","groupId":"e68f7e85-4425-4bf0-8f0d-572715c55946","setId":"95a6e794-dd97-46ec-a263-6a1f18d2b7cf","multiSelect":["Departments","Government"]} '
$wpjson6 = ' {"selectParameter":"","filterParameter":"","orderByParameter":"","pageSize":"7","webPartTitle":"PEOPLE","showPagination":true,"showLPC":true,"showBlank":true,"showResultsCount":true,"hideResultsOnload":false,"selectedLayout":5,"searchParameterOption":2,"templateParameters":{"peopleFields":[{"name":"User Principal Name","field":"upn","value":"userPrincipalName"},{"name":"Primary Text","field":"text","value":"displayName"},{"name":"Secondary Text","field":"secondaryText","value":"jobTitle"},{"name":"Tertiary Text","field":"tertiaryText","value":"mail"},{"name":"Optional Text","field":"optionalText","value":"mobilePhone"}],"personaSize":12}} '
$wpjson7 = ' {"feedUrl":"https://www.reddit.com/r/Office365/.rss?format=xml","feedService":2,"feedServiceUrl":"","feedServiceApiKey":"","useCorsProxy":false,"corsProxyUrl":"https://cors-anywhere.herokuapp.com/{0}","disableCorsMode":false,"maxCount":5,"cacheResults":false,"cacheResultsMinutes":60,"cacheStorageKeyPrefix":"PnPRssReader","selectedLayout":0,"externalTemplateUrl":"","inlineTemplateText":"","showDesc":true,"showPubDate":true,"descCharacterLimit":100,"titleLinkTarget":"_blank","dateFormat":"MM/DD/YYYY","backgroundColor":"#ffffff","fontColor":"#4EBAFF","showViewAll":true,"title":"RSS Feed"} '
$wpjson8 = ' {"description":"FAQs","list":"'+$FaqListId+'","toggleForItems":false,"toggleForTabs":false,"sortBy":"Default","title":"FAQ","groupId":"e68f7e85-4425-4bf0-8f0d-572715c55946","setId":"d5b5963d-2e15-4573-8e01-f237df0c3d6c"} '
$wpjson9 = ' {"description":"UpcomingEvents-Calendar","lists":"'+$eventsListId+'","viewAll":true,"viewAllUrl":"'+$sitename+'/Lists/Events","title":"UPCOMING EVENTS","listUrl":"Lists/Events","siteName":"'+$sitename+'","listName":"Events"} '

#Add Custom webpart
Add-PnPPageWebPart -Page $pageName -Component "Announcements" -Section 1 -Column 1 -Order 1 -WebPartProperties $wpjson1
Add-PnPPageWebPart -Page $pageName -Component "BreakingNews" -Section 2 -Column 1 -Order 1 -WebPartProperties $wpjson2
Add-PnPPageWebPart -Page $pageName -Component "QuickLinks" -Section 3 -Column 1 -Order 1 -WebPartProperties $wpjson3
Add-PnPPageWebPart -Page $pageName -DefaultWebPartType "QuickLinks" -Section 4 -Column 1 -Order 1 -WebPartProperties $wpjson4
Add-PnPPageWebPart -Page $pageName -Component "News" -Section 4 -Column 2 -Order 1 -WebPartProperties $wpjson5
Add-PnPPageWebPart -Page $pageName -Component "People Search" -Section 5 -Column 1 -Order 1 -WebPartProperties $wpjson6
Add-PnPPageWebPart -Page $pageName -Component "Rss Reader" -Section 5 -Column 2 -Order 1 -WebPartProperties $wpjson7
Add-PnPPageWebPart -Page $pageName -Component "FAQs" -Section 5 -Column 3 -Order 1 -WebPartProperties $wpjson8
Add-PnPPageWebPart -Page $pageName -Component "UpcomingEvents-Calendar" -Section 6 -Column 1 -Order 1 -WebPartProperties $wpjson9

Write-Host "All webparts added successfull!" -ForegroundColor Green
$APage = Add-PnPPage -Name "Admin Page" -LayoutType Article
Write-Host "Admin page created successfull!" -ForegroundColor Green
Set-PnPPage -Identity $APage -Title "Admin Page" -CommentsEnabled:$False -HeaderType Default
Add-PnPPageSection -Page $APage -SectionTemplate ThreeColumn -Order 0
$APage.Publish()
$wpjson10 = @"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"items[0].title":"Breaking News"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://$Tenantname.sharepoint.com/sites/$Sitename","items[0].sourceItem.url":"/sites/$Sitename/Lists/BreakingNews/AllItems.aspx"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"news"}}],"isMigrated":true,"layoutId":"Button","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@
$wpjson11 =@"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"items[0].title":"FAQs"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://$Tenantname.sharepoint.com/sites/$Sitename","items[0].sourceItem.url":"/sites/$Sitename/Lists/FAQs/AllItems.aspx"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"clipboardlistquestion"}}],"isMigrated":true,"layoutId":"Button","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@
$wpjson12 = @"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"items[0].title":"Quicklinks"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://$Tenantname.sharepoint.com/sites/$Sitename","items[0].sourceItem.url":"/sites/$Sitename/Lists/Quicklinks/AllItems.aspx"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"addlink"}}],"isMigrated":true,"layoutId":"Button","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@
$wpjson13 = @"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"items[0].title":"Events"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://$Tenantname.sharepoint.com/sites/$Sitename","items[0].sourceItem.url":"/sites/$Sitename/Lists/Events/calendar.aspx"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"editevent"}}],"isMigrated":true,"layoutId":"Button","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@
$wpjson14 =@"
{"position":{"layoutIndex":1,"zoneIndex":3,"zoneId":"174d4227-c0b4-43b3-b10a-83493663d96e","sectionIndex":1,"sectionFactor":4,"controlIndex":1},"emphasis":{"zoneEmphasis":0},"id":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","controlType":3,"addedFromPersistedData":true,"isFromSectionTemplate":false,"webPartData":{"id":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","instanceId":"c2547753-e6bc-43d6-9a37-b446a5b6b36d","title":"Quick links","description":"Show a collection of links to content such as documents, images, videos, and more in a variety of layouts with options for icons, images, and audience targeting.","audiences":[],"serverProcessedContent":{"htmlStrings":{},"searchablePlainTexts":{"items[0].title":"Site Assets"},"imageSources":{"items[0].rawPreviewImageUrl":"https://cdn.prod.website-files.com/624fdbbf2da9f429057410bc/668f7f68a71e7a0773e351cb_DIY.webp"},"links":{"baseUrl":"https://$Tenantname.sharepoint.com/sites/$Sitename","items[0].sourceItem.url":"/sites/$Sitename/SiteAssets/Forms/AllItems.aspx"},"componentDependencies":{"layoutComponentId":"706e33c8-af37-4e7b-9d22-6e5694d92a6f"},"customMetadata":{"items[0].rawPreviewImageUrl":{"fixedWidth":100,"minCanvasWidth":32767}}},"dataVersion":"2.3","properties":{"items":[{"sourceItem":{"itemType":2,"fileExtension":"","progId":""},"thumbnailType":2,"id":1,"description":"","altText":"","rawPreviewImageMinCanvasWidth":32767,"fabricReactIcon":{"iconName":"assetlibrary"}}],"isMigrated":true,"layoutId":"Button","shouldShowThumbnail":true,"imageWidth":100,"buttonLayoutOptions":{"showDescription":false,"buttonTreatment":2,"iconPositionType":2,"textAlignmentVertical":2,"textAlignmentHorizontal":2,"linesOfText":2},"listLayoutOptions":{"showDescription":false,"showIcon":true},"waffleLayoutOptions":{"iconSize":1,"onlyShowThumbnail":false},"hideWebPartWhenEmpty":true,"dataProviderId":"QuickLinks","webId":"a4bc9162-de2e-4bf7-ae00-85822f3c9396","siteId":"44ce7820-5b47-448e-bb4a-6e47baf71f1e","Title":"Document","iconPicker":"settings"},"containsDynamicDataSource":false},"webPartId":"c70391ea-0b10-4ee9-b2b4-006d3fcad0cd","reservedWidth":297,"reservedHeight":382}
"@

Add-PnPPageWebPart -Page "Admin Page" -DefaultWebPartType "QuickLinks" -Section 2 -Column 1 -Order 1 -WebPartProperties $wpjson10
Add-PnPPageWebPart -Page "Admin Page" -DefaultWebPartType "QuickLinks" -Section 2 -Column 2 -Order 1 -WebPartProperties $wpjson11
Add-PnPPageWebPart -Page "Admin Page" -DefaultWebPartType "QuickLinks" -Section 2 -Column 3 -Order 1 -WebPartProperties $wpjson12
Add-PnPPageWebPart -Page "Admin Page" -DefaultWebPartType "QuickLinks" -Section 2 -Column 1 -Order 2 -WebPartProperties $wpjson13
Add-PnPPageWebPart -Page "Admin Page" -DefaultWebPartType "QuickLinks" -Section 2 -Column 2 -Order 2 -WebPartProperties $wpjson14
Write-Host "Links added to admin page successfully" -ForegroundColor Green

Add-PnPNavigationNode -Title "Admin page" -Url "http://$Tenantname.sharepoint.com/sites/$Sitename/SitePages/Admin Page.aspx" -Location "QuickLaunch"
