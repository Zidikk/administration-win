try 
{
    $processList = Get-Process -IncludeUserName | Select-Object ID, ProcessName, Path, UserName, CPU, WS
    $processInfoList = @()
    ForEach ($process in $processList)
    {
        $processInfo = 
        @{
            ID = $process.ID
            ProcessName = $process.ProcessName
            Path = $process.Path
            UserName = $process.UserName
            Cpu = $process.CPU
            Ws = $process.WS
            Time = Get-Date
        }
        $processInfoList += New-Object -TypeName PSObject -Property $processInfo
    }
    $processInfoList | Export-CSV "C:\Dev\ProcessInfo.csv" -ErrorAction Stop
    Write-EventLog -LogName ProcessMonitoringLog -Source MonitoringLog -EventId 1 -EntryType SuccessAudit -Message "Succesful"
}
catch
{
    Write-EventLog -LogName ProcessMonitoringLog -Source MonitoringLog -EventId 2 -EntryType FailureAudit -Message "Faild"
}