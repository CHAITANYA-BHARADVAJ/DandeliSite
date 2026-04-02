$ErrorActionPreference = 'Stop'
$dir = "d:\Antigravity\DandeliSite"

$packageCardTemplate = @"
        <div class="rcard" data-amenities="pool wifi parking" data-price="2500" data-rating="4.2" data-stars="4">
          <a class="rcard-img" href="{url}" style="display:block; text-decoration:none;">
            <img alt="{title}" src="{img}" />
            <div class="rcard-badges"><span class="rbadge rb-eco" style="background:var(--forest);">🍃 Nature Resort</span></div>
          </a>
          <div class="rcard-info">
            <button class="rcard-heart" onclick="this.classList.toggle('liked');this.textContent=this.classList.contains('liked')?'❤️':'🤍'">🤍</button>
            <div class="rcard-top">
              <a href="{url}" style="text-decoration:none;"><div class="rcard-name">{title}</div></a>
              <div class="rcard-rating">
                <div class="rating-badge">4.2</div>
                <div class="rating-count">120+ reviews</div>
              </div>
            </div>
            <div class="rcard-loc"><span class="rcard-stars">★★★★☆</span><span class="rcard-dist">📍 Dandeli</span></div>
            <div class="rcard-tags"><span class="rtag">✓ Scenic</span></div>
            <div class="rcard-amenities">
              <span class="ramenity">🏊 Pool</span>
              <span class="ramenity">📶 Wifi</span>
            </div>
            <div class="rcard-price-row">
              <div>
                <div class="rprice">₹2500 <span class="rprice-unit">/person</span></div>
              </div>
              <div class="rcard-ctas">
                <a class="btn-book" href="{url}">View Details</a>
                <a class="btn-wa" href="https://api.whatsapp.com/send?phone=+916363343766&text=I%20want%20to%20book%20{title}">Booking Inquiry</a>
              </div>
            </div>
          </div>
        </div>
"@

$listingCardTemplate = @"
        <div class="resort-card" data-category="nature" data-price="2500" data-rating="4.2" data-stars="4" data-type="resort">
          <a class="rc-img-col" href="{url}" style="display:block; text-decoration:none;">
            <img alt="{title}" src="{img}" />
            <div class="rc-img-overlay"></div>
            <div class="rc-badge-row"><span class="rc-badge rc-badge-eco">🍃 Nature Resort</span></div>
          </a>
          <div class="rc-info-col">
            <button class="rc-heart" onclick="event.preventDefault(); toggleHeart(this)">🤍</button>
            <div class="rc-top-row">
              <a href="{url}" style="text-decoration:none;"><div class="rc-name">{title}</div></a>
              <div class="rc-rating">
                <div class="rc-rating-badge">4.2</div>
                <div><div class="rc-rating-text">Excellent</div><div class="rc-rating-count">120+ reviews</div></div>
              </div>
            </div>
            <div class="rc-location">
              <span class="rc-stars">★★★★☆</span>
              <span class="rc-distance">📍 Dandeli</span>
            </div>
            <div class="rc-tags"><span class="rc-tag">✓ Scenic</span></div>
            <div class="rc-amenities">
              <span class="rc-amenity">🏊 Pool</span>
              <span class="rc-amenity">📶 Wifi</span>
            </div>
            <div class="rc-price-row">
              <div>
                <div class="rc-price">₹2500 <span class="rc-price-unit">/person</span></div>
                <div class="rc-taxes">+ taxes & fees</div>
              </div>
              <div class="rc-ctas">
                <a class="rc-btn-primary" href="{url}">View Details</a>
                <a class="rc-btn-wa" href="https://api.whatsapp.com/send?phone=+916363343766&text=I%20want%20to%20book%20{title}">Booking Inquiry</a>
              </div>
            </div>
          </div>
        </div>
"@

$pages = @(
  @{ file='jungle_edge.html'; title='Jungle Edge'; img='' },
  @{ file='swayam_cottage.html'; title='Swayam Cottage'; img='images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.01 (1).jpeg' },
  @{ file='riverpoint_resort.html'; title='Riverpoint Resort'; img='' }
)

# Fix family-packages.html
$fpath = Join-Path $dir "family-packages.html"
$fpHtml = Get-Content $fpath -Raw

# Replace broken lines 1318-1389. We'll use regex to remove Jungle Edge Resort and Swayam Cottage
$fpHtml = $fpHtml -replace '(?s)<div class="rcard"[^>]*>.*?<div class="rcard-name">Jungle Edge Resort</div>.*?</div>\s*</div>\s*</div>', ''
$fpHtml = $fpHtml -replace '(?s)<div class="rcard"[^>]*>.*?<div class="rcard-name">Swayam Cottage</div>.*?</div>\s*</div>\s*</div>', ''

$cardsStr = ""
foreach ($p in $pages) {
    if (-not $fpHtml.Contains($p.title)) {
        $cardsStr += (($packageCardTemplate -replace '\{url\}', $p.file) -replace '\{title\}', $p.title) -replace '\{img\}', $p.img
        $cardsStr += "`n"
    }
}
# Append before <div class="no-results"
$fpHtml = $fpHtml -replace '<div class="no-results"', "$cardsStr`n    <div class=`"no-results`""
Set-Content $fpath -Value $fpHtml -Encoding UTF8
Write-Host "Updated family-packages.html"


# Student & Couple packages
$packageFiles = @('student-packages.html', 'couple-packages.html')
foreach ($pf in $packageFiles) {
  $cpath = Join-Path $dir $pf
  $pHtml = Get-Content $cpath -Raw
  $cStr = ""
  foreach ($p in $pages) {
    if (-not $pHtml.Contains($p.title)) {
        $cStr += (($packageCardTemplate -replace '\{url\}', $p.file) -replace '\{title\}', $p.title) -replace '\{img\}', $p.img
        $cStr += "`n"
    }
  }
  if ($cStr.Length -gt 0) {
    $pHtml = $pHtml -replace '<div class="no-results"', "$cStr`n    <div class=`"no-results`""
    Set-Content $cpath -Value $pHtml -Encoding UTF8
    Write-Host "Updated $pf"
  }
}

# Resort Listing
$rlpath = Join-Path $dir "resort-listing.html"
$rlHtml = Get-Content $rlpath -Raw
$rlCardsStr = ""
foreach ($p in $pages) {
  if (-not $rlHtml.Contains($p.title)) {
    $rlCardsStr += (($listingCardTemplate -replace '\{url\}', $p.file) -replace '\{title\}', $p.title) -replace '\{img\}', $p.img
    $rlCardsStr += "`n"
  }
}
if ($rlCardsStr.Length -gt 0) {
  # In resort-listing, the container ends with </div> \n <!-- /rl-cards --> \n <!-- No results --> \n <div class="rl-no-results"
  $rlHtml = $rlHtml -replace '<!-- /rl-cards -->', "$rlCardsStr`n      <!-- /rl-cards -->"
  Set-Content $rlpath -Value $rlHtml -Encoding UTF8
  Write-Host "Updated resort-listing.html"
}

Write-Host "Done Script"
