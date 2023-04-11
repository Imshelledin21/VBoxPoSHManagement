function VM-List {
    VBoxManage list vms --sorted
}

Export-ModuleMember -Function VM-List