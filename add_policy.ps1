$policyStr = 'policies: [
        { icon: "&#128176;", title: "Booking Confirmation", items: ["25% Advance of total pax charged for confirmation", "Traveling charges not included"] },'

$dir = "d:\Antigravity\DandeliSite"
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content.Contains("policies: [") -and -not $content.Contains("Booking Confirmation")) {
        $newContent = $content -replace "policies:\s*\[", $policyStr
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.Name)"
    }
}
