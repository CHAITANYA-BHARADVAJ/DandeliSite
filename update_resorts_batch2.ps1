$ErrorActionPreference = 'Stop'
$dir = "d:\Antigravity\DandeliSite"

$batch2Files = @(
    "white_water_resort.html",
    "tarang_homestay.html",
    "sunbird_resort.html",
    "dewDrops_resort.html",
    "Tusker Trails.html",
    "River Edge.html",
    "rainForest_resort.html",
    "palm_meadows_resort.html",
    "Wild Wings.html"
)

$cssInjection = @"
    /* ── ACCORDION AMENITIES ── */
    .am-details {
      border: 1px solid var(--border);
      background: #fff;
      margin-top: 16px;
    }
    .am-summary {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 14px 20px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 600;
      color: var(--forest);
      transition: background .2s;
      list-style: none;
    }
    .am-summary::-webkit-details-marker {
      display: none;
    }
    .am-summary:hover {
      background: rgba(201, 168, 76, .05);
    }
    .am-summary::after {
      content: '▼';
      font-size: 10px;
      color: var(--gold);
      transition: transform .3s;
    }
    .am-details[open] .am-summary::after {
      transform: rotate(180deg);
    }
    .am-details[open] .am-summary {
      border-bottom: 1px dashed var(--border);
    }
    .am-content {
      display: grid;
      grid-template-columns: 1fr;
    }
    .am-content .am-item {
      border: none !important;
      border-bottom: 1px solid var(--border) !important;
    }
    @media(min-width:560px) {
      .am-content {
        grid-template-columns: 1fr 1fr;
      }
      .am-content .am-item:nth-child(even) {
        border-left: 1px solid var(--border) !important;
      }
      .am-content .am-item:nth-last-child(-n+2) {
        border-bottom: none !important;
      }
    }
"@

$jsOldTokenRegex = '(?s)R\.amenities\.forEach\(a => \{.*?<div class="am-item"><span class="am-name">\$\{a\.text\}<\/span><span class="am-check"><\/span><\/div>`;\s*\}\);'

$jsNewToken = @"
/* amenities — list style */
      if (R.amenities) {
        R.amenities.forEach(a => {
          document.getElementById('amenitiesGrid').innerHTML +=
            `<div class="am-item"><span class="am-name">` + a.text + `</span><span class="am-check"></span></div>`;
        });
      }

      /* grouped activities — dropdown accordion style */
      if (R.groupedActivities && R.groupedActivities.length > 0) {
        let gaHtml = '';
        R.groupedActivities.forEach(group => {
           gaHtml += `<details class="am-details"><summary class="am-summary">` + group.name + `</summary><div class="am-content">`;
           group.items.forEach(item => {
             let isCost = item.toLowerCase().includes("cost") || item.toLowerCase().includes("charge");
             gaHtml += `<div class="am-item"><span class="am-name">` + item + `</span><span class="am-check" ${isCost ? 'style="background:rgba(255,165,0,.1);border-color:rgba(255,165,0,.2);color:#d97706;border-radius:3px;"' : ''}></span></div>`;
           });
           gaHtml += `</div></details>`;
        });
        document.getElementById('amenitiesGrid').insertAdjacentHTML('afterend', gaHtml);
      }
"@

# --- Resort Data Definitions ---

# White Water
$wwAmenities = @"
amenities: [
        { icon: "&#127968;", text: "Stay in River Touch Resort" },
        { icon: "&#127754;", text: "River View Cottages" },
        { icon: "&#x2615;", text: "1 Breakfast" },
        { icon: "&#127869;", text: "1 Lunch (Veg & Non-Veg)" },
        { icon: "&#x2615;", text: "1 Evening Tea/Coffee with Snacks" },
        { icon: "&#x1F958;", text: "1 Dinner (Veg & Non-Veg)" },
      ],
      groupedActivities: [
        {
          name: "Water Activities",
          items: ["Boating", "River Swimming", "Kayaking", "Zorbing"]
        },
        {
          name: "In-Resort Activities",
          items: ["Rain Dance", "Night Campfire with Music", "Carrom", "Badminton"]
        }
      ],
"@

$wwPolicies = @"
policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 1:00 PM", "Check-out: 11:00 AM"] },
        { icon: "&#128101;", title: "Child Policy", items: ["Children aged 5 to 10 years charged 50%"] },
        { icon: "&#128663;", title: "Transportation", items: ["Transportation is not included in the package"] },
        { icon: "&#128176;", title: "Booking & Payment", items: ["50% Advance payment for confirmation", "Remaining amount to be paid in cash while check-in", "Confirmation letter provided after booking"] },
      ],
"@

