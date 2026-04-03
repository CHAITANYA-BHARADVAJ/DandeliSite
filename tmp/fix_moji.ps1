$files = @("d:\Antigravity\DandeliSite\student-packages.html", "d:\Antigravity\DandeliSite\family-packages.html")
$map = @{
  "ðŸ •ï¸ " = "🏕️"
  "ðŸ Š" = "🏊"
  "ðŸ¤ " = "🤍"
  "â ¤ï¸ " = "❤️"
  "ðŸ“ " = "📍"
  "â­ " = "⭐"
  "â† " = "←"
  "Ã¢”â‚¬Ã¢”â‚¬" = "──"
  "âœ¨" = "✨"
  "ðŸ‘¨” ðŸ‘©” ðŸ‘§” ðŸ‘¦" = "👨‍👩‍👧‍👦"
  "ðŸ ½" = "🍽️"
  "ðŸŒ§" = "🌧️"
}

foreach ($file in $files) {
    if (Test-Path $file) {
        $text = [IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        foreach ($key in $map.Keys) {
            $text = $text.Replace($key, $map[$key])
        }
        $utf8bom = New-Object System.Text.UTF8Encoding $true
        [IO.File]::WriteAllText($file, $text, $utf8bom)
    }
}
Write-Host "Done!"
