# done and reboot
$total_update = Read-Host -Prompt "How many update available? (Type-in number only, Felicia focus)"







$ServerNames = @("server1", "server2")
$server_list_1 =Get-Content C:\Users\test_user\Desktop\server_list_1.txt



foreach ($servers in $ServerNames){



#Get-WUHistory  -Verbose -ComputerName $servers | Select-Object -First 4
$confirm_installed = Get-WUHistory -Verbose -ComputerName $servers | findstr "$date_format" | findstr Succeeded
$confirm_installed_2 = (Get-WUHistory -Verbose -ComputerName $servers | findstr "$date_format"  | Measure-Object -Line).Lines
$date_format = Get-Date -Format "dd/MM/yyyy"




    if ($null -ne $confirm_installed){ # one of them is installed
    Write-Host "Pass 1"
        
        if ($confirm_installed_2 -eq $total_update){ # all is installed



       Write-Host "All install done may proceed reboot!"
        #reboot command
        #Invoke-Command -ComputerName $servers –ScriptBlock {Restart-Computer -Wait -For PowerShell -Timeout 300 -Delay 10 }
        Restart-Computer -ComputerName $servers -Wait -For PowerShell -Delay 10
        Write-Host "$servers reboot done! Proceed next server"




        # wait for powershell command



       }elseif ($confirm_installed_2 -ne $total_update){
        Write-Host "$servers Installation no fully complete, please try again later OR you type wrong numbers"
        }else{
        Write-Host "Error exit"
        }




    }else{
    
    Write-Host "$servers install in progress, please try again later"
    }





}
