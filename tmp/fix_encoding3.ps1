# Fix mojibake characters safely
$files = Get-ChildItem -Path "d:\Antigravity\DandeliSite" -Filter "*.html" -File

$replacements = @(
    @("ðŸ ƒ", "🌿"),
    @("ðŸ¤ ", "🤍"),
    @("â˜…â˜…â˜…â˜…☆", "★★★★☆"),
    @("ðŸ“ ", "📍"),
    @("âœ“", "✓"),
    @("ðŸ Š", "🏊"),
    @("ðŸ“¶", "📶"),
    @("â‚¹", "₹"),
    @("â˜…â˜…â˜…â˜…â˜…", "★★★★★"),
    @("â˜…â˜…â˜…â˜†â˜†", "★★★☆☆"),
    @("â˜…â˜…â˜…â˜…â˜†", "★★★★☆"),
    @("ðŸ’¬", "💬"),
    @("ðŸŽ’", "🎒"),
    @("ðŸ‘¥", "👥"),
    @("ðŸ •ï¸ ", "🏕"),
    @("ðŸŒŠ", "🌊"),
    @("ðŸ”¥", "🔥"),
    @("ðŸš—", "🚗"),
    @("ðŸš£", "🚣"),
    @("ðŸ¥¾", "🥾"),
    @("ðŸ¦ ", "🦁"),
    @("ðŸ”µ", "🔵"),
    @("ðŸ’°", "💰"),
    @("â ¤ï¸ ", "❤️"),
    @("â€º", "›"),
    @("ðŸ‘¨â€ ðŸ‘©â€ ðŸ‘§â€ ðŸ‘¦", "👨‍👩‍👧‍👦"),
    @("ðŸ“ž", "📞"),
    @("ðŸ  ", "🏠")
)

$count = 0
foreach ($f in $files) {
    # Read text 
    $text = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
    $orig = $text

    foreach ($pair in $replacements) {
        $text = $text.Replace($pair[0], $pair[1])
    }

    if ($orig -ne $text) {
        # Write text back
        [IO.File]::WriteAllText($f.FullName, $text, (New-Object System.Text.UTF8Encoding $false))
        Write-Host "Fixed: $($f.Name)"
        $count++
    }
}
Write-Host "Total fixed: $count"
