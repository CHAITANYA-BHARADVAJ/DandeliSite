$files = @(
    "d:\Antigravity\DandeliSite\family-packages.html",
    "d:\Antigravity\DandeliSite\couple-packages.html",
    "d:\Antigravity\DandeliSite\student-packages.html"
)

foreach ($f in $files) {
    if (Test-Path $f) {
        $content = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
        $content = $content -replace 'â‚¹', '₹'
        [System.IO.File]::WriteAllText($f, $content, [System.Text.Encoding]::UTF8)
    }
}
Write-Host "Fixed rupee symbol!"
