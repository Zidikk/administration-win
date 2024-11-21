Get-EventLog System | Where-Object {$_.EventID -contains "19"} | Select -First 10 > "C:\Dev\task.txt"

Get-HotFix | Sort InstalledOn -Descending | Select-Object HotFixID, InstalledOn -First 5 >> "C:\Dev\task.txt"

Get-WinEvent -Force -ListLog * | Where-Object {$_.RecordCount -AND $_.LastWriteTime -LE (Get-Date).AddDays(-1)} | 
    ForEach-Object {Get-WinEvent -LogName $_.LogName} | Group-Object -Property LevelDisplayName |
    Where-Object {"Ошибка","Предупреждение" -contains $_.Name} | Select-Object Name, Count >> "C:\Dev\task.txt"