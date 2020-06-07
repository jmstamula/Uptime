(Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem -ComputerName VWNV02AX02185).LastBootUpTime) | Select-Object -Property Days,Hours,Minutes | FL
