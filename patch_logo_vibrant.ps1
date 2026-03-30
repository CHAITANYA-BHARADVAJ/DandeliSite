# Update logo CSS for larger size and more vibrant appearance

# GROUP 1: Files with CSS classes
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

# Old CSS
$oldNavCss = '.logo-img{height:44px;width:44px;object-fit:contain;flex-shrink:0;filter:drop-shadow(0 1px 3px rgba(0,0,0,.15));transition:transform .3s ease;}.logo:hover .logo-img,.logo-img:hover{transform:scale(1.08);}'
# New CSS - bigger (52px), more vibrant (saturate + contrast), stronger shadow
$newNavCss = '.logo-img{height:52px;width:52px;object-fit:contain;flex-shrink:0;filter:drop-shadow(0 2px 4px rgba(0,0,0,.2)) saturate(1.3) contrast(1.05);transition:transform .3s ease,filter .3s ease;}.logo:hover .logo-img,.logo-img:hover{transform:scale(1.1);filter:drop-shadow(0 3px 8px rgba(201,168,76,.4)) saturate(1.5) contrast(1.1);}'

$oldFootCss = '.footer-logo-img{height:48px;width:48px;object-fit:contain;vertical-align:middle;margin-right:10px;filter:drop-shadow(0 2px 6px rgba(201,168,76,.35));}'
# New footer CSS - bigger (56px), vibrant, glowing gold shadow
$newFootCss = '.footer-logo-img{height:56px;width:56px;object-fit:contain;vertical-align:middle;margin-right:12px;filter:drop-shadow(0 2px 8px rgba(201,168,76,.5)) saturate(1.3) brightness(1.1);}'

foreach ($file in $filesWithCss) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $content = $content.Replace($oldNavCss, $newNavCss)
        $content = $content.Replace($oldFootCss, $newFootCss)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "CSS updated: $([System.IO.Path]::GetFileName($file))"
    }
}

# GROUP 2: Files with inline styles
$inlineFiles = @(
    "D:\Antigravity\DandeliSite\student-packages.html",
    "D:\Antigravity\DandeliSite\couple-packages.html",
    "D:\Antigravity\DandeliSite\family-packages.html",
    "D:\Antigravity\DandeliSite\resort-listing.html"
)

$oldInline = 'style="height:40px;width:40px;object-fit:contain;vertical-align:middle;margin-right:8px;filter:drop-shadow(0 1px 3px rgba(0,0,0,.15));"'
$newInline = 'style="height:48px;width:48px;object-fit:contain;vertical-align:middle;margin-right:8px;filter:drop-shadow(0 2px 4px rgba(0,0,0,.2)) saturate(1.3) contrast(1.05);"'

foreach ($file in $inlineFiles) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $content = $content.Replace($oldInline, $newInline)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Inline updated: $([System.IO.Path]::GetFileName($file))"
    }
}

Write-Host "`nDone! Logo is now larger and more vibrant across all pages."
