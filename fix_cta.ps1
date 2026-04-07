$dir = "d:\Antigravity\DandeliSite"
$files = Get-ChildItem -Path $dir -Filter "*.html"
foreach ($f in $files) {
    if ($f.Name -match "index.html") { continue }
    $content = [System.IO.File]::ReadAllText($f.FullName)
    
    $modified = $false

    if ($content -match "\.cta-strip::before\s*\{[^}]*position:\s*absolute;") {
        $content = $content -replace "(\.cta-strip::before\s*\{[^}]*position:\s*absolute;)", "`$1`n      pointer-events: none;"
        $modified = $true
    }

    if ($content -match "\.cta-strip::after\s*\{[^}]*position:\s*absolute;") {
        $content = $content -replace "(\.cta-strip::after\s*\{[^}]*position:\s*absolute;)", "`$1`n      pointer-events: none;"
        $modified = $true
    }

    if ($modified) {
        # deduplicate in case we run it twice
        $content = $content -replace "pointer-events: none;\s*pointer-events: none;", "pointer-events: none;"
        [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($f.Name)"
    }
}
