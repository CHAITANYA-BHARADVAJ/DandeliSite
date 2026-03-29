$files = @(
    "D:\Antigravity\DandeliSite\hornbill_resort.html",
    "D:\Antigravity\DandeliSite\laguna_resort.html",
    "D:\Antigravity\DandeliSite\River Edge.html",
    "D:\Antigravity\DandeliSite\Tusker Trails.html",
    "D:\Antigravity\DandeliSite\dewDrops_resort.html",
    "D:\Antigravity\DandeliSite\Wild Wings.html",
    "D:\Antigravity\DandeliSite\White Petal.html",
    "D:\Antigravity\DandeliSite\Wild Mist.html",
    "D:\Antigravity\DandeliSite\rainForest_resort.html"
)

$newAmenities = @"
  amenities: [
    { icon: "&#x2615;",   text: "Buffet Breakfast" },
    { icon: "&#127869;",  text: "Buffet Lunch" },
    { icon: "&#x1F958;",  text: "Buffet Dinner" },
    { icon: "&#127754;",  text: "Outdoor Swimming Pool" },
    { icon: "&#127807;",  text: "Natural Jacuzzi" },
    { icon: "&#128675;",  text: "Kali River Boating" },
    { icon: "&#x1F6F6;",  text: "Kayaking" },
    { icon: "&#128134;",  text: "Spa & Massage Services" },
    { icon: "&#128690;",  text: "Indoor & Outdoor Games" },
    { icon: "&#128293;",  text: "Bonfire & Rain Dance" },
  ],
"@

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        
        $pattern = '(?s)amenities:\s*\[([^\]]*?)\],'
        $content = [regex]::Replace($content, $pattern, $newAmenities)
        
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Patched $file"
    }
}
Write-Host "Done patching all resorts."
