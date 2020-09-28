Function Get-RebootTime{
$SecurePassword = $env:Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $env:User, $SecurePassword
$Computers = ($env:Computer).Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)

Foreach ($computer in $Computers){

# search latest reboot events in the system log

try {
		$EVENTS = Get-EventLog -LogName System -ComputerName $computer -Credential $cred -Source Microsoft-Windows-Kernel-General -InstanceId 12 -Newest 2
		$SCRIPT:TIMESPAN = $NULL
	
		# loop through found events
		foreach ($EVENT in $EVENTS)
		{
			# get time stamp
			$BOOTTIME = $EVENT.TimeGenerated
			if (!$SCRIPT:TIMESPAN)
			{
		  	"Last boot time of computer $computer`: $BOOTTIME"
				$SCRIPT:TIMESPAN = New-TimeSpan -Start $BOOTTIME
				if ($($SCRIPT:TIMESPAN.Days) -lt 1)
				{
					"Computer $Computer is active for less than a day."
				}
				else
				{
					"Computer $Computer is active for over $($SCRIPT:TIMESPAN.Days) days."
				}
			}
			else
			{
				"Boot time of computer $Computer`: $BOOTTIME"
			}
		}
	}
	catch {
		Write-Error "Cannot connect to computer $Computer"
	}
}


}Get-RebootTime
