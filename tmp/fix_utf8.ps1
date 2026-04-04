$files = @(
    "d:\Antigravity\DandeliSite\family-packages.html",
    "d:\Antigravity\DandeliSite\couple-packages.html",
    "d:\Antigravity\DandeliSite\student-packages.html"
)

# the corrupted sequences that PowerShell sees when reading the ANSI string:
# Wait, let's just use regex to replace the entire button line!
# This is completely immune to encoding mismatches in the match string.

$btnRegex1 = '(?i)<button class="rcard-heart" onclick="event\.preventDefault\(\); this\.classList\.toggle\(''liked''\); this\.textContent = this\.classList\.contains\(''liked''\) \? ''.*?'' : ''.*?''">.*?</button>'
$newBtn1 = "<button class=`"rcard-heart`" onclick=`"event.preventDefault(); this.classList.toggle('liked'); this.textContent = this.classList.contains('liked') ? '$([char]::ConvertFromUtf32(0x2764))' : '$([char]::ConvertFromUtf32(0x1F90D))'`">$([char]::ConvertFromUtf32(0x1F90D))</button>"

$btnRegex2 = '(?i)<button class="heart" onclick="event\.preventDefault\(\); this\.classList\.toggle\(''liked''\); this\.textContent = this\.classList\.contains\(''liked''\) \? ''.*?'' : ''.*?''">.*?</button>'
$newBtn2 = "<button class=`"heart`" onclick=`"event.preventDefault(); this.classList.toggle('liked'); this.textContent = this.classList.contains('liked') ? '$([char]::ConvertFromUtf32(0x2764))' : '$([char]::ConvertFromUtf32(0x1F90D))'`">$([char]::ConvertFromUtf32(0x1F90D))</button>"

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $content = [regex]::Replace($content, $btnRegex1, $newBtn1)
        $content = [regex]::Replace($content, $btnRegex2, $newBtn2)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed emojis in $file"
    }
}
