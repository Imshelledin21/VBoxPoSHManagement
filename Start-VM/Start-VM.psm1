Function Start-VM {
    Param(
        [string] $VmName,
        [bool]   $StartingFromClone = $false
    )

    Write-Host "SSH operations will be under $Env:VBOX_USERNAME"
    Write-Host "Starting up $VMName"


    VBoxManage startvm $VMName --type headless

    Write-Host "$VMName booting up..."

    if ($StartingFromClone -eq $true){
        VBoxManage guestproperty wait "$VMName" "/VirtualBox/GuestInfo/Net/0/V4/IP"
    } else {
        Start-Sleep -Seconds 20
    }

    $GuestIpAddress = Get-IpAddress -VmName $VMName

    Write-Host "-----------------------"
    Write-Host "Guest IP Address: $GuestIpAddress"
    Write-Host "-----------------------"


    Enter-VM -VmName $VMName
}

Export-ModuleMember -Function Start-VM