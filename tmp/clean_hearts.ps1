$familyAndCouple = @(
    "d:\Antigravity\DandeliSite\family-packages.html",
    "d:\Antigravity\DandeliSite\couple-packages.html"
)

foreach ($file in $familyAndCouple) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # 1. Remove all existing heart buttons (case insensitive)
        $content = [regex]::Replace($content, '(?i)\s*<button class="rcard-heart"[^>]*>[\s\S]*?</button>', '')
        
        # 2. Insert standard heart button right before rcard-thumbs
        $newBtn = "            <button class=`"rcard-heart`" onclick=`"event.preventDefault(); this.classList.toggle('liked'); this.textContent = this.classList.contains('liked') ? '❤️' : '🤍'`">🤍</button>`n            "
        $content = [regex]::Replace($content, '(?i)(?=<div class="rcard-thumbs">)', $newBtn)
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed: $file"
    }
}

$studentFile = "d:\Antigravity\DandeliSite\student-packages.html"
if (Test-Path $studentFile) {
    $content = [System.IO.File]::ReadAllText($studentFile, [System.Text.Encoding]::UTF8)
    
    # 1. Remove all existing heart buttons
    $content = [regex]::Replace($content, '(?i)\s*<button class="heart"[^>]*>[\s\S]*?</button>', '')
    
    # 2. Insert standard heart button right before class="thumbs"
    $newBtn = "            <button class=`"heart`" onclick=`"event.preventDefault(); this.classList.toggle('liked'); this.textContent = this.classList.contains('liked') ? '❤️' : '🤍'`">🤍</button>`n            "
    $content = [regex]::Replace($content, '(?i)(?=<div class="thumbs">)', $newBtn)
    
    [System.IO.File]::WriteAllText($studentFile, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Fixed: $studentFile"
}
