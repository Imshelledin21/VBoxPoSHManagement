Function Get-IpAddress {
    Param(
        [string] $VmName
    )

    $IpInfo = VBoxManage guestproperty enumerate "$VmName" "/VirtualBox/GuestInfo/Net/0/V4/IP"
    $IpInfo -match "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b" | Out-Null
    $GuestIpAddress = $Matches[0]

    return $GuestIpAddress
}

Export-ModuleMember -Function Get-IpAddress