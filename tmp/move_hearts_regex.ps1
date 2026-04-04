$files = @(
    "d:\Antigravity\DandeliSite\family-packages.html",
    "d:\Antigravity\DandeliSite\couple-packages.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $regex = '(?i)([ \t]*)(<div class="rcard-thumbs">[\s\S]*?</(?:a|div)>)(\s*<div class="rcard-info">[\s\S]*?)(<button class="rcard-heart"[^>]*>[\s\S]*?</button>)'
        
        $matches = [regex]::Matches($content, $regex)
        Write-Host "$file found matches: $($matches.Count)"
        
        $newContent = [regex]::Replace($content, $regex, '${1}${4}' + "`n" + '${1}${2}${3}')
        Set-Content -Path $file -Value $newContent -NoNewline
    }
}

$file = "d:\Antigravity\DandeliSite\student-packages.html"
if (Test-Path $file) {
    $content = Get-Content $file -Raw
    $regex = '(?i)([ \t]*)(<div class="thumbs">[\s\S]*?</(?:a|div)>)(\s*<div class="card-info">[\s\S]*?)(<button class="heart"[^>]*>[\s\S]*?</button>)'
    
    $matches = [regex]::Matches($content, $regex)
    Write-Host "$file found matches: $($matches.Count)"
    
    $newContent = [regex]::Replace($content, $regex, '${1}${4}' + "`n" + '${1}${2}${3}')
    Set-Content -Path $file -Value $newContent -NoNewline
}
