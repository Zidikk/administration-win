$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-File C:\Dev\MonitoringLogCreater.ps1'
$time = New-TimeSpan -Minutes 3
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $time -RepetitionDuration ([timeSpan]::MaxValue)
$settings = New-ScheduledTaskSettingsSet -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries

try
{
    Register-ScheduledTask -TaskName "Task monitoring" -Action $action -Trigger $trigger -Settings $settings
}
catch
{
    Write-Error "Scheduled task is already exist"
}