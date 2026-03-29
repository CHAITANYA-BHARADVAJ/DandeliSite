# Files that have the OLD grid-card amenities style and need updating
$files = @(
    "D:\Antigravity\DandeliSite\Wild Wings.html",
    "D:\Antigravity\DandeliSite\Wild Mist.html",
    "D:\Antigravity\DandeliSite\White Petal.html",
    "D:\Antigravity\DandeliSite\Tusker Trails.html",
    "D:\Antigravity\DandeliSite\River Edge.html",
    "D:\Antigravity\DandeliSite\rainForest_resort.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        # 1. Replace OLD amenities CSS block with Whistling Woods list-style CSS
        # Old CSS pattern: .amenities-grid{...} .am-item{...} .am-item:hover{...} .am-icon{...} .am-item:hover .am-icon{...} .am-text{...}
        $oldCssPattern = '(?s)\.amenities-grid\{display:grid;grid-template-columns:repeat\(3,1fr\);gap:12px;margin-top:24px;\}\s*\.am-item\{display:flex;align-items:center;gap:12px;padding:14px 16px;background:#fff;border:1px solid var\(--border\);border-radius:4px;transition:all \.3s;\}\s*\.am-item:hover\{border-color:rgba\(201,168,76,\.4\);transform:translateX\(4px\);box-shadow:0 6px 20px rgba\(0,0,0,\.06\);\}\s*\.am-icon\{font-size:20px;width:38px;height:38px;background:rgba\(201,168,76,\.07\);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;transition:background \.3s;\}\s*\.am-item:hover \.am-icon\{background:rgba\(201,168,76,\.15\);\}\s*\.am-text\{font-size:13px;color:#444;\}'
        
        $newCss = @"
.amenities-list{display:grid;grid-template-columns:1fr;margin-top:24px;border:1px solid var(--border);background:#fff;}
.am-item{display:flex;align-items:center;justify-content:space-between;padding:13px 20px;border-bottom:1px solid var(--border);transition:background .2s;}
.am-item:last-child{border-bottom:none;}
.am-item:hover{background:rgba(201,168,76,.03);}
.am-name{font-size:13.5px;color:#333;letter-spacing:.2px;}
.am-check{width:18px;height:18px;flex-shrink:0;border-radius:50%;background:rgba(45,90,61,.08);border:1px solid rgba(45,90,61,.18);display:flex;align-items:center;justify-content:center;}
.am-check::after{content:'';width:6px;height:4px;border-left:1.5px solid var(--moss);border-bottom:1.5px solid var(--moss);transform:rotate(-45deg) translateY(-1px);display:block;}
@media(min-width:560px){
  .amenities-list{grid-template-columns:1fr 1fr;}
  .am-item:nth-child(even){border-left:1px solid var(--border);}
  .am-item:nth-last-child(-n+2){border-bottom:none;}
}
"@
        
        $content = [regex]::Replace($content, $oldCssPattern, $newCss)
        
        # 2. Replace HTML: amenities-grid -> amenities-list
        $content = $content.Replace('class="amenities-grid" id="amenitiesGrid"', 'class="amenities-list" id="amenitiesGrid"')
        
        # 3. Replace JS rendering template: icon+text cards -> name+checkmark list items
        $oldJs = '`<div class="am-item"><div class="am-icon">${a.icon}</div><span class="am-text">${a.text}</span></div>`'
        $newJs = '`<div class="am-item"><span class="am-name">${a.text}</span><span class="am-check"></span></div>`'
        $content = $content.Replace($oldJs, $newJs)
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Patched listing style: $file"
    } else {
        Write-Host "File not found: $file"
    }
}
Write-Host "Done patching amenities listing style for all resorts."
