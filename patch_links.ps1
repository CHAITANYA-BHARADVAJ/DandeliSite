$files = @(
    "D:\Antigravity\DandeliSite\couple-packages.html",
    "D:\Antigravity\DandeliSite\family-packages.html"
)

$links = [ordered]@{
    "Whistling Woodz Resort" = "whistling_woods_resort.html"
    "Hornbill River Resort" = "hornbill_resort.html"
    "Laguna River Resort" = "laguna_resort.html"
    "River Edge Resort" = "River Edge.html"
    "Tusker Trails" = "Tusker Trails.html"
    "Dew Drops Resort" = "dewDrops_resort.html"
    "Wild Wings Resort" = "Wild Wings.html"
    "White Petal Homestays" = "White Petal.html"
    "Wild Mist Resort" = "Wild Mist.html"
    "Rain Forest Dandeli" = "rainForest_resort.html"
}

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        foreach ($name in $links.Keys) {
            $link = $links[$name]
            
            # Title replaces
            $t1 = '<div class="rcard-name">' + $name + '</div>'
            $r1 = '<div class="rcard-name"><a href="' + $link + '" style="color:inherit;text-decoration:none;">' + $name + '</a></div>'
            $content = $content.Replace($t1, $r1)
            
            # Image wrap replaces
            # Easiest way in string replace without regex for the whole block:
            
            # 1. Start tag change: 
            # We look for <div class="rcard-img">\s*<img src="..." alt="$name">
            $pattern1 = '(?s)<div class="rcard-img">(\s*<img src="[^"]+" alt="' + [regex]::Escape($name) + '">.*?)</div>\s*<div class="rcard-info">'
            
            # We replace `<div class="rcard-img">` with `<a href="$link" ...>` and `</div>` with `</a>`
            $replacement1 = '<a href="' + $link + '" class="rcard-img" style="display:block; text-decoration:none;">$1</a>' + "`r`n" + '        <div class="rcard-info">'
            
            $content = [regex]::Replace($content, $pattern1, $replacement1)
            
            # Also prevent the heart button from triggering navigation
            $h1 = '<button class="rcard-heart" onclick="toggleHeart(this)">'
            $hr1 = '<button class="rcard-heart" onclick="event.preventDefault(); toggleHeart(this)">'
            $content = $content.Replace($h1, $hr1)
        }
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Patched $file"
    }
}
