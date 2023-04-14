Function Start-VM {
    Param(
        [string] $vm_boxname,
        [bool]   $StartingFromClone = $false
    )


    ##########################################################################################################################
    ### MAIN SCRIPT
    ##########################################################################################################################


    Write-Host "SSH operations will be under $Env:VBOX_USERNAME"
    Write-Host "Starting up $vm_boxname"


    VBoxManage startvm $vm_boxname --type headless

    Write-Host "$vm_boxname booting up..."

    if ($StartingFromClone -eq $true){
        VBoxManage guestproperty wait "$vm_boxname" "/VirtualBox/GuestInfo/Net/0/V4/IP"
    } else {
        Start-Sleep -Seconds 20
    }

    $IpInfo = VBoxManage guestproperty enumerate "$vm_boxname" "/VirtualBox/GuestInfo/Net/0/V4/IP"

    Write-Host $IpInfo

    $IpInfo -match "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b"

    $GuestIpAddress = $Matches[0]

    Write-Host "-----------------------"
    Write-Host "Guest IP Address: $GuestIpAddress"
    Write-Host "-----------------------"


    ssh $Env:VBOX_USERNAME@$GuestIpAddress


}

Export-ModuleMember -Function Start-VM