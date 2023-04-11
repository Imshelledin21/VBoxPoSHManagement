function VM-Clone {
    param(
        [string] $vm_to_clone = "Ubuntu-Default",
        [string] $new_vm_name
    )

    VBoxManage clonevm $vm_to_clone --name $new_vm_name

    
}
Export-ModuleMember -Function VM-Clone