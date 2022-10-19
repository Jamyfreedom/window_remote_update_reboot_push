

$ServerNames = @("server1","server2","server3")
$server_list_1 = Get-Content 'C:\Users\test_user\Desktop\test server list.txt'



$check_available_update = Get-WUList -ComputerName $servers
$check_available_update_amount = (Get-WUList -ComputerName "$servers" | Measure-Object -Line).Lines
$confirm_update_send = Select-String C:\temp\PSWindowsUpdate_2.log -Pattern "Starting task: PSWindowsUpdate"







foreach ($servers in $ServerNames){



Write-Host "Accessing $servers , please wait a sec...."



   if ($check_available_update -ne $null){
    Write-Host "Total : $check_available_update_amount update available."



   Write-Host "Update Available, automatically proceed...."
   Invoke-WUJob  -ComputerName $servers -Script {ipmo PSWindowsUpdate; Install-WindowsUpdate -AcceptAll | Out-File C:\Users\test_user\Desktop\PSWindowsUpdate.log } -RunNow -Confirm:$false  -ErrorAction Ignore -Verbose | Out-File C:\temp\PSWindowsUpdate_2.log
    
    
        if ($confirm_update_send -ne $null){
    
        Write-Host "Update request send confirmed."
        }



   




    }else {



   Write-Host "$servers have no any update available, No action taken."



   }
}



# Phase 2 , all server received update request , Its time to check update done 
