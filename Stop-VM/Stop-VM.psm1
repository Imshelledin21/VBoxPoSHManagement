Function Stop-VM{
    Param(
        [string] $VmName
    )

    VBoxManage controlvm $VmName poweroff 
}
Export-ModuleMember -Function Stop-VM