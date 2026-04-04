$files = @(
    "d:\Antigravity\DandeliSite\family-packages.html",
    "d:\Antigravity\DandeliSite\couple-packages.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $regex = '(?i)([ \t]*)(<div class="rcard-thumbs">[\s\S]*?</(?:a|div)>)(\s*<div class="rcard-info">[\s\S]*?)(<button class="rcard-heart"[^>]*>[\s\S]*?</button>)'
        
        $matches = [regex]::Matches($content, $regex)
        Write-Host "$file found matches: $($matches.Count)"
        
        $newContent = [regex]::Replace($content, $regex, '${1}${4}' + "`n" + '${1}${2}${3}')
        [System.IO.File]::WriteAllText($file, $newContent, [System.Text.Encoding]::UTF8)
    }
}

$file = "d:\Antigravity\DandeliSite\student-packages.html"
if (Test-Path $file) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    $regex = '(?i)([ \t]*)(<div class="thumbs">[\s\S]*?</(?:a|div)>)(\s*<div class="card-info">[\s\S]*?)(<button class="heart"[^>]*>[\s\S]*?</button>)'
    
    $matches = [regex]::Matches($content, $regex)
    Write-Host "$file found matches: $($matches.Count)"
    
    $newContent = [regex]::Replace($content, $regex, '${1}${4}' + "`n" + '${1}${2}${3}')
    [System.IO.File]::WriteAllText($file, $newContent, [System.Text.Encoding]::UTF8)
}
