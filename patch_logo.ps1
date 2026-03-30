# ── Embed logo across all HTML files ──
# Places: Navbar logo, Footer logo

# ═══════════════════════════════════════
# GROUP 1: Resort detail pages (same structure)
# These use: <a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>
# And footer: <div class="fl">&#127807; Book myDandeli</div>
# ═══════════════════════════════════════
$resortFiles = @(
    "D:\Antigravity\DandeliSite\whistling_woods_resort.html",
    "D:\Antigravity\DandeliSite\hornbill_resort.html",
    "D:\Antigravity\DandeliSite\laguna_resort.html",
    "D:\Antigravity\DandeliSite\dewDrops_resort.html",
    "D:\Antigravity\DandeliSite\Wild Wings.html",
    "D:\Antigravity\DandeliSite\Wild Mist.html",
    "D:\Antigravity\DandeliSite\White Petal.html",
    "D:\Antigravity\DandeliSite\Tusker Trails.html",
    "D:\Antigravity\DandeliSite\River Edge.html",
    "D:\Antigravity\DandeliSite\rainForest_resort.html"
)

foreach ($file in $resortFiles) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # NAV LOGO: Replace <a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>
        $oldNav = '<a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>'
        $newNav = '<a href="index.html" class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"> Book myDandeli</a>'
        $content = $content.Replace($oldNav, $newNav)
        
        # FOOTER LOGO: Replace <div class="fl">&#127807; Book myDandeli</div>
        $oldFoot = '<div class="fl">&#127807; Book myDandeli</div>'
        $newFoot = '<div class="fl"><img src="images/logo.png" alt="Book myDandeli" class="footer-logo-img"> Book myDandeli</div>'
        $content = $content.Replace($oldFoot, $newFoot)
        
        # Add CSS for the logo image if not already present
        # Insert just before the </style> closing tag
        $logoCss = @"

/* ── LOGO IMAGE ── */
.logo-img{height:40px;width:40px;object-fit:contain;border-radius:50%;flex-shrink:0;}
.footer-logo-img{height:44px;width:44px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:8px;}
"@
        if (-not $content.Contains('.logo-img{')) {
            $content = $content.Replace('</style>', $logoCss + "`r`n</style>")
        }
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Patched (resort): $([System.IO.Path]::GetFileName($file))"
    }
}

# ═══════════════════════════════════════
# GROUP 2: Index page
# Uses: <div class="logo"><span class="leaf">&#127807;</span><span>Book myDandeli</span></div>
# Footer: <div class="fl">&#127807; Book myDandeli</div>
# ═══════════════════════════════════════
$indexFile = "D:\Antigravity\DandeliSite\index.html"
if (Test-Path $indexFile) {
    $content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)
    
    $oldNav = '<div class="logo"><span class="leaf">&#127807;</span><span>Book myDandeli</span></div>'
    $newNav = '<div class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"><span>Book myDandeli</span></div>'
    $content = $content.Replace($oldNav, $newNav)
    
    $oldFoot = '<div class="fl">&#127807; Book myDandeli</div>'
    $newFoot = '<div class="fl"><img src="images/logo.png" alt="Book myDandeli" class="footer-logo-img"> Book myDandeli</div>'
    $content = $content.Replace($oldFoot, $newFoot)
    
    $logoCss = @"

/* ── LOGO IMAGE ── */
.logo-img{height:40px;width:40px;object-fit:contain;border-radius:50%;flex-shrink:0;}
.footer-logo-img{height:44px;width:44px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:8px;}
"@
    if (-not $content.Contains('.logo-img{')) {
        $content = $content.Replace('</style>', $logoCss + "`r`n</style>")
    }
    
    [System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Patched (index): index.html"
}