# Tarang & Sunbird Shared
function Get-AdventureData($price) {
    return @"
amenities: [
        { icon: "&#127869;", text: "Lunch (Veg)" },
        { icon: "&#x1F958;", text: "Dinner (Veg & Non-veg)" },
        { icon: "&#x2615;", text: "Breakfast" },
      ],
      groupedActivities: [
        {
          name: "Adventure Package (@ ₹$price/-)",
          items: ["Boating", "Kayaking", "Swimming", "Zorbing", "Short Rafting", "Zipline"]
        },
        {
          name: "Resort Recreation",
          items: ["Swimming Pool", "Rain Dance", "Fire Camp", "Nature Walk (7:00 to 9:00)", "Day Music + Night Music", "Chess", "Carrom", "Badminton", "Archery"]
        }
      ],
"@
}

$tarangSunbirdPolicies = @"
policies: [
        { icon: "&#128176;", title: "Booking Confirmation", items: ["25% Advance of total pax charged for confirmation", "Traveling charges not included"] },
        { icon: "&#127754;", title: "Water Level Note", items: ["Kali River Rafting depends on water level"] },
        { icon: "&#128681;", title: "Rules & Equipment", items: ["Do not damage property", "Use equipment carefully", "Internal transportation for activities/sightseeing at extra cost"] },
        { icon: "&#128101;", title: "Child Policy", items: ["Tariff for children between 5 to 10 years is 50%"] },
      ],
"@

# Group Bulk (Dew Drops, Tusker Trails, River Edge, Rain Forest, Palm Meadows, Wild Wings)
$groupBulkAmenities = @"
amenities: [
        { icon: "&#127869;", text: "Lunch (Buffet)" },
        { icon: "&#x1F958;", text: "Dinner (Buffet)" },
        { icon: "&#x2615;", text: "Breakfast (Buffet)" },
      ],
      groupedActivities: [
        {
          name: "Water Activities",
          items: ["Kayaking", "Water Zorbing", "Boating"]
        },
        {
          name: "Rope Activities",
          items: ["Zig Zag Bridge", "Quake Walk", "Hanging Log"]
        },
        {
          name: "In-House Activities",
          items: ["Swimming Pool", "Campfire", "Archery Shooting", "Jungle Trekking", "Rain Dance"]
        },
        {
          name: "Sightseeing",
          items: ["Disney Park", "Nagoda Backwaters", "Moulangi Eco Park", "Supa Dam View Point"]
        }
      ],
"@

$groupBulkPolicies = @"
policies: [
        { icon: "&#9203;", title: "Timings", items: ["Water Sports: 8:00 AM - 5:00 PM", "Morning Trekking: 7:00 AM - 8:00 AM", "Campfire: Starts after 9:00 PM", "Rain Dance: 7:30 PM - 9:00 PM", "Swimming Pool: 9:00 AM - 6:00 PM"] },
        { icon: "&#128681;", title: "Rules & Notes", items: ["Water Sports location: 25 km from Dandeli Bus Stand", "Kids below 10 years permitted only for Zorbing", "Rafting subject to water levels", "Nylon clothing mandatory for swimming pool"] },
      ],
"@

# --- Execution ---

foreach ($f in $batch2Files) {
    $fPath = Join-Path $dir $f
    if (Test-Path $fPath) {
        $content = Get-Content $fPath -Raw
        Write-Host "Processing $f ..."

        # Add CSS
        if (-not $content.Contains('.am-details {')) {
             if ($content.Contains('.am-check::after {') -or $content.Contains('.am-check::after{')) {
                $content = $content -replace '(?s)(\.am-check::after\s*\{[^}]*\}\s*)', ("`$1" + $cssInjection + "`n")
                Write-Host "  Added CSS"
             }
        }

        # Add JS logic
        if (-not $content.Contains('groupedActivities')) {
            $content = $content -replace $jsOldTokenRegex, $jsNewToken
            Write-Host "  Added JS logic"
        }

        # Update Content
        if ($f -eq "white_water_resort.html") {
            $content = $content -replace '(?s)amenities:\s*\[[^\]]*\],', $wwAmenities
            $content = $content -replace '(?s)policies:\s*\[.*?\],', $wwPolicies
        }
        elseif ($f -eq "tarang_homestay.html") {
            $content = $content -replace '(?s)amenities:\s*\[[^\]]*\],', (Get-AdventureData "2000")
            $content = $content -replace '(?s)policies:\s*\[.*?\],', $tarangSunbirdPolicies
        }
        elseif ($f -eq "sunbird_resort.html") {
            $content = $content -replace '(?s)amenities:\s*\[[^\]]*\],', (Get-AdventureData "1800")
            $content = $content -replace '(?s)policies:\s*\[.*?\],', $tarangSunbirdPolicies
        }
        else {
            # Dew Drops, Tusker, River Edge, Rain Forest, Palm Meadows, Wild Wings
            $content = $content -replace '(?s)amenities:\s*\[[^\]]*\],', $groupBulkAmenities
            $content = $content -replace '(?s)policies:\s*\[.*?\],', $groupBulkPolicies
        }

        Set-Content $fPath $content -Encoding UTF8
        Write-Host "  Finished updating $f"
    } else {
        Write-Host "Warning: File not found: $f"
    }
}
Write-Host "Batch 2 updates complete."
