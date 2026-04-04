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

# ONLY UPDATE PRICES safely
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
    
    # Using capturing group parenthesis ensures the delimiters are kept in $chunks
    $cardRegexText = "(?i)(<div class=`"$cardClass`"[^>]*>)"
    $chunks = [regex]::Split($c, $cardRegexText)
    
    for ($i = 2; $i -lt $chunks.Length; $i += 2) {
        $cardHeader = $chunks[$i-1] # the "<div class=`card`..."
        $cardBody = $chunks[$i]     # the inner HTML up to the next card
        
        foreach ($key in $pricing.Keys) {
            if ($cardBody -match "href=`"$key`"") {
                $basePrice = $pricing[$key]
                $finalPrice = $basePrice * $multiplier
                
                # Update data-price inside <div class="card...">
                $cardHeader = [regex]::Replace($cardHeader, 'data-price="\d+"', "data-price=`"$finalPrice`"")
                
                # Regex looking for <div class="price">..</div> or <div class="rprice">..</div>
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
Write-Host "Pricing Update Complete!"