# ═══════════════════════════════════════
# GROUP 3: Things-to-do page
# Uses: <a class="logo" href="index.html"><span class="leaf">&#127807;</span><span> Book myDandeli</span></a>
# ═══════════════════════════════════════
$ttdFile = "D:\Antigravity\DandeliSite\things-to-do.html"
if (Test-Path $ttdFile) {
    $content = [System.IO.File]::ReadAllText($ttdFile, [System.Text.Encoding]::UTF8)
    
    $oldNav = '<a class="logo" href="index.html"><span class="leaf">&#127807;</span><span> Book myDandeli</span></a>'
    $newNav = '<a class="logo" href="index.html"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"><span> Book myDandeli</span></a>'
    $content = $content.Replace($oldNav, $newNav)
    
    $oldFoot = '<div class="fl">&#127807; Book myDandeli</div>'
    $newFoot = '<div class="fl"><img src="images/logo.png" alt="Book myDandeli" class="footer-logo-img"> Book myDandeli</div>'
    $content = $content.Replace($oldFoot, $newFoot)
    
    $logoCss = @"

/* ── LOGO IMAGE ── */
.logo-img{height:40px;width:40px;object-fit:contain;border-radius:50%;flex-shrink:0;}
.footer-logo-img{height:44px;width:44px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:8px;}
"@
    if (-not $content.Contains('.logo-img{')) {
        $content = $content.Replace('</style>', $logoCss + "`r`n</style>")
    }
    
    [System.IO.File]::WriteAllText($ttdFile, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Patched (ttd): things-to-do.html"
}

# ═══════════════════════════════════════
# GROUP 4: Dandeli sightseeing page
# Uses: <a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>
# ═══════════════════════════════════════
$ssFile = "D:\Antigravity\DandeliSite\dandeli-sightseeing.html"
if (Test-Path $ssFile) {
    $content = [System.IO.File]::ReadAllText($ssFile, [System.Text.Encoding]::UTF8)
    
    $oldNav = '<a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>'
    $newNav = '<a href="index.html" class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"> Book myDandeli</a>'
    $content = $content.Replace($oldNav, $newNav)
    
    $oldFoot = '<div class="fl">&#127807; Book myDandeli</div>'
    $newFoot = '<div class="fl"><img src="images/logo.png" alt="Book myDandeli" class="footer-logo-img"> Book myDandeli</div>'
    $content = $content.Replace($oldFoot, $newFoot)
    
    $logoCss = @"

/* ── LOGO IMAGE ── */
.logo-img{height:40px;width:40px;object-fit:contain;border-radius:50%;flex-shrink:0;}
.footer-logo-img{height:44px;width:44px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:8px;}
"@
    if (-not $content.Contains('.logo-img{')) {
        $content = $content.Replace('</style>', $logoCss + "`r`n</style>")
    }
    
    [System.IO.File]::WriteAllText($ssFile, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Patched (ss): dandeli-sightseeing.html"
}

# ═══════════════════════════════════════
# GROUP 5: Package pages + resort-listing
# These use: <a href="index.html" class="nav-logo">🌿 Book myDandeli</a>
# Or: <a href="index.html" class="rl-logo">🌿 Book myDandeli</a>
# ═══════════════════════════════════════
$pkgFiles = @(
    "D:\Antigravity\DandeliSite\student-packages.html",
    "D:\Antigravity\DandeliSite\couple-packages.html",
    "D:\Antigravity\DandeliSite\family-packages.html"
)

foreach ($file in $pkgFiles) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # NAV: Replace emoji text with image
        $content = $content.Replace(
            '<a href="index.html" class="nav-logo">🌿 Book myDandeli</a>',
            '<a href="index.html" class="nav-logo"><img src="images/logo.png" alt="Book myDandeli" style="height:36px;width:36px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:6px;"> Book myDandeli</a>'
        )
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Patched (package): $([System.IO.Path]::GetFileName($file))"
    }
}

# Resort listing
$rlFile = "D:\Antigravity\DandeliSite\resort-listing.html"
if (Test-Path $rlFile) {
    $content = [System.IO.File]::ReadAllText($rlFile, [System.Text.Encoding]::UTF8)
    
    $content = $content.Replace(
        '<a href="index.html" class="rl-logo">🌿 Book myDandeli</a>',
        '<a href="index.html" class="rl-logo"><img src="images/logo.png" alt="Book myDandeli" style="height:36px;width:36px;object-fit:contain;border-radius:50%;vertical-align:middle;margin-right:6px;"> Book myDandeli</a>'
    )
    
    [System.IO.File]::WriteAllText($rlFile, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Patched (listing): resort-listing.html"
}

Write-Host "`nDone embedding logo across all HTML files!"
