Function Enter-VM {
    Param(
        [string] $VmName = "DevEnv"
    )

    $GuestIpAddress = Get-IpAddress -VmName $VmName

    Write-Host $GuestIpAddress

    ssh $Env:VBOX_USERNAME@$GuestIpAddress
}

Export-ModuleMember -Function Enter-VM