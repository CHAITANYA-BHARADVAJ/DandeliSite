$ErrorActionPreference = 'Stop'
$dir = "d:\Antigravity\DandeliSite"

# Master Resort Data
$resorts = @(
    @{ name="Whistling Woodzs Resort"; url="whistling_woods_resort.html"; img="images/Whistling Woods/hq_4.jpg"; rating="4.8"; stars="★★★★★"; sPrice="3500"; cPrice="8000"; fPrice="12000"; am="river pool"; badge="Luxury Garden" },
    @{ name="Hornbill River Resort"; url="hornbill_resort.html"; img="images/Hornbill/HRR-Brochure-2024 (1)-images-3.jpg"; rating="4.6"; stars="★★★★☆"; sPrice="3000"; cPrice="7000"; fPrice="10000"; am="river bonfire"; badge="Nature Vibes" },
    @{ name="Laguna River Resort"; url="laguna_resort.html"; img="images/Laguna/WhatsApp Image 2026-03-19 at 9.50.48 PM (2).jpeg"; rating="4.4"; stars="★★★★☆"; sPrice="2800"; cPrice="6000"; fPrice="9000"; am="river pool"; badge="River Side" },
    @{ name="River Edge Resort"; url="River Edge.html"; img="images/RiverEdge/Aa River Edge Gallery (2)-images-13.jpg"; rating="4.2"; stars="★★★☆☆"; sPrice="2200"; cPrice="5000"; fPrice="7500"; am="river"; badge="Eco Certified" },
    @{ name="Tusker Trails"; url="Tusker Trails.html"; img="images/Tusker Trails/Aaa Tusker trails kl -images-8.jpg"; rating="4.0"; stars="★★★☆☆"; sPrice="1800"; cPrice="4500"; fPrice="7000"; am="pool"; badge="Forest Trail" },
    @{ name="Dew Drops Resort"; url="dewDrops_resort.html"; img="images/Dewdrops/Cabin View.jpg"; rating="4.5"; stars="★★★★☆"; sPrice="2800"; cPrice="6500"; fPrice="9500"; am="pool wifi"; badge="Top Rated" },
    @{ name="Wild Wings Resort"; url="Wild Wings.html"; img="images/Wild Wings/Aa wild wings Gallery (1)-images-3.jpg"; rating="4.4"; stars="★★★★☆"; sPrice="2600"; cPrice="6000"; fPrice="8500"; am="pool raindance"; badge="Family Pick" },
    @{ name="Wild Mist Resort"; url="Wild Mist.html"; img="images/Wild Mist/1.jpeg"; rating="4.4"; stars="★★★★☆"; sPrice="2600"; cPrice="6000"; fPrice="8500"; am="pool raindance"; badge="Nature Stay" },
    @{ name="Rain Forest Dandeli"; url="rainForest_resort.html"; img="images/RainForest/Swiming Pool_2.jpg"; rating="4.8"; stars="★★★★★"; sPrice="4500"; cPrice="14000"; fPrice="20000"; am="pool river spa"; badge="Luxury" },
    @{ name="Bison River Resort"; url="bison_resort.html"; img="images/Bison/Bison River Resorts (1).jpg"; rating="4.1"; stars="★★★☆☆"; sPrice="2500"; cPrice="5500"; fPrice="8000"; am="river pool"; badge="Wildlife Pick" },
    @{ name="Palm Meadows Resort"; url="palm_meadows_resort.html"; img="images/Palm meadows/046fe19a-316a-4474-97b3-7901450b52a8.jpg"; rating="4.3"; stars="★★★☆☆"; sPrice="2200"; cPrice="5000"; fPrice="7500"; am="pool wifi"; badge="Peaceful" },
    @{ name="State Lodge Dandeli"; url="state_lodge.html"; img="images/State Lodge/SL.jpg"; rating="3.8"; stars="★★★☆☆"; sPrice="1500"; cPrice="3500"; fPrice="5000"; am="wifi"; badge="Budget Stay" },
    @{ name="Sunbird Resort"; url="sunbird_resort.html"; img="images/Sunbird resort/0f2d7b22-71ee-448b-b841-f68def4368c5.jpg"; rating="4.5"; stars="★★★★☆"; sPrice="2800"; cPrice="6500"; fPrice="9500"; am="river wifi"; badge="Bird Watching" },
    @{ name="Tarang Homestay"; url="tarang_homestay.html"; img="images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.01 (1).jpeg"; rating="4.6"; stars="★★★★☆"; sPrice="2000"; cPrice="5000"; fPrice="7000"; am="wifi"; badge="Cozy Comfort" },
    @{ name="Green Valley Resort"; url="green_valley_resort.html"; img="images/Green Valley/GV1.jpg"; rating="4.2"; stars="★★★☆☆"; sPrice="2200"; cPrice="5000"; fPrice="7500"; am="pool"; badge="Nature Retreat" },
    @{ name="White Water Resort"; url="white_water_resort.html"; img="images/White Waters/WHITE WATER RESORT  pdf-images-1.jpg"; rating="4.3"; stars="★★★★☆"; sPrice="2600"; cPrice="6000"; fPrice="8500"; am="river pool"; badge="Premium" },
    @{ name="Ansh Resort"; url="ansh_resort.html"; img="images/Ansh/WhatsApp Image 2026-03-30 at 10.24.49 PM.jpeg"; rating="4.4"; stars="★★★★☆"; sPrice="3000"; cPrice="7000"; fPrice="10000"; am="pool"; badge="Premium Luxury" },
    @{ name="Jungle Edge"; url="jungle_edge.html"; img=""; rating="4.2"; stars="★★★☆☆"; sPrice="2500"; cPrice="6000"; fPrice="8500"; am="pool wifi"; badge="Nature Resort" },
    @{ name="Riverpoint Resort"; url="riverpoint_resort.html"; img=""; rating="4.2"; stars="★★★☆☆"; sPrice="2500"; cPrice="6000"; fPrice="8500"; am="river pool"; badge="Water Front" },
    @{ name="Swayam Cottage"; url="swayam_cottage.html"; img="images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.01 (1).jpeg"; rating="4.2"; stars="★★★☆☆"; sPrice="2500"; cPrice="6000"; fPrice="8500"; am="pool wifi"; badge="Cozy Stay" }
)

