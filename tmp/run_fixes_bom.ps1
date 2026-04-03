$files = Get-ChildItem -Path "d:\Antigravity\DandeliSite" -Filter "*.html" -File

$replacements = @{
    "ðŸ ƒ" = "🌿"
    "ðŸ¤ " = "🤍"
    "â˜…â˜…â˜…â˜…â˜…" = "★★★★★"
    "â˜…â˜…â˜…â˜…☆" = "★★★★☆"
    "â˜…â˜…â˜…☆☆" = "★★★☆☆"
    "â˜…â˜…☆☆☆" = "★★☆☆☆"
    "ðŸ“ " = "📍"
    "âœ“" = "✓"
    "âœ…" = "✅"
    "ðŸ Š" = "🏊"
    "ðŸ“¶" = "📶"
    "â‚¹" = "₹"
    "ðŸ’¬" = "💬"
    "ðŸŽ’" = "🎒"
    "ðŸ‘¥" = "👥"
    "ðŸ •ï¸ " = "🏕"
    "ðŸŒŠ" = "🌊"
    "ðŸ”¥" = "🔥"
    "ðŸš—" = "🚗"
    "ðŸš£" = "🚣"
    "ðŸ¥¾" = "🥾"
    "ðŸ¦ " = "🦁"
    "ðŸ”µ" = "🔵"
    "ðŸ’°" = "💰"
    "â ¤ï¸ " = "❤️"
    "â€º" = "›"
    "ðŸ‘¨â€ ðŸ‘©â€ ðŸ‘§â€ ðŸ‘¦" = "👨‍👩‍👧‍👦"
    "ðŸ“ž" = "📞"
    "ðŸ  " = "🏠"
    "â€”" = "—"
    "â–¼" = "▼"
    "â€\"" = "—"
    "Ã¢â‚¬â‚¬" = "─"
    "â”€" = "─"
    "â€¢" = "•"
    "â€™" = "’"
    "ðŸ•’" = "🕒"
    "â† " = "←"
    "â˜…" = "★"
    "â˜†" = "☆"
    "â€œ" = "“"
    "â€ " = "”"
    "Ã¢â‚¬â€ " = "—"
    "â­ " = "⭐"
    "â›º" = "⛺"
    "âœ¨" = "✨"
    "ðŸ ¨" = "🏨"
}

$count = 0
foreach ($f in $files) {
    if ($f.Name -Like "tmp*") { continue }
    
    # Check if the file contains any sequence that looks like mojibake.
    # To do this safely, we load the raw text using UTF-8
    $text = [IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $orig = $text

    foreach ($key in $replacements.get_Keys()) {
        $text = $text.Replace($key, $replacements[$key])
    }

    if ($orig -ne $text) {
        $utf8bom = New-Object System.Text.UTF8Encoding $true
        [IO.File]::WriteAllText($f.FullName, $text, $utf8bom)
        Write-Host "FIXED: $($f.Name)" -ForegroundColor Green
        $count++
    }
}
Write-Host "Total fixed: $count" -ForegroundColor Magenta
