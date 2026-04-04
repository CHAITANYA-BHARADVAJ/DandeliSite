# ============================================================
# STEP 1: Remove "Free Cancellation" from ALL HTML files
# ============================================================
$htmlFiles = Get-ChildItem -Path "d:\Antigravity\DandeliSite\*.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $original = $content

    # Pattern 1: <span class="rtag">✓ Free Cancellation</span> (as a standalone tag)
    $content = $content -replace '<span class="rtag">✓ Free Cancellation</span>', ''
    
    # Pattern 2: <span class="card-usp">✓ Free Cancellation</span> (student packages style)
    $content = $content -replace '<span class="card-usp">✓ Free\s*\r?\n\s*Cancellation</span>', ''
    
    # Pattern 3: · <span>Free cancellation</span> in price-tax divs
    $content = $content -replace ' · <span>Free cancellation</span>', ''
    $content = $content -replace ' · <span>Free Cancellation</span>', ''
    
    # Pattern 4: Free cancellation as plain text in tags
    $content = $content -replace '<span class="rtag">Free Cancellation</span>', ''
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        Write-Host "Cleaned: $($file.Name)"
    }
}

Write-Host "`n=== Free Cancellation cleanup complete ==="

# Verify
$remaining = Select-String -Pattern "Free Cancellation|Free cancellation|free cancellation" -Path "d:\Antigravity\DandeliSite\*.html"
if ($remaining) {
    Write-Host "`nWARNING: Remaining matches:"
    $remaining | ForEach-Object { Write-Host "  $($_.Filename):$($_.LineNumber) => $($_.Line.Trim().Substring(0, [Math]::Min(80, $_.Line.Trim().Length)))" }
} else {
    Write-Host "All Free Cancellation references removed successfully!"
}
