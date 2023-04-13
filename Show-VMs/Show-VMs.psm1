function Show-VMs {
    VBoxManage list vms --sorted
}

Export-ModuleMember -Function Show-VMs