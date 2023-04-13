function Start-VM {
param(
    [string] $vm_boxname = "Ubuntu-Default"
)

##########################################################################################################################
### CONSTANTS
##########################################################################################################################
$vm_username = "sheldon"
$vm_password = "Dumb13Dor3!"

##########################################################################################################################
### MAIN SCRIPT
##########################################################################################################################


Write-Host "SSH operations will be under $vm_username"
Write-Host "Starting up $vm_boxname"


VBoxManage startvm $vm_boxname --type headless

Write-Host "$vm_boxname booting up..."
for ($i = 0; $i -le 5; $i++){
    Write-Host "Booting Up..."
    Start-Sleep -Seconds 5
}

$IpInfo = VBoxManage guestproperty enumerate $vm_boxname /VirtualBox/GuestInfo/Net/0/V4/IP
$IpInfo -match "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b"

$GuestIpAddress = $Matches[0]

Write-Host "-----------------------"
Write-Host "Guest IP Address: $GuestIpAddress"
Write-Host "-----------------------"

Get-Content $env:USERPROFILE\.ssh\id_rsa.pub | ssh $vm_username@$GuestIpAddress "cat >> .ssh/authorized_keys"
Start-Sleep -m 1000

ssh $vm_username@$GuestIpAddress

}

Export-ModuleMember -Function Start-VM