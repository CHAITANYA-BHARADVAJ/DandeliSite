$snippet = @'

  <!-- FLOATING ONE DAY PACKAGE BUTTON -->
  <a href="one-day-packages.html" class="floating-oneday-btn">
    <div class="fob-content">
      <span class="fob-badge">Special</span>
      <span class="fob-text">1-Day Package &#128293;</span>
    </div>
  </a>
  <style>
    .floating-oneday-btn {
      position: fixed;
      bottom: 24px;
      left: 24px;
      background: rgba(26, 58, 42, 0.9);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border: 1px solid rgba(201, 168, 76, 0.3);
      border-radius: 30px;
      padding: 6px 14px;
      text-decoration: none;
      z-index: 1000;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
      transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
      display: flex;
      align-items: center;
      overflow: hidden;
    }
    .floating-oneday-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 50%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(201, 168, 76, 0.4), transparent);
      transform: skewX(-20deg);
      animation: fobShine 3.5s infinite;
    }
    @keyframes fobShine {
      0% { left: -100%; }
      15%, 100% { left: 200%; }
    }
    .floating-oneday-btn:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 25px rgba(201, 168, 76, 0.25);
      background: rgba(26, 58, 42, 1);
      border-color: rgba(201, 168, 76, 0.8);
    }
    .fob-content {
      display: flex;
      align-items: center;
      gap: 8px;
      position: relative;
      z-index: 2;
    }
    .fob-badge {
      background: linear-gradient(135deg, #c9a84c 0%, #e8c97a 100%);
      color: #1a3a2a;
      font-size: 8.5px;
      font-weight: 700;
      padding: 3px 6px;
      border-radius: 12px;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    .fob-text {
      font-family: 'Jost', sans-serif;
      color: #fff;
      font-size: 13px;
      font-weight: 500;
    }
    @media(max-width: 768px) {
      .floating-oneday-btn {
        bottom: 24px;
        left: 16px;
        width: 75px;
        height: 75px;
        flex-direction: column;
        justify-content: center;
        border-radius: 20px;
        padding: 10px;
        text-align: center;
      }
      .fob-content {
        flex-direction: column;
        gap: 4px;
      }
      .fob-text {
        font-size: 11px;
        line-height: 1.2;
      }
      .fob-badge {
        font-size: 7px;
        padding: 2px 5px;
      }
    }
  </style>

  <!-- ONE DAY PACKAGE POP-UP -->
  <div id="odp-popup-overlay" class="odp-popup-overlay">
    <div class="odp-popup-content">
      <button class="odp-popup-close" onclick="closeOdpPopup()">&times;</button>
      <div class="odp-popup-image" style="background-image: url('images/Whistling Woods/hq_3.jpg');"></div>
      <div class="odp-popup-body">
        <div class="odp-popup-eyebrow">Exclusive Adventure</div>
        <h2 class="odp-popup-title">1-Day Package</h2>
        <p class="odp-popup-text">Experience Whistling Woodzs with Rafting, Kayaking, Flyingfox &amp; Unlimited Lunch.</p>
        <div class="odp-popup-price">&#8377;1,299 <span>/ person</span></div>
        <a href="one-day-packages.html" class="odp-popup-btn">View Details &amp; Book</a>
      </div>
    </div>
  </div>
  <style>
    .odp-popup-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.85); backdrop-filter: blur(8px); z-index: 10000; display: none; align-items: center; justify-content: center; padding: 20px; opacity: 0; transition: opacity 0.5s ease; }
    .odp-popup-overlay.show { display: flex; opacity: 1; }
    .odp-popup-content { background: #fff; width: 100%; max-width: 400px; border-radius: 28px; overflow: hidden; position: relative; box-shadow: 0 30px 60px rgba(0,0,0,0.5); transform: translateY(40px) scale(0.9); transition: transform 0.6s cubic-bezier(0.16,1,0.3,1); }
    .odp-popup-overlay.show .odp-popup-content { transform: translateY(0) scale(1); }
    .odp-popup-close { position: absolute; top: 15px; right: 15px; width: 32px; height: 32px; background: rgba(255,255,255,0.2); border: none; border-radius: 50%; color: #fff; font-size: 24px; cursor: pointer; z-index: 10; backdrop-filter: blur(5px); display: flex; align-items: center; justify-content: center; transition: all 0.3s; }
    .odp-popup-close:hover { background: rgba(255,255,255,0.4); }
    .odp-popup-image { height: 180px; background-size: cover; background-position: center; position: relative; }
    .odp-popup-image::after { content: ''; position: absolute; inset: 0; background: linear-gradient(to top, #fff 0%, transparent 60%); }
    .odp-popup-tag { position: absolute; bottom: 15px; left: 20px; background: #c9a84c; color: #fff; font-size: 10px; font-weight: 700; padding: 5px 12px; border-radius: 30px; text-transform: uppercase; letter-spacing: 1px; z-index: 2; }
    .odp-popup-body { padding: 30px 25px 35px; text-align: center; }
    .odp-popup-eyebrow { font-size: 11px; letter-spacing: 3px; text-transform: uppercase; color: #c9a84c; margin-bottom: 8px; }
    .odp-popup-title { font-family: 'Cormorant Garamond', serif; font-size: 36px; color: #1a3a2a; line-height: 1; margin-bottom: 12px; }
    .odp-popup-text { font-size: 14px; color: #666; line-height: 1.5; margin-bottom: 20px; padding: 0 10px; }
    .odp-popup-price { font-family: 'Cormorant Garamond', serif; font-size: 42px; font-weight: 600; color: #1a3a2a; margin-bottom: 25px; }
    .odp-popup-price span { font-size: 14px; color: #999; font-family: 'Jost', sans-serif; font-weight: 400; }
    .odp-popup-btn { display: block; background: #1a3a2a; color: #fff; padding: 16px; border-radius: 40px; text-decoration: none; font-weight: 600; transition: all 0.3s; box-shadow: 0 10px 25px rgba(26,58,42,0.2); }
    .odp-popup-btn:hover { background: #2d5a3d; transform: translateY(-3px); box-shadow: 0 15px 30px rgba(26,58,42,0.3); }
    @media(max-width: 480px) { .odp-popup-content { max-width: 320px; } .odp-popup-title { font-size: 30px; } .odp-popup-price { font-size: 36px; } }
  </style>
  <script>
    function closeOdpPopup() {
      const overlay = document.getElementById('odp-popup-overlay');
      overlay.classList.remove('show');
      setTimeout(() => overlay.style.display = 'none', 500);
    }
    document.addEventListener('DOMContentLoaded', () => {
      if (!sessionStorage.getItem('odp_popup_shown')) {
        setTimeout(() => {
          const overlay = document.getElementById('odp-popup-overlay');
          overlay.style.display = 'flex';
          setTimeout(() => overlay.classList.add('show'), 10);
          sessionStorage.setItem('odp_popup_shown', 'true');
        }, 1500);
      }
    });
  </script>
'@

$files = @(
    "d:\Antigravity\DandeliSite\dandeli-sightseeing.html",
    "d:\Antigravity\DandeliSite\things-to-do.html",
    "d:\Antigravity\DandeliSite\packages-section.html"
)

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file)
    if ($content -match "floating-oneday-btn") {
        Write-Host "SKIP (already has button): $([System.IO.Path]::GetFileName($file))"
        continue
    }
    $content = $content -replace '</body>', "$snippet`r`n</body>"
    [System.IO.File]::WriteAllText($file, $content)
    Write-Host "INJECTED: $([System.IO.Path]::GetFileName($file))"
}

Write-Host "`nDone! Verifying..."
Select-String -Pattern "floating-oneday-btn" -Path $files | ForEach-Object { Write-Host "  OK: $($_.Filename)" }
