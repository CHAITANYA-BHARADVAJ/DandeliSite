# Fix mojibake encoding issues across all HTML files
# Uses array-based approach to avoid PowerShell hash literal parsing issues

$basePath = "d:\Antigravity\DandeliSite"
$files = Get-ChildItem -Path $basePath -Filter "*.html" -File

$totalFixed = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    # Fix em dash: the bytes C3 A2 E2 82 AC E2 80 9C appear as mojibake for em dash
    # Pattern: â€" (3 chars that represent broken em dash) -> —
    $content = $content.Replace([char]0x00E2 + [string][char]0x20AC + [string][char]0x201C, [string][char]0x2014)
    
    # Fix down triangle: â–¼ -> ▼
    $content = $content.Replace([char]0x00E2 + [string][char]0x0096 + [string][char]0x00BC, [string][char]0x25BC)
    
    # Fix right angle bracket: â€º -> ›
    $content = $content.Replace([char]0x00E2 + [string][char]0x20AC + [string][char]0x00BA, [string][char]0x203A)
    
    # Fix box-drawing: â"€ -> ─ 
    $content = $content.Replace([char]0x00E2 + [string][char]0x201C + [string][char]0x20AC, [string][char]0x2500)
    
    # Fix filled star: â˜… -> ★
    $content = $content.Replace([char]0x00E2 + [string][char]0x02DC + [string][char]0x0085, [string][char]0x2605)
    
    # Fix empty star: â˜† -> ☆
    $content = $content.Replace([char]0x00E2 + [string][char]0x02DC + [string][char]0x2020, [string][char]0x2606)
    
    # Fix red heart: â¤ï¸ -> ❤️
    $content = $content.Replace([char]0x00E2 + [string][char]0x00A4 + [string][char]0x00EF + [string][char]0x00B8 + [string][char]0x008F, [string][char]0x2764 + [string][char]0xFE0F)

    if ($content -ne $original) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
        $totalFixed++
    } else {
        Write-Host "CLEAN: $($file.Name)" -ForegroundColor DarkGray
    }
}

Write-Host "`nFiles modified: $totalFixed" -ForegroundColor Magenta
