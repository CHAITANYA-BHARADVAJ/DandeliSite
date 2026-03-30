Add-Type -AssemblyName System.Drawing

# Start fresh from the original uploaded logo
$origPath = "C:\Users\DELL\.gemini\antigravity\brain\9bed26bd-3c2c-4d69-b9a8-03c77b80e469\media__1774813623985.jpg"
$outputPath = "D:\Antigravity\DandeliSite\images\logo_clean.png"
$finalPath = "D:\Antigravity\DandeliSite\images\logo.png"

# Load the original JPG
$bmp = New-Object System.Drawing.Bitmap($origPath)
Write-Host "Loaded image: $($bmp.Width) x $($bmp.Height)"

# Create a new bitmap with alpha
$newBmp = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($newBmp)
$g.DrawImage($bmp, 0, 0)
$g.Dispose()
$bmp.Dispose()

# Step 1: Sample background color from corners
$corners = @(
    $newBmp.GetPixel(5, 5),
    $newBmp.GetPixel($newBmp.Width - 6, 5),
    $newBmp.GetPixel(5, $newBmp.Height - 6),
    $newBmp.GetPixel($newBmp.Width - 6, $newBmp.Height - 6)
)
$avgR = [int](($corners[0].R + $corners[1].R + $corners[2].R + $corners[3].R) / 4)
$avgG = [int](($corners[0].G + $corners[1].G + $corners[2].G + $corners[3].G) / 4)
$avgB = [int](($corners[0].B + $corners[1].B + $corners[2].B + $corners[3].B) / 4)
Write-Host "Background color sampled from corners: R=$avgR G=$avgG B=$avgB"

# Step 2: Flood fill from all four corners to remove background
# Using a tolerance-based approach
$tolerance = 45  # Color distance tolerance
$visited = New-Object 'bool[,]' $newBmp.Width, $newBmp.Height
$queue = New-Object System.Collections.Generic.Queue[System.Drawing.Point]

# Seed points - corners and edges
$seeds = @()
# All four corners
$seeds += [System.Drawing.Point]::new(0, 0)
$seeds += [System.Drawing.Point]::new($newBmp.Width - 1, 0)
$seeds += [System.Drawing.Point]::new(0, $newBmp.Height - 1)
$seeds += [System.Drawing.Point]::new($newBmp.Width - 1, $newBmp.Height - 1)

# Edge midpoints
$seeds += [System.Drawing.Point]::new([int]($newBmp.Width / 2), 0)
$seeds += [System.Drawing.Point]::new([int]($newBmp.Width / 2), $newBmp.Height - 1)
$seeds += [System.Drawing.Point]::new(0, [int]($newBmp.Height / 2))
$seeds += [System.Drawing.Point]::new($newBmp.Width - 1, [int]($newBmp.Height / 2))

foreach ($seed in $seeds) {
    if (-not $visited[$seed.X, $seed.Y]) {
        $queue.Enqueue($seed)
    }
}

$removedCount = 0
while ($queue.Count -gt 0) {
    $pt = $queue.Dequeue()
    $x = $pt.X
    $y = $pt.Y
    
    if ($x -lt 0 -or $x -ge $newBmp.Width -or $y -lt 0 -or $y -ge $newBmp.Height) { continue }
    if ($visited[$x, $y]) { continue }
    $visited[$x, $y] = $true
    
    $pixel = $newBmp.GetPixel($x, $y)
    
    # Check color distance from background
    $dr = [Math]::Abs([int]$pixel.R - $avgR)
    $dg = [Math]::Abs([int]$pixel.G - $avgG)
    $db = [Math]::Abs([int]$pixel.B - $avgB)
    $dist = [Math]::Sqrt($dr * $dr + $dg * $dg + $db * $db)
    
    if ($dist -lt $tolerance) {
        $newBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        $removedCount++
        
        # Add neighbors
        $queue.Enqueue([System.Drawing.Point]::new($x + 1, $y))
        $queue.Enqueue([System.Drawing.Point]::new($x - 1, $y))
        $queue.Enqueue([System.Drawing.Point]::new($x, $y + 1))
        $queue.Enqueue([System.Drawing.Point]::new($x, $y - 1))
    }
}

Write-Host "Flood fill removed $removedCount pixels"

# Step 3: Edge anti-aliasing - make edge pixels semi-transparent
$edgeCount = 0
for ($x = 1; $x -lt ($newBmp.Width - 1); $x++) {
    for ($y = 1; $y -lt ($newBmp.Height - 1); $y++) {
        $pixel = $newBmp.GetPixel($x, $y)
        if ($pixel.A -eq 0) { continue }
        
        # Count transparent neighbors
        $tn = 0
        if ($newBmp.GetPixel($x-1, $y).A -eq 0) { $tn++ }
        if ($newBmp.GetPixel($x+1, $y).A -eq 0) { $tn++ }
        if ($newBmp.GetPixel($x, $y-1).A -eq 0) { $tn++ }
        if ($newBmp.GetPixel($x, $y+1).A -eq 0) { $tn++ }
        
        if ($tn -ge 2) {
            # This pixel is on the edge, make semi-transparent
            $newAlpha = [int](255 * (1 - $tn / 5.0))
            $newBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newAlpha, $pixel.R, $pixel.G, $pixel.B))
            $edgeCount++
        }
    }
}
Write-Host "Anti-aliased $edgeCount edge pixels"

# Save
$newBmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$newBmp.Dispose()

# Copy to final
Copy-Item $outputPath $finalPath -Force
Remove-Item $outputPath -ErrorAction SilentlyContinue
Write-Host "Done! Transparent logo saved to $finalPath"
