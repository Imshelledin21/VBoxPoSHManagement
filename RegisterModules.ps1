param(
    [string] [Parameter(Mandatory=$true)]$username
)

$Env:VBOX_USERNAME  = $username



$directories = Get-ChildItem -Path .\ -Directory

foreach ($directory in $directories){
    Write-Host "Importing Module: $directory"
    Import-Module $directory
}