# Resort Room & Policy Update Script v2
# Uses [regex]::Replace with proper escaping

$basePath = "d:\Antigravity\DandeliSite"

function Update-Rooms {
    param([string]$File, [string]$NewRooms)
    $content = [System.IO.File]::ReadAllText($File)
    $pattern = '(?s)rooms: \[.*?\],(\s*\n\s*activities:)'
    $replacement = "rooms: [$NewRooms],`$1"
    $result = [regex]::Replace($content, $pattern, $replacement)
    if ($result -ne $content) {
        [System.IO.File]::WriteAllText($File, $result)
        return $true
    }
    return $false
}

function Update-Policies {
    param([string]$File, [string]$NewPolicies)
    $content = [System.IO.File]::ReadAllText($File)
    $pattern = '(?s)policies: \[.*?\],(\s*\n\s*address:)'
    $replacement = "policies: [$NewPolicies],`$1"
    $result = [regex]::Replace($content, $pattern, $replacement)
    if ($result -ne $content) {
        [System.IO.File]::WriteAllText($File, $result)
        return $true
    }
    return $false
}

# ============ SWAYAM COTTAGE ============
$rooms = @'

        { name: "Cottage Room", badge: "Cozy Stay", image: "images/Swayam Cottage/1e71cb65-d7ae-4381-ad74-2844ab5c3890.jpg", desc: "Comfortable cottage rooms nestled in nature.", features: ["Attached Bath", "WiFi"], price: "<del>&#8377;1,800</del> &#8377;1,699", unit: "/ person" },
        { name: "Dormitory", badge: "Budget Stay", image: "images/Swayam Cottage/1e71cb65-d7ae-4381-ad74-2844ab5c3890.jpg", desc: "Affordable dormitory-style accommodation for groups.", features: ["Shared Space", "WiFi"], price: "<del>&#8377;1,800</del> &#8377;1,699", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 01:00 PM", "Check-out: 11:00 AM", "Aadhar card compulsory for all guests"] },
        { icon: "&#128101;", title: "Children Policy", items: ["Below 5 years: Free", "5-10 years: 50% charges", "Above 10 years: Full adult charges"] },
        { icon: "&#128683;", title: "Important Notes", items: ["Sightseeing entry fees & transportation extra", "Activities depend on weather & water level"] },
      
'@
if (Update-Rooms "$basePath\swayam_cottage.html" $rooms) { Write-Host "ROOMS OK: swayam_cottage.html" } else { Write-Host "ROOMS FAIL: swayam_cottage.html" }
if (Update-Policies "$basePath\swayam_cottage.html" $policies) { Write-Host "POLICIES OK: swayam_cottage.html" } else { Write-Host "POLICIES FAIL: swayam_cottage.html" }

# ============ LAGUNA RESORT ============
$rooms = @'

        { name: "River View Cottage", badge: "Best Pick", image: "", desc: "Beautiful cottage with river views.", features: ["River View", "Attached Bath"], price: "<del>&#8377;3,500</del> &#8377;3,200", unit: "/ person" },
        { name: "Jungle View Cottage", badge: "Nature Stay", image: "", desc: "Cottage surrounded by lush jungle.", features: ["Jungle View", "Attached Bath"], price: "<del>&#8377;3,500</del> &#8377;3,200", unit: "/ person" },
        { name: "Bamboo Cottage", badge: "Premium", image: "", desc: "Unique bamboo cottages offering rustic luxury.", features: ["Bamboo Finish", "Premium"], price: "<del>&#8377;4,000</del> &#8377;3,600", unit: "/ person" },
        { name: "Dormitory", badge: "Budget Stay", image: "", desc: "Affordable shared accommodation.", features: ["Shared Space"], price: "<del>&#8377;2,800</del> &#8377;2,500", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM"] },
        { icon: "&#128101;", title: "Children & Booking", items: ["5-12 years: 50% charges", "Booking confirmed on advance only"] },
        { icon: "&#128683;", title: "Cancellation", items: ["No cancellation, No refund", "Balance to be paid before check-in"] },
        { icon: "&#127860;", title: "Meal Timings", items: ["Breakfast: 9-10 AM", "Lunch: 1:30-3 PM", "Dinner: 9:30-10:30 PM", "Buffet closes after time"] },
      
'@
if (Update-Rooms "$basePath\laguna_resort.html" $rooms) { Write-Host "ROOMS OK: laguna_resort.html" } else { Write-Host "ROOMS FAIL: laguna_resort.html" }
if (Update-Policies "$basePath\laguna_resort.html" $policies) { Write-Host "POLICIES OK: laguna_resort.html" } else { Write-Host "POLICIES FAIL: laguna_resort.html" }

# ============ HORNBILL RESORT ============
$rooms = @'

        { name: "Tree House", badge: "Ultra Luxury", image: "", desc: "Elevated AC tree house with forest canopy experience.", features: ["AC", "Elevated", "Premium"], price: "&#8377;5,100", unit: "/ person" },
        { name: "River View Cottages", badge: "Best Pick", image: "", desc: "Comfortable cottages with scenic river views.", features: ["River View"], price: "&#8377;4,250", unit: "/ person" },
        { name: "Rock Houses", badge: "Unique Stay", image: "", desc: "Rock-themed cottages blending with nature.", features: ["Non-AC"], price: "&#8377;3,800", unit: "/ person" },
        { name: "Deluxe Cottages", badge: "Comfort", image: "", desc: "Well-appointed cottages with couple & single bed.", features: ["Non-AC"], price: "&#8377;3,400", unit: "/ person" },
        { name: "Regular Room", badge: "Value Stay", image: "", desc: "Standard rooms with essentials.", features: ["Non-AC"], price: "&#8377;3,000", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM", "ID card compulsory"] },
        { icon: "&#128101;", title: "Children & Booking", items: ["Up to 6 years: Complimentary", "6-12 years: 50% of adult rates", "50% advance to confirm booking"] },
        { icon: "&#128161;", title: "Good to Know", items: ["Tree House & Riverside Suite are AC, rest Non-AC", "Activities: Boating, Kayaking, Jacuzzi, Swimming, Nature Walk, Bird Watching, Fishing, Camp Fire"] },
      
'@
if (Update-Rooms "$basePath\hornbill_resort.html" $rooms) { Write-Host "ROOMS OK: hornbill_resort.html" } else { Write-Host "ROOMS FAIL: hornbill_resort.html" }
if (Update-Policies "$basePath\hornbill_resort.html" $policies) { Write-Host "POLICIES OK: hornbill_resort.html" } else { Write-Host "POLICIES FAIL: hornbill_resort.html" }

# ============ JUNGLE EDGE ============
$rooms = @'

        { name: "A-Shape Cottage", badge: "Unique Stay", image: "", desc: "A-frame cottage offering glamping experience.", features: ["Non-AC", "Unique Design"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Jungle View AC Premium Room", badge: "Best Pick", image: "", desc: "Premium AC rooms with jungle views.", features: ["AC", "Jungle View"], price: "<del>&#8377;2,200</del> &#8377;2,100", unit: "/ person" },
        { name: "Deluxe Rooms AC", badge: "Comfort", image: "", desc: "Well-appointed AC deluxe rooms.", features: ["AC"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando-style cottage.", features: ["Non-AC"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
        { name: "Camping Tent", badge: "Budget", image: "", desc: "Authentic camping experience.", features: ["Tent"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["1 Lunch, 1 Dinner, 1 Breakfast (Unlimited Buffet Veg & Non-Veg)", "Morning/Evening Tea/Coffee"] },
        { icon: "&#128683;", title: "Notes", items: ["Water activities 22km from resort", "Transport not included (extra cost)", "Sightseeing optional, entry charged at some places"] },
      
'@
if (Update-Rooms "$basePath\jungle_edge.html" $rooms) { Write-Host "ROOMS OK: jungle_edge.html" } else { Write-Host "ROOMS FAIL: jungle_edge.html" }
if (Update-Policies "$basePath\jungle_edge.html" $policies) { Write-Host "POLICIES OK: jungle_edge.html" } else { Write-Host "POLICIES FAIL: jungle_edge.html" }

# ============ RIVER POINT ============
$rooms = @'

        { name: "Deluxe Premium AC", badge: "Best Pick", image: "", desc: "Premium AC rooms.", features: ["AC", "Premium"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Standard Rooms", badge: "Comfort", image: "", desc: "Comfortable standard rooms.", features: ["Attached Bath"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Couple Rooms", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["AC", "Private"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation.", features: ["Shared Space"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Family Rooms", badge: "Family", image: "", desc: "Spacious family rooms.", features: ["Spacious"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Camping Tents", badge: "Adventure", image: "", desc: "Outdoor camping tents.", features: ["Tent"], price: "<del>&#8377;1,500</del> &#8377;1,300", unit: "/ person" },
        { name: "Commando Cottage River View", badge: "Unique", image: "", desc: "Commando-style cottage with river views.", features: ["River View"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["1 Lunch, 1 Dinner, 1 Breakfast (Unlimited Buffet Veg & Non-Veg)", "Morning/Evening Tea/Coffee"] },
        { icon: "&#128683;", title: "Notes", items: ["Water activities 22km from resort", "Transport not included (extra cost)", "Sightseeing optional"] },
      
'@
if (Update-Rooms "$basePath\riverpoint_resort.html" $rooms) { Write-Host "ROOMS OK: riverpoint_resort.html" } else { Write-Host "ROOMS FAIL: riverpoint_resort.html" }
if (Update-Policies "$basePath\riverpoint_resort.html" $policies) { Write-Host "POLICIES OK: riverpoint_resort.html" } else { Write-Host "POLICIES FAIL: riverpoint_resort.html" }

# ============ GREEN VALLEY ============
$rooms = @'

        { name: "Standard Cottage", badge: "Comfort", image: "", desc: "Comfortable standard cottages.", features: ["Attached Bath"], price: "<del>&#8377;2,200</del> &#8377;2,100", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation.", features: ["Shared Space"], price: "<del>&#8377;1,600</del> &#8377;1,550", unit: "/ person" },
        { name: "Tango Cottage", badge: "Unique", image: "", desc: "Unique cottage with rustic feel.", features: ["Attached Bath"], price: "<del>&#8377;1,700</del> &#8377;1,600", unit: "/ person" },
        { name: "Jungle Camping", badge: "Adventure", image: "", desc: "Camp under the stars.", features: ["Tent"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:30 AM", "Check-out: 10:30 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["3 Buffet Meals + Tea/Coffee", "Veg & Non-Veg Unlimited"] },
        { icon: "&#128101;", title: "Children & Rules", items: ["11+ years: Full charge", "6-11 years: Half charge", "Valid photo ID mandatory", "No pets allowed"] },
        { icon: "&#128683;", title: "Cancellation", items: ["Free cancellation up to 7 days before check-in", "No refund within 7 days"] },
      
'@
if (Update-Rooms "$basePath\green_valley_resort.html" $rooms) { Write-Host "ROOMS OK: green_valley_resort.html" } else { Write-Host "ROOMS FAIL: green_valley_resort.html" }
if (Update-Policies "$basePath\green_valley_resort.html" $policies) { Write-Host "POLICIES OK: green_valley_resort.html" } else { Write-Host "POLICIES FAIL: green_valley_resort.html" }

# ============ RIVER EDGE ============
$rooms = @'

        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "Spacious AC deluxe rooms.", features: ["AC", "Deluxe"], price: "&#8377;2,000", unit: "/ person" },
        { name: "AC Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard AC rooms.", features: ["AC"], price: "&#8377;1,800", unit: "/ person" },
        { name: "AC Dormitory", badge: "Group Stay", image: "", desc: "Shared AC accommodation.", features: ["AC", "Shared"], price: "&#8377;1,600", unit: "/ person" },
        { name: "Commando Camping Tent", badge: "Adventure", image: "", desc: "Commando-style camping.", features: ["Tent"], price: "&#8377;1,300", unit: "/ person" },
        { name: "Camping Tent", badge: "Budget", image: "", desc: "Basic camping tents.", features: ["Tent"], price: "&#8377;1,300", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Package", items: ["3 Unlimited Buffet Meals", "Water: Kayaking, Zorbing, Boating", "Rope: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Pool, Campfire, Archery, Trekking, Rain Dance"] },
        { icon: "&#128161;", title: "Sightseeing", items: ["Disney Park", "Nagoda Backwaters", "Moulangi Eco Park", "Supa Dam View Point"] },
        { icon: "&#128683;", title: "Timings", items: ["Water Sports: 8 AM-5 PM (25 km away)", "Trekking: 7-8 AM", "Rain Dance: 7:30-9 PM", "Pool: 9 AM-6 PM (Nylon mandatory)"] },
      
'@
if (Update-Rooms "$basePath\River Edge.html" $rooms) { Write-Host "ROOMS OK: River Edge.html" } else { Write-Host "ROOMS FAIL: River Edge.html" }
if (Update-Policies "$basePath\River Edge.html" $policies) { Write-Host "POLICIES OK: River Edge.html" } else { Write-Host "POLICIES FAIL: River Edge.html" }

# ============ DEW DROPS ============
$rooms = @'

        { name: "AC Deluxe Pool View Room", badge: "Best Pick", image: "", desc: "AC rooms with pool views.", features: ["AC", "Pool View"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Deluxe Forest View Room", badge: "Nature", image: "", desc: "AC rooms with forest views.", features: ["AC", "Forest View"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Premium Room", badge: "Premium", image: "", desc: "Premium AC accommodation.", features: ["AC", "Premium"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Family Room", badge: "Family", image: "", desc: "Spacious AC family rooms.", features: ["AC", "Family"], price: "&#8377;2,200", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando cottages.", features: ["Non-AC"], price: "&#8377;1,800", unit: "/ person" },
      
'@
$policies = @'

        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Package", items: ["3 Unlimited Buffet Meals", "Water: Kayaking, Zorbing, Boating", "Rope: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Pool, Campfire, Archery, Trekking, Rain Dance"] },
        { icon: "&#128683;", title: "Timings", items: ["Water Sports: 8 AM-5 PM", "Trekking: 7-8 AM", "Rain Dance: 7:30-9 PM", "Pool: 9 AM-6 PM (Nylon mandatory)"] },
      
'@
if (Update-Rooms "$basePath\dewDrops_resort.html" $rooms) { Write-Host "ROOMS OK: dewDrops_resort.html" } else { Write-Host "ROOMS FAIL: dewDrops_resort.html" }
if (Update-Policies "$basePath\dewDrops_resort.html" $policies) { Write-Host "POLICIES OK: dewDrops_resort.html" } else { Write-Host "POLICIES FAIL: dewDrops_resort.html" }

# ============ RAIN FOREST ============
$rooms = @'

        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "AC deluxe room with modern amenities.", features: ["AC", "Deluxe"], price: "&#8377;2,000", unit: "/ person" },
        { name: "Forest View Non-AC Room", badge: "Nature", image: "", desc: "Non-AC room with forest views.", features: ["Non-AC", "Forest View"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Couple Cottage", badge: "Romantic", image: "", desc: "Private cottage for couples.", features: ["Cozy", "Private"], price: "&#8377;1,900", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\rainForest_resort.html" $rooms) { Write-Host "ROOMS OK: rainForest_resort.html" } else { Write-Host "ROOMS FAIL: rainForest_resort.html" }

# ============ WILD WINGS ============
$rooms = @'

        { name: "Couple Cottage", badge: "Romantic", image: "", desc: "Private cottage for couples.", features: ["Cozy", "Private"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard room.", features: ["Attached Bath"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Forest View Room", badge: "Nature", image: "", desc: "Room with forest views.", features: ["Forest View"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando-style cottage.", features: ["Non-AC"], price: "&#8377;1,600", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\Wild Wings.html" $rooms) { Write-Host "ROOMS OK: Wild Wings.html" } else { Write-Host "ROOMS FAIL: Wild Wings.html" }

# ============ TUSKER TRAILS ============
$rooms = @'

        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "Premium AC deluxe room.", features: ["AC", "Deluxe"], price: "&#8377;2,200", unit: "/ person" },
        { name: "AC Wooden Cottage", badge: "Unique", image: "", desc: "Charming AC wooden cottages.", features: ["AC", "Wooden"], price: "&#8377;2,000", unit: "/ person" },
        { name: "AC Maharaja Cottage", badge: "Premium", image: "", desc: "Spacious Maharaja AC cottage.", features: ["AC", "Spacious"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Standard Room", badge: "Comfort", image: "", desc: "Standard room with essentials.", features: ["Attached Bath"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation.", features: ["Shared Space"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Camping Tent", badge: "Adventure", image: "", desc: "Outdoor camping.", features: ["Tent"], price: "&#8377;1,600", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\Tusker Trails.html" $rooms) { Write-Host "ROOMS OK: Tusker Trails.html" } else { Write-Host "ROOMS FAIL: Tusker Trails.html" }

# ============ TARANG HOMESTAY ============
$rooms = @'

        { name: "Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard homestay rooms.", features: ["Attached Bath"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private", "Cozy"], price: "<del>&#8377;2,500</del> &#8377;2,400", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\tarang_homestay.html" $rooms) { Write-Host "ROOMS OK: tarang_homestay.html" } else { Write-Host "ROOMS FAIL: tarang_homestay.html" }

# ============ SUNBIRD RESORT ============
$rooms = @'

        { name: "Room Stay", badge: "Comfort", image: "", desc: "Comfortable rooms with essentials.", features: ["Attached Bath"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private"], price: "<del>&#8377;2,400</del> &#8377;2,300", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\sunbird_resort.html" $rooms) { Write-Host "ROOMS OK: sunbird_resort.html" } else { Write-Host "ROOMS FAIL: sunbird_resort.html" }

# ============ WILD MIST ============
$rooms = @'

        { name: "Standard Rooms", badge: "Comfort", image: "", desc: "Standard rooms with essentials.", features: ["Attached Bath"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
        { name: "Maharaja Cottage", badge: "Premium", image: "", desc: "Spacious Maharaja cottages.", features: ["Spacious"], price: "<del>&#8377;1,500</del> &#8377;1,400", unit: "/ person" },
        { name: "Wooden Cottage", badge: "Rustic", image: "", desc: "Charming wooden cottages.", features: ["Wooden", "Cozy"], price: "<del>&#8377;1,500</del> &#8377;1,400", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared group accommodation.", features: ["Shared Space"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\Wild Mist.html" $rooms) { Write-Host "ROOMS OK: Wild Mist.html" } else { Write-Host "ROOMS FAIL: Wild Mist.html" }

# ============ BISON RIVER RESORT ============
$rooms = @'

        { name: "Deluxe Room", badge: "Comfort", image: "", desc: "Well-appointed deluxe rooms.", features: ["Attached Bath"], price: "<del>&#8377;2,500</del> &#8377;2,400", unit: "/ person" },
        { name: "Premium Room", badge: "Best Pick", image: "", desc: "Premium rooms with superior amenities.", features: ["Premium", "Spacious"], price: "<del>&#8377;3,000</del> &#8377;2,900", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\bison_resort.html" $rooms) { Write-Host "ROOMS OK: bison_resort.html" } else { Write-Host "ROOMS FAIL: bison_resort.html" }

# ============ WHISTLING WOODZS ============
$rooms = @'

        { name: "Executive Premium Cottages", badge: "Ultra Luxury", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-6.jpg", desc: "Top-tier suites with private balcony overlooking Kali river.", features: ["King Size Bed", "River View", "Private Balcony", "Bathtub", "Mini-bar"], price: "<del>&#8377;12,500</del> &#8377;11,625", unit: "/ night" },
        { name: "Penthouse Suite Room", badge: "Most Popular", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-8.jpg", desc: "Elevated living with river views and modern amenities.", features: ["Queen Bed", "Elevated Setup", "AC", "Private Sit-out"], price: "<del>&#8377;9,500</del> &#8377;8,699", unit: "/ night" },
        { name: "Family Cottage", badge: "Family Stay", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-19.jpg", desc: "Comfortable family cottage.", features: ["Comfortable Beds", "Nature Experience", "Fan"], price: "<del>&#8377;8,000</del> &#8377;6,999", unit: "/ night" },
        { name: "River Side Rooms", badge: "Adventure Stay", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-24.jpg", desc: "Rooms with direct river views.", features: ["River View", "Comfortable Beds"], price: "<del>&#8377;7,500</del> &#8377;6,499", unit: "/ night" },
        { name: "Executive Room", badge: "Luxury", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-30.jpg", desc: "Elegant executive rooms.", features: ["Comfortable Beds", "AC", "Attached Bath"], price: "<del>&#8377;6,950</del> &#8377;5,999", unit: "/ night" },
        { name: "Suite Room with Terrace", badge: "Premium Luxury", image: "images/Whistling Woods/hq_1.jpg", desc: "Suite with private terrace.", features: ["Terrace", "Suite", "Premium"], price: "<del>&#8377;9,000</del> &#8377;8,499", unit: "/ night" },
      
'@
if (Update-Rooms "$basePath\whistling_woods_resort.html" $rooms) { Write-Host "ROOMS OK: whistling_woods_resort.html" } else { Write-Host "ROOMS FAIL: whistling_woods_resort.html" }

# ============ WHITE WATER ============
$rooms = @'

        { name: "River View Room", badge: "Scenic", image: "", desc: "Rooms with river views.", features: ["River View"], price: "<del>&#8377;2,500</del> &#8377;2,199", unit: "/ person" },
        { name: "Family Room", badge: "Family", image: "", desc: "Spacious family rooms.", features: ["Spacious", "Family"], price: "<del>&#8377;3,000</del> &#8377;2,499", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private", "Cozy"], price: "<del>&#8377;3,500</del> &#8377;2,999", unit: "/ person" },
        { name: "Dorm Room", badge: "Budget", image: "", desc: "Shared accommodation.", features: ["Shared Space"], price: "<del>&#8377;2,000</del> &#8377;1,800", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\white_water_resort.html" $rooms) { Write-Host "ROOMS OK: white_water_resort.html" } else { Write-Host "ROOMS FAIL: white_water_resort.html" }

# ============ PALM MEADOWS ============
$rooms = @'

        { name: "AC Rooms", badge: "Comfort", image: "", desc: "Air-conditioned rooms with modern amenities.", features: ["AC", "Attached Bath"], price: "&#8377;2,500", unit: "/ person" },
        { name: "Non-AC Rooms", badge: "Value Stay", image: "", desc: "Comfortable non-AC rooms.", features: ["Non-AC", "Attached Bath"], price: "&#8377;2,000", unit: "/ person" },
      
'@
if (Update-Rooms "$basePath\palm_meadows_resort.html" $rooms) { Write-Host "ROOMS OK: palm_meadows_resort.html" } else { Write-Host "ROOMS FAIL: palm_meadows_resort.html" }

Write-Host "`n=== VERIFICATION ==="
$allFiles = Get-ChildItem "$basePath\*.html" | Where-Object { $_.Name -match "resort|cottage|edge|trails|homestay|Wings|Mist|Edge" }
foreach ($f in $allFiles) {
    $delCount = (Select-String -Pattern "<del>" -Path $f.FullName | Measure-Object).Count
    Write-Host "  $($f.Name): $delCount del-tags"
}
