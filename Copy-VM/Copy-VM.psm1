Function Copy-VM {
    Param(
        [string] $CloneName = "Ubuntu-Default",
        [string] $VMName,
        [bool]   $AutoStart = $true
    )

    $SnapshotName = "$VMName Snapshot"

    VBoxManage snapshot $CloneName take "$SnapshotName" --description "Snapshot for linked clone: $VMName"
    VBoxManage clonevm $CloneName --name $VMName --options "Link" --snapshot "$SnapshotName" --register
    VBoxManage snapshot $CloneName delete "$SnapshotName"

    if ($AutoStart -eq $true){
        Start-VM -VMName $VMName -StartingFromClone $true
    }
}
Export-ModuleMember -Function Copy-VM