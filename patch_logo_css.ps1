# Update the logo CSS for enhanced visibility across all files
# The logo image is now transparent, so we remove border-radius clipping,
# add drop-shadow for visibility, and increase size slightly.

# ═══════════════════════════════════════
# GROUP 1: Resort pages + index + things-to-do + sightseeing
# These have the CSS class injected: .logo-img and .footer-logo-img
# ═══════════════════════════════════════
$filesWithCss = @(
    "D:\Antigravity\DandeliSite\whistling_woods_resort.html",
    "D:\Antigravity\DandeliSite\hornbill_resort.html",
    "D:\Antigravity\DandeliSite\laguna_resort.html",
    "D:\Antigravity\DandeliSite\dewDrops_resort.html",
    "D:\Antigravity\DandeliSite\Wild Wings.html",
    "D:\Antigravity\DandeliSite\Wild Mist.html",
    "D:\Antigravity\DandeliSite\White Petal.html",
    "D:\Antigravity\DandeliSite\Tusker Trails.html",
    "D:\Antigravity\DandeliSite\River Edge.html",
    "D:\Antigravity\DandeliSite\rainForest_resort.html",
    "D:\Antigravity\DandeliSite\index.html",
    "D:\Antigravity\DandeliSite\things-to-do.html",
    "D:\Antigravity\DandeliSite\dandeli-sightseeing.html"
)

$oldNavCss = '.logo-img{height:40px;width:40px;object-fit:contain;border-radius:50%;flex-shrink:0;}'
$newNavCss = '.logo-img{height:44px;width:44px;object-fit:contain;flex-shrink:0;filter:drop-shadow(0 1px 3px rgba(0,0,0,.15));transition:transform .3s ease;}.logo:hover .logo-img,.logo-img:hover{transform:scale(1.08);}'

$oldFootCss = '.footer-logo-img{height:44px;width:44px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:8px;}'
$newFootCss = '.footer-logo-img{height:48px;width:48px;object-fit:contain;vertical-align:middle;margin-right:10px;filter:drop-shadow(0 2px 6px rgba(201,168,76,.35));}'

foreach ($file in $filesWithCss) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $content = $content.Replace($oldNavCss, $newNavCss)
        $content = $content.Replace($oldFootCss, $newFootCss)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated CSS: $([System.IO.Path]::GetFileName($file))"
    }
}

# ═══════════════════════════════════════
# GROUP 2: Package pages + resort-listing
# These use inline styles, update them
# ═══════════════════════════════════════
$inlineFiles = @(
    "D:\Antigravity\DandeliSite\student-packages.html",
    "D:\Antigravity\DandeliSite\couple-packages.html",
    "D:\Antigravity\DandeliSite\family-packages.html",
    "D:\Antigravity\DandeliSite\resort-listing.html"
)

$oldInline = 'style="height:36px;width:36px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:6px;"'
$newInline = 'style="height:40px;width:40px;object-fit:contain;vertical-align:middle;margin-right:8px;filter:drop-shadow(0 1px 3px rgba(0,0,0,.15));"'

foreach ($file in $inlineFiles) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $content = $content.Replace($oldInline, $newInline)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated inline: $([System.IO.Path]::GetFileName($file))"
    }
}

Write-Host "`nDone updating logo CSS for transparency and enhanced visibility!"
