Function Remove-VM {
    Param(
        [string] $VmName,
        [bool]   $Force
    )

    $VM_Directory = "C:\Users\Sheldon (Grafana)\VirtualBox VMs\$VmName"

    #Shut down VM if it is running and Force is requested
    if ($Force -eq $true){
        Stop-VM -VmName $VmName 
    }
    
    VBoxManage unregistervm $VmName --delete
    if (Test-Path -Path $VM_Directory){
        Remove-Item -Path $VM_Directory -Recurse -Force
    }
}

Export-ModuleMember -Function Remove-VM