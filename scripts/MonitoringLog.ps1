try
{
    New-EventLog -LogName ProcessMonitoringLog -Source MonitoringLog -ErrorAction Stop
}
catch
{
    Write-Error "EvenLog is already exists"
}