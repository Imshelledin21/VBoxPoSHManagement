Function Copy-VM {
    Param(
        [string] $VmToClone = "Ubuntu-Default",
        [string] $NewVmName,
        [bool]   $AutoStart = $true
    )

    $SnapshotName = "$NewVmName Snapshot"

    VBoxManage snapshot $VmToClone take "SnapshotName" --description "Snapshot for linked clone: $NewVmName"
    VBoxManage clonevm $VmToClone --name $NewVmName --options "Link" --snapshot "SnapshotName" --register
    VBoxManage snapshot $VmToClone delete "SnapshotName"

    if ($AutoStart -eq $true){
        Start-VM -vm_boxname $NewVmName -StartingFromClone $true
    }
}
Export-ModuleMember -Function Copy-VM