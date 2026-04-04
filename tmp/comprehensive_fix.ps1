$ErrorActionPreference = 'Stop'
$files = @("d:\Antigravity\DandeliSite\student-packages.html", "d:\Antigravity\DandeliSite\couple-packages.html", "d:\Antigravity\DandeliSite\family-packages.html")

$pricing = @{
    "swayam_cottage.html" = 1699
    "laguna_resort.html" = 2500
    "hornbill_resort.html" = 3000
    "jungle_edge.html" = 1300
    "riverpoint_resort.html" = 1300
    "green_valley_resort.html" = 1300
    "River Edge.html" = 1300
    "dewDrops_resort.html" = 1800
    "rainForest_resort.html" = 1800
    "Wild Wings.html" = 1600
    "Tusker Trails.html" = 1600
    "tarang_homestay.html" = 1900
    "sunbird_resort.html" = 1900
    "Wild Mist.html" = 1300
    "bison_resort.html" = 2400
    "whistling_woods_resort.html" = 5999
    "white_water_resort.html" = 1800
    "palm_meadows_resort.html" = 2000
    "ansh_resort.html" = 2400
}

# 1. First, correct the missing thumbs in family and couple packages
$thumbsFixScript = {
    param($f)
    if ($f -match "student") { return }
    $c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    
    # Jungle Edge
    $c = $c -replace '(<a [^>]*href="jungle_edge\.html"[^>]*>.*?)</a>', '$1    <div class="rcard-thumbs">
              <div class="rthumb"><img alt="" src="" /></div>
              <div class="rthumb-more">+3</div>
            </div>
          </a>'
          
    # Swayam Cottage
    $c = $c -replace '(<a [^>]*href="swayam_cottage\.html"[^>]*>.*?)(</a>)', '$1    <div class="rcard-thumbs">
              <div class="rthumb"><img alt="" src="images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.01 (1).jpeg" /></div>
              <div class="rthumb-more">+3</div>
            </div>
          </a>'
          
    # Riverpoint Resort
    $c = $c -replace '(<a [^>]*href="riverpoint_resort\.html"[^>]*>.*?)(</a>)', '$1    <div class="rcard-thumbs">
              <div class="rthumb"><img alt="" src="" /></div>
              <div class="rthumb-more">+3</div>
            </div>
          </a>'
          
    # Make sure we didn't duplicate by accident if it already had thumbs
    $c = $c -replace '(?s)<div class="rcard-thumbs">.*?<div class="rcard-thumbs">', '<div class="rcard-thumbs">'
    [System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
}

foreach ($f in $files) {
    & $thumbsFixScript $f
}

# 2. Fix Hearts & Encode them correctly (Clean all, then add exactly 1 per card before thumb)
$heartChar = [char]::ConvertFromUtf32(0x2764)
$whiteChar = [char]::ConvertFromUtf32(0x1F90D)
$heartBtnClass = 'onclick="event.preventDefault(); this.classList.toggle(''liked''); this.textContent = this.classList.contains(''liked'') ? '''+$heartChar+''' : '''+$whiteChar+'''"'

foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    
    # Remove ALL existing heart buttons everywhere
    $c = $c -replace '(?s)\s*<button class="(?:r)?card-heart".*?</button>', ''
    $c = $c -replace '(?s)\s*<button class="heart".*?</button>', ''
    
    # Inject exactly ONE before the thumbs container
    if ($f -match "student") {
        $btnHTML = "`n            <button class=`"heart`" $heartBtnClass>$whiteChar</button>"
        $c = $c -replace '<div class="thumbs">', ("$btnHTML`n            <div class=`"thumbs`">")
    } else {
        $btnHTML = "`n            <button class=`"rcard-heart`" $heartBtnClass>$whiteChar</button>"
        $c = $c -replace '<div class="rcard-thumbs">', ("$btnHTML`n            <div class=`"rcard-thumbs`">")
    }
    
    [System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
}

# 3. Update Prices
foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    
    $multiplier = 1
    $unit = "/person"
    $cardClass = "card"
    
    if ($f -match "couple") {
        $multiplier = 2
        $unit = "/couple"
        $cardClass = "rcard"
    } elseif ($f -match "family") {
        $multiplier = 4
        $unit = "/family"
        $cardClass = "rcard"
    }
    
    $cardRegexText = "(?i)(<div class=`"$cardClass`"[^>]*>)"
    $chunks = [regex]::Split($c, $cardRegexText)
    
    for ($i = 2; $i -lt $chunks.Length; $i += 2) {
        $cardHeader = $chunks[$i-1]
        $cardBody = $chunks[$i]
        
        foreach ($key in $pricing.Keys) {
            if ($cardBody -match "href=`"$key`"") {
                $basePrice = $pricing[$key]
                $finalPrice = $basePrice * $multiplier
                
                $cardHeader = [regex]::Replace($cardHeader, 'data-price="\d+"', "data-price=`"$finalPrice`"")
                
                $priceRegex = '(?i)<div class="(r)?price">.*?</div>'
                $replacement = "<div class=`"`$1price`">₹$finalPrice <span class=`"`$1price-unit`">$unit</span></div>"
                $cardBody = [regex]::Replace($cardBody, $priceRegex, $replacement)
                
                $chunks[$i-1] = $cardHeader
                $chunks[$i] = $cardBody
                break
            }
        }
    }
    
    $newContent = $chunks -join ""
    [System.IO.File]::WriteAllText($f, $newContent, [System.Text.Encoding]::UTF8)
}
Write-Host "ALL FIXES APPLIED!"
