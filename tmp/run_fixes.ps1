$jsonPath = "d:\Antigravity\DandeliSite\tmp\replacements.json"
$files = Get-ChildItem -Path "d:\Antigravity\DandeliSite" -Filter "*.html" -File

# Read UTF-8 safely
$jsonText = [System.IO.File]::ReadAllText($jsonPath, [System.Text.Encoding]::UTF8)
$map = $jsonText | ConvertFrom-Json

$count = 0
foreach ($f in $files) {
    if ($f.Name -Like "tmp*") { continue }
    
    $text = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $orig = $text

    foreach ($prop in $map.psobject.properties) {
        $bad = $prop.Name
        $good = $prop.Value
        if ($text.Contains($bad)) {
            $text = $text.Replace($bad, $good)
        }
    }

    if ($orig -ne $text) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($f.FullName, $text, $utf8NoBom)
        Write-Host "FIXED: $($f.Name)" -ForegroundColor Green
        $count++
    }
}
Write-Host "Total files fixed: $count" -ForegroundColor Magenta
