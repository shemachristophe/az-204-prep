#Provision New VM with New-AzVm
New-AzVm `
    -ResourceGroupName "az-204-4rg" `
    -Name "myVM3" `
    -Location "East US" `
    -VirtualNetworkName "myVnet3" `
    -SubnetName "mySubnet3" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389

#Get the public IP of our VM
Get-AzPublicIpAddress `
   -ResourceGroupName "az-204-4rg"  | Select IpAddress

#Connect to our VM
mstsc /v:<publicIpAddress From Above Command>


<#
State           Description
---------------------------------
Starting        The VM is being started.
Running 	    The VM is running.
Stopping 	    The VM is being stopped
Stopped 	    The VM is stopped. VM in the stopped state still incur compute charges.
Deallocating 	The VM is being deallocated.
Deallocated 	VM is removed from the hypervisor but is still available in the control plane. Virtual machines in the Deallocated state do not incur compute charges.
#>


#Check the state of our VM
Get-AzVM `
    -ResourceGroupName "az-204-4rg" `
    -Name "myVM3" `
    -Status | Select @{n="Status"; e={$_.Statuses[1].Code}}

<#
ex: 
Status
------
PowerState/running
#>

#Stop VM
Stop-AzVM `
   -ResourceGroupName "az-204-4rg" `
   -Name "myVM3" -Force

#Start VM
Start-AzVM `
   -ResourceGroupName "az-204-4rg" `
   -Name "myVM3"

#Clean Up
Remove-AzResourceGroup `
   -Name "az-204-4rg" `
   -Force
