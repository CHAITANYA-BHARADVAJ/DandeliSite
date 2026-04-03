# Fix broken JS template literals in resort pages
# The backticks were stripped from template literal strings, causing JS to crash

$files = @(
    "white_water_resort.html",
    "whistling_woods_resort.html",
    "Wild Wings.html",
    "Tusker Trails.html",
    "River Edge.html",
    "tarang_homestay.html",
    "sunbird_resort.html",
    "rainForest_resort.html",
    "palm_meadows_resort.html",
    "laguna_resort.html",
    "hornbill_resort.html",
    "dewDrops_resort.html"
)

$basePath = "d:\Antigravity\DandeliSite"

foreach ($file in $files) {
    $filePath = Join-Path $basePath $file
    if (-not (Test-Path $filePath)) {
        Write-Host "SKIPPED: $file (not found)" -ForegroundColor Yellow
        continue
    }
    
    $content = Get-Content $filePath -Raw
    $original = $content
    
    # Fix 1: Amenities list rendering - restore backticks around the HTML template
    # BROKEN:  <div class="am-item"><span class="am-name"> + a.text + </span><span class="am-check"></span></div>;
    # FIXED:   `<div class="am-item"><span class="am-name">${a.text}</span><span class="am-check"></span></div>`;
    $content = $content -replace [regex]::Escape('<div class="am-item"><span class="am-name"> + a.text + </span><span class="am-check"></span></div>;'), '`<div class="am-item"><span class="am-name">${a.text}</span><span class="am-check"></span></div>`;'
    
    # Fix 2: Grouped activities accordion open
    # BROKEN:  gaHtml += <details class="am-details"><summary class="am-summary"> + group.name + </summary><div class="am-content">;
    # FIXED:   gaHtml += `<details class="am-details"><summary class="am-summary">${group.name}</summary><div class="am-content">`;
    $content = $content -replace [regex]::Escape('gaHtml += <details class="am-details"><summary class="am-summary"> + group.name + </summary><div class="am-content">;'), 'gaHtml += `<details class="am-details"><summary class="am-summary">${group.name}</summary><div class="am-content">`;'
    
    # Fix 3: Grouped activity item
    # BROKEN:  gaHtml += <div class="am-item"><span class="am-name"> + item + </span><span class="am-check" ></span></div>;
    # FIXED:   gaHtml += `<div class="am-item"><span class="am-name">${item}</span><span class="am-check"></span></div>`;
    $content = $content -replace [regex]::Escape('gaHtml += <div class="am-item"><span class="am-name"> + item + </span><span class="am-check" ></span></div>;'), 'gaHtml += `<div class="am-item"><span class="am-name">${item}</span><span class="am-check"></span></div>`;'
    
    # Fix 4: Accordion close
    # BROKEN:  gaHtml += </div></details>;
    # FIXED:   gaHtml += `</div></details>`;
    $content = $content -replace [regex]::Escape('gaHtml += </div></details>;'), 'gaHtml += `</div></details>`;'
    
    if ($content -ne $original) {
        Set-Content -Path $filePath -Value $content -NoNewline
        Write-Host "FIXED: $file" -ForegroundColor Green
    } else {
        Write-Host "NO CHANGES: $file (patterns not found or already fixed)" -ForegroundColor Cyan
    }
}

Write-Host "`nDone! All files processed." -ForegroundColor Magenta
