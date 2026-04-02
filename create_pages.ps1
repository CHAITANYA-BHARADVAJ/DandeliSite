$ErrorActionPreference = 'Stop'
$dir = "d:\Antigravity\DandeliSite"

Write-Host "Part 1: Create pages"
$templatePath = Join-Path $dir "tarang_homestay.html"
$html = Get-Content $templatePath -Raw

# Jungle Edge
$jeHTML = $html -replace "Tarang Homestay", "Jungle Edge" -replace "Tarang home stay", "Jungle Edge"
$jeHTML = $jeHTML -replace 'images/Tarang home stay/[^"''\s>]+', ''
Set-Content (Join-Path $dir "jungle_edge.html") -Value $jeHTML -Encoding UTF8
Write-Host "Created jungle_edge.html"

# Swayam Cottage
$scHTML = $html -replace "Tarang Homestay", "Swayam Cottage" -replace "Tarang home stay", "Swayam Cottage"
# Use a valid image from Swayam Cottages directory for the hero backgrounds
$scHTML = $scHTML -replace 'images/Tarang home stay/Tarang home stay \(5\)\.jpg', 'images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.01 (1).jpeg'
$scHTML = $scHTML -replace 'images/Tarang home stay/[^"''\s>]+', 'images/Swayam Cottages/WhatsApp Image 2026-04-02 at 23.18.02 (1).jpeg'
Set-Content (Join-Path $dir "swayam_cottage.html") -Value $scHTML -Encoding UTF8
Write-Host "Created swayam_cottage.html"

# Riverpoint Resort
$rrHTML = $html -replace "Tarang Homestay", "Riverpoint Resort" -replace "Tarang home stay", "Riverpoint Resort"
$rrHTML = $rrHTML -replace 'images/Tarang home stay/[^"''\s>]+', ''
Set-Content (Join-Path $dir "riverpoint_resort.html") -Value $rrHTML -Encoding UTF8
Write-Host "Created riverpoint_resort.html"

Write-Host "Part 2: Append Cards"

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
        <div class="resort-card" data-category="nature" data-price="2500" data-rating="4.2" data-stars="4">
          <a class="rc-img-col" href="{url}" style="display:block; text-decoration:none;">
            <img alt="{title}" src="{img}" />
            <div class="rc-img-overlay"></div>
            <div class="rc-badge-row"><span class="rc-badge rc-badge-eco">🍃 Nature Resort</span></div>
          </a>
          <div class="rc-info-col">
            <button class="rc-heart" onclick="this.classList.toggle('liked');this.querySelector('svg').style.fill=this.classList.contains('liked')?'currentColor':'none'"><svg viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg></button>
            <div class="rc-top-row">
              <a href="{url}" style="text-decoration:none;"><div class="rc-name">{title}</div></a>
              <div class="rc-rating">
                <div class="rc-rating-badge">4.2</div>
                <div><div class="rc-rating-text">Excellent</div><div class="rc-rating-count">120+ ratings</div></div>
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

# Append to package files
$packageFiles = @('student-packages.html', 'couple-packages.html')
foreach ($pf in $packageFiles) {
  $fpath = Join-Path $dir $pf
  $pHtml = Get-Content $fpath -Raw
  $cardsStr = ""
  foreach ($p in $pages) {
    if (-not $pHtml.Contains($p.title)) {
        $cardsStr += (($packageCardTemplate -replace '\{url\}', $p.file) -replace '\{title\}', $p.title) -replace '\{img\}', $p.img
        $cardsStr += "`n"
    }
  }
  if ($cardsStr.Length -gt 0 -and $pHtml.Contains('<div class="no-results">')) {
    $pHtml = $pHtml.Replace('<div class="no-results">', $cardsStr + '        <div class="no-results">')
    Set-Content $fpath -Value $pHtml -Encoding UTF8
    Write-Host "Appended cards to $pf"
  }
}

# Append to resort-listing.html
$rlpath = Join-Path $dir "resort-listing.html"
$rlHtml = Get-Content $rlpath -Raw
$rlCardsStr = ""
foreach ($p in $pages) {
  if (-not $rlHtml.Contains($p.title)) {
    $rlCardsStr += (($listingCardTemplate -replace '\{url\}', $p.file) -replace '\{title\}', $p.title) -replace '\{img\}', $p.img
    $rlCardsStr += "`n"
  }
}
if ($rlCardsStr.Length -gt 0 -and $rlHtml.Contains('<div class="no-results">')) {
  $rlHtml = $rlHtml.Replace('<div class="no-results">', $rlCardsStr + '      <div class="no-results">')
  Set-Content $rlpath -Value $rlHtml -Encoding UTF8
  Write-Host "Appended cards to resort-listing.html"
}

Write-Host "Done Script"
