Function Remove-VM {
    Param(
        [string] $VmName,
        [bool]   $Force
    )

    #Shut down VM if it is running and Force is requested
    if ($Force -eq $true){
        VBoxManage controlvm $VmName poweroff 
    }

    
}

Export-ModuleMember -Function Remove-VM