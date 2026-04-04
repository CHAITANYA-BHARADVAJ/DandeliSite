# ============================================================
# STEP 2: Remove remaining "Free Cancellation" patterns
# ============================================================
$htmlFiles = Get-ChildItem -Path "d:\Antigravity\DandeliSite\*.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $original = $content

    # Pattern: trust-item containing Free Cancellation (full div)
    $content = $content -replace '<div class="trust-item"><div class="trust-dot"></div>Free Cancellation</div>', ''
    
    # Pattern: trust-dot followed by Free Cancellation (partial - within trust-item)
    $content = $content -replace '<div class="trust-dot"></div>Free Cancellation', ''
    
    # Pattern: rc-tag with Free Cancellation
    $content = $content -replace '<span class="rc-tag">✓ Free Cancellation</span>', ''
    
    # Pattern: pkg-hl-title
    $content = $content -replace '<div class="pkg-hl-title">Free Cancellation</div>', ''
    
    # Pattern: rtag with UTF-8 encoded checkmark
    $content = $content -replace '<span class="rtag">✓ Free Cancellation</span>', ''
    
    # Pattern: remaining price-tax patterns with various spacing
    $content = $content -replace ' [·] <span>Free cancellation</span>', ''
    $content = $content -replace ' · <span>Free cancellation</span>', ''
    
    # Catch-all for any stray "Free cancellation" in span tags
    $content = $content -replace '<span>Free cancellation</span>', ''
    $content = $content -replace '<span>Free Cancellation</span>', ''
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        Write-Host "Cleaned: $($file.Name)"
    }
}

Write-Host "`n=== Second pass complete ==="

# Verify
$remaining = Select-String -Pattern "Free Cancellation|Free cancellation" -Path "d:\Antigravity\DandeliSite\*.html"
if ($remaining) {
    Write-Host "`nRemaining matches:"
    $remaining | ForEach-Object { 
        $trimmed = $_.Line.Trim()
        if ($trimmed.Length -gt 100) { $trimmed = $trimmed.Substring(0, 100) }
        Write-Host "  $($_.Filename):$($_.LineNumber) => $trimmed" 
    }
} else {
    Write-Host "ALL Free Cancellation references removed!"
}
