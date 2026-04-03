# Fix mojibake by reading actual broken strings from files
# and using simple string replacements

$basePath = "d:\Antigravity\DandeliSite"
$files = Get-ChildItem -Path $basePath -Filter "*.html" -File
$totalFixed = 0

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $modified = $false

    # Pattern 1: â€" (em dash) = bytes C3 A2 E2 82 AC E2 80 9C -> E2 80 94
    # Actually the mojibake "â€"" in UTF-8 is: C3 A2 C2 80 C2 94 
    # But it could also be the literal UTF-8 bytes for the characters â (C3 A2), € (E2 82 AC), " (E2 80 9C)
    # Let's try finding and replacing at byte level
    
    # Simply read as string and replace text patterns
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    $orig = $text

    # The key mojibake sequences (as they appear in the files):
    # â€" -> — (em dash)
    # â€" is actually 3 Unicode code points: â (U+00E2), € (U+20AC), " (U+201C)
    $emDashBroken = [string]([char]0x00E2) + [string]([char]0x20AC) + [string]([char]0x201C)
    $text = $text.Replace($emDashBroken, [string]([char]0x2014))

    # â"€ -> ─ (box draw)  
    # â (U+00E2), " (U+201C), € (U+20AC)
    $boxBroken = [string]([char]0x00E2) + [string]([char]0x201C) + [string]([char]0x20AC)
    $text = $text.Replace($boxBroken, [string]([char]0x2500))

    # â€" -> — variant check: â (U+00E2), € (U+20AC), " (U+201D)  
    $emDash2 = [string]([char]0x00E2) + [string]([char]0x20AC) + [string]([char]0x201D)
    $text = $text.Replace($emDash2, [string]([char]0x2014))

    # â€" as â + \u0080 + \u0094 (control chars from latin1 interpretation)
    $emDash3 = [string]([char]0x00E2) + [string]([char]0x0080) + [string]([char]0x0094)
    $text = $text.Replace($emDash3, [string]([char]0x2014))

    # â€º -> › : â (U+00E2) + € (U+20AC) + º (U+00BA)
    $chevronBroken = [string]([char]0x00E2) + [string]([char]0x20AC) + [string]([char]0x00BA)
    $text = $text.Replace($chevronBroken, [string]([char]0x203A))

    # â–¼ -> ▼ : â (U+00E2) + – (U+0096) + ¼ (U+00BC)
    $triBroken = [string]([char]0x00E2) + [string]([char]0x0096) + [string]([char]0x00BC)
    $text = $text.Replace($triBroken, [string]([char]0x25BC))

    # Ã¢â€â‚¬ -> ─ (double-encoded box-drawing)
    $doubleBroken = [string]([char]0x00C3) + [string]([char]0x00A2) + [string]([char]0x20AC) + [string]([char]0x201C) + [string]([char]0x20AC)
    $text = $text.Replace($doubleBroken, [string]([char]0x2500))

    # Another variant: Ã¢â€â‚¬ = Ã (U+00C3) + ¢ (U+00A2) + € variants
    $dbl2 = [string]([char]0x00C3) + [string]([char]0x00A2) + [string]([char]0x20AC) + [string]([char]0x201C) + [string]([char]0x20AC)
    $text = $text.Replace($dbl2, [string]([char]0x2500))

    if ($text -ne $orig) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBom)
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
        $totalFixed++
    } else {
        Write-Host "CLEAN: $($file.Name)" -ForegroundColor DarkGray
    }
}

Write-Host "`nFiles modified: $totalFixed" -ForegroundColor Magenta
