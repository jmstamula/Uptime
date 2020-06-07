$SecurePassword = $env:Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $env:User, $SecurePassword
$Computers = ($env:Computer).Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)

Foreach ($computer in $Computers)
 {"Working on Computer $computer, please wait..."
 
 "$computer"
 (Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem -ComputerName $computer -Credential $cred).LastBootUpTime)  `
    | Select-Object -Property Days,Hours,Minutes | FL

}