# Function to build Student Card
function Get-StudentCard($r) {
    return @"
        <div class="card" data-price="$($r.sPrice)" data-rating="$($r.rating)" data-amenities="$($r.am)">
          <a href="$($r.url)" class="card-img" style="display:block; text-decoration:none;">
            <img src="$($r.img)" alt="$($r.name)">
            <div class="card-img-overlay"></div>
            <div class="badge-row"><span class="badge" style="background:var(--forest);">⭐ $($r.badge)</span></div>
            <div class="thumbs">
              <div class="thumb"><img src="$($r.img)" alt=""></div>
              <div class="thumb-more">+3</div>
            </div>
          </a>
          <div class="card-info">
            <button class="heart" onclick="this.classList.toggle('liked');this.textContent=this.classList.contains('liked')?'❤️':'🤍'">🤍</button>
            <div class="card-top">
              <div class="card-name"><a href="$($r.url)" style="color:inherit;text-decoration:none;">$($r.name)</a></div>
              <div>
                <div class="rating-badge">$($r.rating)</div>
                <div class="rating-count">100+ reviews</div>
              </div>
            </div>
            <div class="card-loc"><span class="card-stars">$($r.stars)</span><span class="card-dist">📍 Dandeli, Karnataka</span></div>
            <div class="card-usps"><span class="card-usp">✓ Clean & Safe</span></div>
            <div class="card-amenities"><span class="amenity">✨ Excellent Stay</span></div>
            <div class="card-incs"><span class="card-inc">Student Package</span></div>
            <div class="card-bottom">
              <div>
                <div class="disc-label">💰 Limited Offer</div>
                <div class="card-price">₹$($r.sPrice) <span class="price-unit">/person</span></div>
              </div>
              <div class="card-ctas">
                <a href="$($r.url)" class="btn-book">View Details</a>
                <a href="https://api.whatsapp.com/send?phone=916363343766&text=Hi! I want to enquiry about $($r.name) Student Package" class="btn-wa">Book Now</a>
              </div>
            </div>
          </div>
        </div>
"@
}

