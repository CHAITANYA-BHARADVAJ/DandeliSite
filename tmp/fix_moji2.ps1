$jsonText = [IO.File]::ReadAllText("d:\Antigravity\DandeliSite\tmp\replacements_new.json", [System.Text.Encoding]::UTF8)
$map = ConvertFrom-Json $jsonText
$file = "d:\Antigravity\DandeliSite\family-packages.html"

if (Test-Path $file) {
    $text = [IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    foreach ($prop in $map.PsObject.Properties) {
        $text = $text.Replace($prop.Name, $prop.Value)
    }
    $utf8bom = New-Object System.Text.UTF8Encoding $true
    [IO.File]::WriteAllText($file, $text, $utf8bom)
    Write-Host "Done replacements for family-packages.html!"
}
