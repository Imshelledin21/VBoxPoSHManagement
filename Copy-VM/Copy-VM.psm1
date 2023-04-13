function Copy-VM {
    param(
        [string] $VmToClone = "Ubuntu-Default",
        [string] $NewVmName,
        [bool]   $AutoStart = $true
    )

    VBoxManage clonevm $VmToClone --name $NewVmName --register

    if ($AutoStart -eq $true){
        VM-Start $NewVmName
    }
}
Export-ModuleMember -Function Copy-VM