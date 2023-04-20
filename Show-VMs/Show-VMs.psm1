function Show-VMs {
    class VMData {
        [string] $VMName
        [string] $VMIpAddress
        [string] $VMState
    }
    
    $VMs = VBoxManage list vms --sorted    

    $VMData = @()

    foreach ($VM in $VMs){
        $VMName = $VM.Split(' ')
        $VMName = $VMName[0]

        $VMIpAddressInfo = VBoxManage guestproperty get "$VMName" "/VirtualBox/GuestInfo/Net/0/V4/IP"
        $VMIpAddress = $VMIpAddressInfo.Split(' ')[1]

        $VMInfo = VBoxManage showvminfo $VMName --machinereadable
        $VMInfoArray = $VMInfo.Split(' ')
        $VMState = ""
        Foreach ($state in $VMInfoArray){

            if ($state -match "VMState"){
                $VMState = $state
                break
            }
        }

        $VMState = $VMState.Split('=')[1] -replace '["]',''
        

        $vm = [VMData]::new()
        $vm.VMName = $VMName
        $vm.VMIpAddress = $VMIpAddress
        $vm.VMState = $VMState

        $VMData += $vm
    }
    
    $VMdata | Format-Table
}

Export-ModuleMember -Function Show-VMs