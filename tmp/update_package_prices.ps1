function Update-Prices {
    param([string]$FilePath, [int]$Multiplier, [string]$Unit, [string]$CardClass)
    
    if (-not (Test-Path $FilePath)) { return }
    $content = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    
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

    $cardRegexText = "(?i)<div class=`"$CardClass`"[^>]*>"
    $chunks = [regex]::Split($content, $cardRegexText)
    
    for ($i = 2; $i -lt $chunks.Length; $i += 2) {
        $cardHeader = $chunks[$i-1] # `<div class="rcard" ...>`
        $cardBody = $chunks[$i]     # Everything inside the card (and up to next card)
        
        foreach ($key in $pricing.Keys) {
            if ($cardBody -match "href=`"$key`"") {
                $basePrice = $pricing[$key]
                $finalPrice = $basePrice * $Multiplier
                
                # Update data-price inside $cardHeader
                $cardHeader = [regex]::Replace($cardHeader, 'data-price="\d+"', "data-price=`"$finalPrice`"")
                
                # Update rprice / price inside $cardBody
                # The regex looks for <div class="rprice">...</div> or <div class="price">...</div>
                $priceRegex = '(?i)<div class="(r)?price">.*?</div>'
                $replacement = "<div class=`"`$1price`">₹$finalPrice <span class=`"`$1price-unit`">$Unit</span></div>"
                $cardBody = [regex]::Replace($cardBody, $priceRegex, $replacement)
                
                $chunks[$i-1] = $cardHeader
                $chunks[$i] = $cardBody
                break
            }
        }
    }
    
    $newContent = $chunks -join ""
    [System.IO.File]::WriteAllText($FilePath, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "Updated prices in $FilePath"
}

Update-Prices "d:\Antigravity\DandeliSite\student-packages.html" 1 "/person" "card"
Update-Prices "d:\Antigravity\DandeliSite\couple-packages.html" 2 "/couple" "rcard"
Update-Prices "d:\Antigravity\DandeliSite\family-packages.html" 4 "/family" "rcard"