# Function to build RCARD (Couple/Family)
function Get-RCard($r, $type) {
    if ($type -eq "couple") { $price = $r.cPrice; $unit = "/couple"; }
    else { $price = $r.fPrice; $unit = "/family"; }
    
    return @"
        <div class="rcard" data-amenities="$($r.am)" data-dur="2n3d" data-price="$price" data-rating="$($r.rating)" data-stars="$($r.stars.Length)">
          <a class="rcard-img" href="$($r.url)" style="display:block; text-decoration:none;">
            <img alt="$($r.name)" src="$($r.img)"/>
            <div class="rcard-badges"><span class="rbadge rb-top">⭐ $($r.badge)</span></div>
            <button class="rcard-heart" onclick="event.preventDefault(); toggleHeart(this)">🤍</button>
            <div class="rcard-thumbs"><div class="rthumb"><img alt="" src="$($r.img)"/></div><div class="rthumb-more">+3</div></div>
          </a>
          <div class="rcard-info">
            <div class="rcard-top"><div class="rcard-name"><a href="$($r.url)" style="color:inherit;text-decoration:none;">$($r.name)</a></div><div class="rcard-rating"><div class="rating-badge">$($r.rating)</div><div class="rating-count">100+ reviews</div></div></div>
            <div class="rcard-loc"><span class="rcard-stars">$($r.stars)</span><span class="rcard-dist">📍 Dandeli</span></div>
            <div class="rcard-tags"><span class="rtag">✓ $type Special</span><span class="rtag">✓ Clean & Safe</span></div>
            <div class="rcard-amenities"><span class="ramenity">✨ Premium Stay</span><span class="ramenity">🍽 Buffet Included</span></div>
            <div class="rcard-incs"><span class="rinc">Breakfast</span><span class="rinc">Lunch</span><span class="rinc">Dinner</span><span class="rinc">Activities</span></div>
            <div class="rcard-price-row">
              <div><div class="rdiscount">💰 Limited Offer</div><div class="rprice">₹$price <span class="rprice-unit">$unit</span></div></div>
              <div class="rcard-ctas">
                <a class="btn-book" href="$($r.url)">Details</a>
                <a class="btn-wa" href="https://api.whatsapp.com/send?phone=916363343766&text=Hi! I want to enquiry about $($r.name) $type Package">Book</a>
              </div>
            </div>
          </div>
        </div>
"@
}

# --- PROCESS STUDENT PACKAGES ---
Write-Host "Updating student-packages.html..."
$sFile = Join-Path $dir "student-packages.html"
$sContent = Get-Content $sFile -Raw
$sCardsHtml = ""
foreach ($r in $resorts) { $sCardsHtml += Get-StudentCard($r) }

$markerStart = '<div class="cards" id="cards">'
$markerEnd = '<div class="no-results" id="noRes">'
$sStartIdx = $sContent.IndexOf($markerStart)
$sEndIdx = $sContent.IndexOf($markerEnd)
if ($sStartIdx -ge 0 -and $sEndIdx -gt $sStartIdx) {
    $sNewContent = $sContent.Substring(0, $sStartIdx + $markerStart.Length) + "`n" + $sCardsHtml + "`n    </div>`n    " + $sContent.Substring($sEndIdx)
    Set-Content $sFile $sNewContent -Encoding UTF8
}

# --- PROCESS COUPLE PACKAGES ---
Write-Host "Updating couple-packages.html..."
$cFile = Join-Path $dir "couple-packages.html"
$cContent = Get-Content $cFile -Raw
$cCardsHtml = ""
foreach ($r in $resorts) { $cCardsHtml += Get-RCard $r "couple" }

$cMarkerStart = '<div class="cards" id="cardsContainer">'
$cMarkerEnd = '<div class="no-results" id="noResults">'
$cStartIdx = $cContent.IndexOf($cMarkerStart)
$cEndIdx = $cContent.IndexOf($cMarkerEnd)
if ($cStartIdx -ge 0 -and $cEndIdx -gt $cStartIdx) {
    $cNewContent = $cContent.Substring(0, $cStartIdx + $cMarkerStart.Length) + "`n" + $cCardsHtml + "`n`n    " + $cContent.Substring($cEndIdx)
    Set-Content $cFile $cNewContent -Encoding UTF8
}

# --- PROCESS FAMILY PACKAGES ---
Write-Host "Updating family-packages.html..."
$fFile = Join-Path $dir "family-packages.html"
$fContent = Get-Content $fFile -Raw
$fCardsHtml = ""
foreach ($r in $resorts) { $fCardsHtml += Get-RCard $r "family" }

$fMarkerStart = '<div class="cards" id="cardsContainer">'
$fMarkerEnd = '<div class="no-results" id="noResults">'
$fStartIdx = $fContent.IndexOf($fMarkerStart)
$fEndIdx = $fContent.IndexOf($fMarkerEnd)
if ($fStartIdx -ge 0 -and $fEndIdx -gt $fStartIdx) {
    $fNewContent = $fContent.Substring(0, $fStartIdx + $fMarkerStart.Length) + "`n" + $fCardsHtml + "`n`n    " + $fContent.Substring($fEndIdx)
    Set-Content $fFile $fNewContent -Encoding UTF8
}
