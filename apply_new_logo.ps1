$mediaPath = "C:\Users\DELL\.gemini\antigravity\brain\b6b1b0f2-e02d-43b8-96da-fc262c3d5b3b\media__1774851592734.png"
$destLogoPath = "D:\Antigravity\DandeliSite\images\logo.png"

# 1) Load and Crop the image
Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap($mediaPath)

# Bounding Box from previous test: X=301..725, Y=68..495 => W=425, H=428
# We'll crop a square of size 428x428 centered
$cropSize = 428
$destRect = New-Object System.Drawing.Rectangle(0, 0, $cropSize, $cropSize)
$cropBmp = New-Object System.Drawing.Bitmap($cropSize, $cropSize)

# We find the center of the bounding box
$centerX = [int](301 + (725 - 301) / 2)
$centerY = [int](68 + (495 - 68) / 2)

$srcRect = New-Object System.Drawing.Rectangle([int]($centerX - $cropSize/2), [int]($centerY - $cropSize/2), $cropSize, $cropSize)

$g = [System.Drawing.Graphics]::FromImage($cropBmp)
$g.DrawImage($bmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$bmp.Dispose()

# Save the cropped logo
$cropBmp.Save($destLogoPath, [System.Drawing.Imaging.ImageFormat]::Png)
Copy-Item $destLogoPath "D:\Antigravity\DandeliSite\images\logo_transparent.png" -Force
$cropBmp.Dispose()

Write-Host "New logo saved and cropped!"

# 2) Remove redundant "Book myDandeli" text from all HTML files
$files = Get-ChildItem "D:\Antigravity\DandeliSite" -Filter "*.html" | Select-Object -ExpandProperty FullName

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

    # A) Remove text next to CSS-class logos
    $content = $content.Replace('class="logo-img"> Book myDandeli</a>', 'class="logo-img"></a>')
    $content = $content.Replace('class="logo-img"><span>Book myDandeli</span></div>', 'class="logo-img"></div>')
    $content = $content.Replace('class="logo-img"><span> Book myDandeli</span></a>', 'class="logo-img"></a>')
    
    # B) Remove text next to Footer logos
    $content = $content.Replace('class="footer-logo-img"> Book myDandeli</div>', 'class="footer-logo-img"></div>')

    # C) Remove text next to Inline-style logos
    $content = $content.Replace('contrast(1.05);"> Book myDandeli</a>', 'contrast(1.05);"></a>')
    $content = $content.Replace('margin-right:8px;"> Book myDandeli</a>', 'margin-right:8px;"></a>')

    # 3) Scale up logo sizes to make the inner text readable
    # Navbar sizes: 52px -> 64px, Inline sizes: 48px -> 64px, footer sizes: 56px -> 72px
    $content = $content.Replace('height:52px;width:52px;', 'height:64px;width:64px;')
    $content = $content.Replace('height:56px;width:56px;', 'height:72px;width:72px;')
    $content = $content.Replace('height:48px;width:48px;', 'height:64px;width:64px;')

    [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
}

Write-Host "Replaced all text and increased logo size across all HTML files!"
