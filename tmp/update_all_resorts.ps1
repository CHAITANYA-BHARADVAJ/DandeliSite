# Resort Data Update Script
# Updates the rooms array and policies in each resort's RESORT JS object
# Uses the data from resort_data_clean.txt

$basePath = "d:\Antigravity\DandeliSite"

function Update-ResortSection {
    param(
        [string]$FilePath,
        [string]$OldRoomsPattern,
        [string]$NewRooms,
        [string]$OldPoliciesPattern,
        [string]$NewPolicies,
        [string]$OldPricePattern,
        [string]$NewPrice,
        [string]$OldAmenitiesPattern,
        [string]$NewAmenities
    )
    
    $content = [System.IO.File]::ReadAllText($FilePath)
    $original = $content

    if ($NewRooms) {
        $content = [regex]::Replace($content, $OldRoomsPattern, $NewRooms, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    }
    if ($NewPolicies) {
        $content = [regex]::Replace($content, $OldPoliciesPattern, $NewPolicies, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    }
    if ($NewPrice) {
        $content = [regex]::Replace($content, $OldPricePattern, $NewPrice, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    }
    if ($NewAmenities) {
        $content = [regex]::Replace($content, $OldAmenitiesPattern, $NewAmenities, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    }

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($FilePath, $content)
        Write-Host "UPDATED: $([System.IO.Path]::GetFileName($FilePath))"
    } else {
        Write-Host "NO CHANGE: $([System.IO.Path]::GetFileName($FilePath))"
    }
}

# ============ SWAYAM COTTAGE ============
$f = "$basePath\swayam_cottage.html"
$c = [System.IO.File]::ReadAllText($f)
# Update rooms
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Cottage Room", badge: "Cozy Stay", image: "", desc: "Comfortable cottage rooms nestled in nature.", features: ["Attached Bath", "WiFi"], price: "<del>&#8377;1,800</del> &#8377;1,699", unit: "/ person" },
        { name: "Dormitory", badge: "Budget Stay", image: "", desc: "Affordable dormitory-style accommodation for groups.", features: ["Shared Space", "WiFi"], price: "<del>&#8377;1,800</del> &#8377;1,699", unit: "/ person" },
      ],$1')
# Update policies
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 01:00 PM", "Check-out: 11:00 AM", "Aadhar card compulsory for all guests"] },
        { icon: "&#128101;", title: "Children Policy", items: ["Children below 5 years: Free of cost", "Children 5\u201310 years: 50% charges", "Children above 10 years: Full adult charges"] },
        { icon: "&#128683;", title: "Important Notes", items: ["Sightseeing entry fees & transportation extra", "All activities depend on weather & water level"] },
      ],$1')
# Update price
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,699",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;1,800",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: swayam_cottage.html"

# ============ LAGUNA RESORT ============  
$f = "$basePath\laguna_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "River View Cottage", badge: "Best Pick", image: "", desc: "Beautiful cottage with river views and modern amenities.", features: ["River View", "Attached Bath"], price: "<del>&#8377;3,500</del> &#8377;3,200", unit: "/ person" },
        { name: "Jungle View Cottage", badge: "Nature Stay", image: "", desc: "Cottage surrounded by lush jungle with scenic views.", features: ["Jungle View", "Attached Bath"], price: "<del>&#8377;3,500</del> &#8377;3,200", unit: "/ person" },
        { name: "Bamboo Cottage", badge: "Premium", image: "", desc: "Unique bamboo cottages offering a rustic luxury experience.", features: ["Bamboo Finish", "Premium"], price: "<del>&#8377;4,000</del> &#8377;3,600", unit: "/ person" },
        { name: "Dormitory", badge: "Budget Stay", image: "", desc: "Affordable shared accommodation for groups and backpackers.", features: ["Shared Space"], price: "<del>&#8377;2,800</del> &#8377;2,500", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM"] },
        { icon: "&#128101;", title: "Children Policy", items: ["Children 5 to 12 years: 50% charges", "Booking confirmed on advance receipt"] },
        { icon: "&#128683;", title: "Cancellation", items: ["No cancellation, No refund", "Balance amount to be paid before check-in"] },
        { icon: "&#127860;", title: "Meal Timings", items: ["Breakfast: 9:00 AM to 10:00 AM", "Lunch: 1:30 PM to 3:00 PM", "Dinner: 9:30 PM to 10:30 PM", "Buffet closes after designated time"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;2,500",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;3,500",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: laguna_resort.html"

# ============ HORNBILL RESORT ============
$f = "$basePath\hornbill_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Tree House", badge: "Ultra Luxury", image: "", desc: "Elevated tree house with AC, offering a unique forest canopy experience.", features: ["AC", "Elevated", "Premium"], price: "&#8377;5,100", unit: "/ person" },
        { name: "River View Cottages", badge: "Best Pick", image: "", desc: "Comfortable cottages with scenic river views.", features: ["River View", "Attached Bath"], price: "&#8377;4,250", unit: "/ person" },
        { name: "Rock Houses", badge: "Unique Stay", image: "", desc: "Distinctive rock-themed cottages blending with natural surroundings.", features: ["Non-AC", "Attached Bath"], price: "&#8377;3,800", unit: "/ person" },
        { name: "Deluxe Cottages", badge: "Comfort", image: "", desc: "Well-appointed cottages with couple bed and single bed.", features: ["Non-AC", "Attached Bath"], price: "&#8377;3,400", unit: "/ person" },
        { name: "Regular Room", badge: "Value Stay", image: "", desc: "Standard rooms with all essential amenities.", features: ["Non-AC", "Attached Bath"], price: "&#8377;3,000", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM", "Identity card compulsory at check-in"] },
        { icon: "&#128101;", title: "Children & Booking", items: ["Children up to 6 years: Complimentary", "Children 6 to 12 years: 50% of adult rates", "50% advance required to confirm booking"] },
        { icon: "&#128161;", title: "Good to Know", items: ["Tree House and Riverside Suite are AC, all other cottages Non-AC", "All cottages have 1 Couple Bed & Single Bed with washroom", "Activities: Boating, Kayaking, Jacuzzi, Swimming, Nature Walk, Bird Watching, Fishing, Camp Fire"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;3,000",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;5,100",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: hornbill_resort.html"

# ============ JUNGLE EDGE ============
$f = "$basePath\jungle_edge.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "A-Shape Cottage", badge: "Unique Stay", image: "", desc: "Distinctive A-frame cottage offering a cozy glamping experience.", features: ["Non-AC", "Unique Design"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Jungle View AC Premium Room", badge: "Best Pick", image: "", desc: "Premium air-conditioned rooms with stunning jungle views.", features: ["AC", "Jungle View", "Premium"], price: "<del>&#8377;2,200</del> &#8377;2,100", unit: "/ person" },
        { name: "Deluxe Rooms AC", badge: "Comfort", image: "", desc: "Well-appointed deluxe rooms with air conditioning.", features: ["AC", "Attached Bath"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando-style cottage for adventure seekers.", features: ["Non-AC", "Rustic"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
        { name: "Camping Tent", badge: "Budget", image: "", desc: "Authentic camping experience in secure tents.", features: ["Tent", "Basic"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["1 Lunch, 1 Dinner, 1 Breakfast (Unlimited Buffet)", "Veg & Non-Veg options", "Morning/Evening Tea/Coffee included"] },
        { icon: "&#128683;", title: "Important Notes", items: ["Water activities location approx 22km from resort", "Transportation not included (available at extra cost)", "Sightseeing is optional with own transport; entry may be charged"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,300",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,200",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: jungle_edge.html"

# ============ RIVER POINT ============
$f = "$basePath\riverpoint_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Deluxe Premium AC", badge: "Best Pick", image: "", desc: "Premium air-conditioned rooms with top-tier amenities.", features: ["AC", "Premium", "Attached Bath"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Standard Rooms", badge: "Comfort", image: "", desc: "Comfortable standard rooms with essential amenities.", features: ["Attached Bath"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Couple Rooms", badge: "Romantic", image: "", desc: "Specially designed rooms for couples.", features: ["AC", "Private"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation for groups.", features: ["Shared Space"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Family Rooms", badge: "Family", image: "", desc: "Spacious rooms designed for families.", features: ["Spacious"], price: "<del>&#8377;1,800</del> &#8377;1,700", unit: "/ person" },
        { name: "Camping Tents", badge: "Adventure", image: "", desc: "Outdoor camping tents for nature lovers.", features: ["Tent", "Basic"], price: "<del>&#8377;1,500</del> &#8377;1,300", unit: "/ person" },
        { name: "Commando Cottage River View", badge: "Unique", image: "", desc: "Commando-style cottage with river views.", features: ["River View"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["1 Lunch, 1 Dinner, 1 Breakfast (Unlimited Buffet)", "Veg & Non-Veg options", "Morning/Evening Tea/Coffee"] },
        { icon: "&#128683;", title: "Important Notes", items: ["Water activities location approx 22km from resort", "Transportation not included (available at extra cost)", "Sightseeing optional with own transport"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,300",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,000",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: riverpoint_resort.html"

# ============ GREEN VALLEY ============
$f = "$basePath\green_valley_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Standard Cottage", badge: "Comfort", image: "", desc: "Comfortable standard cottages surrounded by lush greenery.", features: ["Attached Bath"], price: "<del>&#8377;2,200</del> &#8377;2,100", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation ideal for groups.", features: ["Shared Space"], price: "<del>&#8377;1,600</del> &#8377;1,550", unit: "/ person" },
        { name: "Tango Cottage", badge: "Unique", image: "", desc: "Unique cottage with a cozy rustic feel.", features: ["Attached Bath"], price: "<del>&#8377;1,700</del> &#8377;1,600", unit: "/ person" },
        { name: "Jungle Camping", badge: "Adventure", image: "", desc: "Camp under the stars in the jungle.", features: ["Tent", "Basic"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:30 AM", "Check-out: 10:30 AM"] },
        { icon: "&#127860;", title: "Meals", items: ["3 Buffet Meals + Tea/Coffee included", "Veg & Non-Veg Unlimited"] },
        { icon: "&#128101;", title: "Children & Rules", items: ["11 years and above: Full charge", "6 to 11 years: Half charge", "Valid photo ID mandatory at check-in", "No pets allowed"] },
        { icon: "&#128683;", title: "Cancellation", items: ["Free cancellation up to 7 days before check-in", "No refund if cancelled within 7 days"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,300",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,200",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: green_valley_resort.html"

# ============ RIVER EDGE ============
$f = "$basePath\River Edge.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "Spacious air-conditioned deluxe rooms.", features: ["AC", "Deluxe"], price: "&#8377;2,000", unit: "/ person" },
        { name: "AC Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard AC rooms.", features: ["AC", "Standard"], price: "&#8377;1,800", unit: "/ person" },
        { name: "AC Dormitory", badge: "Group Stay", image: "", desc: "Shared AC accommodation for groups.", features: ["AC", "Shared"], price: "&#8377;1,600", unit: "/ person" },
        { name: "Commando Camping Tent", badge: "Adventure", image: "", desc: "Commando-style camping tents.", features: ["Tent"], price: "&#8377;1,300", unit: "/ person" },
        { name: "Camping Tent", badge: "Budget", image: "", desc: "Basic camping tents for nature lovers.", features: ["Tent", "Basic"], price: "&#8377;1,300", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals & Activities", items: ["3 Unlimited Buffet Meals (Lunch, Dinner, Breakfast)", "Water Activities: Kayaking, Zorbing, Boating", "Rope Activities: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Swimming Pool, Campfire, Archery, Jungle Trekking, Rain Dance"] },
        { icon: "&#128161;", title: "Sightseeing Included", items: ["Disney Park", "Nagoda Backwaters", "Moulangi Eco Park", "Supa Dam View Point"] },
        { icon: "&#128683;", title: "Activity Timings", items: ["Water Sports: 8 AM to 5 PM (25 km from Dandeli)", "Morning Trekking: 7 AM to 8 AM", "Rain Dance: 7:30 PM to 9:00 PM", "Swimming Pool: 9 AM to 6 PM (Nylon clothing mandatory)"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,300",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,000",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: River Edge.html"

# ============ DEW DROPS ============
$f = "$basePath\dewDrops_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "AC Deluxe Pool View Room", badge: "Best Pick", image: "", desc: "Air-conditioned rooms with stunning pool views.", features: ["AC", "Pool View"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Deluxe Forest View Room", badge: "Nature", image: "", desc: "AC rooms overlooking the forest canopy.", features: ["AC", "Forest View"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Premium Room", badge: "Premium", image: "", desc: "Premium air-conditioned accommodation.", features: ["AC", "Premium"], price: "&#8377;2,500", unit: "/ person" },
        { name: "AC Family Room", badge: "Family", image: "", desc: "Spacious AC rooms for families.", features: ["AC", "Family Size"], price: "&#8377;2,200", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando-style cottages.", features: ["Non-AC", "Rustic"], price: "&#8377;1,800", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals & Activities", items: ["3 Unlimited Buffet Meals", "Water Activities: Kayaking, Zorbing, Boating", "Rope Activities: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Swimming Pool, Campfire, Archery, Jungle Trekking, Rain Dance"] },
        { icon: "&#128683;", title: "Activity Notes", items: ["Water Sports: 8 AM to 5 PM (25 km from Dandeli)", "Morning Trekking: 7 AM to 8 AM", "Rain Dance: 7:30 PM to 9:00 PM", "Swimming Pool: 9 AM to 6 PM (Nylon clothing mandatory)"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,800",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,500",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: dewDrops_resort.html"

# ============ RAIN FOREST ============
$f = "$basePath\rainForest_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "Air-conditioned deluxe room with modern amenities.", features: ["AC", "Deluxe"], price: "&#8377;2,000", unit: "/ person" },
        { name: "Forest View Non-AC Room", badge: "Nature", image: "", desc: "Non-AC room with beautiful forest views.", features: ["Non-AC", "Forest View"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Couple Cottage", badge: "Romantic", image: "", desc: "Private cottage designed for couples.", features: ["Cozy", "Private"], price: "&#8377;1,900", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Meals & Activities", items: ["3 Unlimited Buffet Meals", "Water: Kayaking, Zorbing, Boating", "Rope: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Swimming Pool, Campfire, Archery, Trekking, Rain Dance"] },
        { icon: "&#128683;", title: "Activity Notes", items: ["Water Sports: 8 AM to 5 PM", "Trekking: 7 AM to 8 AM", "Swimming Pool: 9 AM to 6 PM"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,800",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,000",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: rainForest_resort.html"

# ============ WILD WINGS ============
$f = "$basePath\Wild Wings.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Couple Cottage", badge: "Romantic", image: "", desc: "Private cottage for couples.", features: ["Cozy", "Private"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard room.", features: ["Attached Bath"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Forest View Room", badge: "Nature", image: "", desc: "Room with scenic forest views.", features: ["Forest View"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Commando Cottage", badge: "Adventure", image: "", desc: "Rustic commando-style cottage.", features: ["Non-AC", "Rustic"], price: "&#8377;1,600", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Package Includes", items: ["3 Unlimited Buffet Meals (Veg & Non-Veg)", "Water: Kayaking, Zorbing, Boating", "In-House: Swimming Pool, Campfire, Archery, Rain Dance, Jungle Trekking"] },
        { icon: "&#128683;", title: "Notes", items: ["Water activities 25 km from resort", "Transportation not included", "Sightseeing optional"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,600",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;1,800",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: Wild Wings.html"

# ============ TUSKER TRAILS ============
$f = "$basePath\Tusker Trails.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "AC Deluxe Room", badge: "Best Pick", image: "", desc: "Premium air-conditioned deluxe room.", features: ["AC", "Deluxe"], price: "&#8377;2,200", unit: "/ person" },
        { name: "AC Wooden Cottage", badge: "Unique", image: "", desc: "Charming wooden cottages with AC.", features: ["AC", "Wooden"], price: "&#8377;2,000", unit: "/ person" },
        { name: "AC Maharaja Cottage", badge: "Premium", image: "", desc: "Spacious Maharaja-style AC cottage.", features: ["AC", "Spacious"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Standard Room", badge: "Comfort", image: "", desc: "Standard room with all essentials.", features: ["Attached Bath"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation for groups.", features: ["Shared Space"], price: "&#8377;1,800", unit: "/ person" },
        { name: "Camping Tent", badge: "Adventure", image: "", desc: "Outdoor camping experience.", features: ["Tent", "Basic"], price: "&#8377;1,600", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Package", items: ["3 Unlimited Buffet Meals (Veg & Non-Veg)", "Water: Kayaking, Zorbing, Boating", "Rope: Zig Zag Bridge, Quake Walk, Hanging Log", "In-House: Swimming Pool, Campfire, Archery, Trekking, Rain Dance"] },
        { icon: "&#128683;", title: "Notes", items: ["Water activities 25 km from resort", "Transportation not included", "Pool: 9 AM to 6 PM (Nylon clothing mandatory)"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,600",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,200",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: Tusker Trails.html"

# ============ TARANG HOMESTAY ============
$f = "$basePath\tarang_homestay.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Standard Room", badge: "Comfort", image: "", desc: "Comfortable standard rooms for a cozy homestay experience.", features: ["Attached Bath"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms designed for couples.", features: ["Private", "Cozy"], price: "<del>&#8377;2,500</del> &#8377;2,400", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#127860;", title: "Package Includes", items: ["Unlimited Buffet: Lunch (Veg), Dinner (Veg & Non-Veg), Breakfast", "Water: Boating, Kayaking, Swimming, Zorbing, Short Rafting, Zipline", "Indoor: Swimming Pool, Rain Dance, Fire Camp, Nature Walk, Music, Archery, Badminton, Chess, Carrom"] },
        { icon: "&#128683;", title: "Notes", items: ["25% advance to confirm booking", "Traveling charges not included", "Rafting depends on water level", "Children 5 to 10 years: 50% charges", "Transportation for activities & sightseeing at extra cost"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,900",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,500",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: tarang_homestay.html"

# ============ SUNBIRD RESORT ============
$f = "$basePath\sunbird_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Room Stay", badge: "Comfort", image: "", desc: "Comfortable rooms with all essential amenities.", features: ["Attached Bath"], price: "<del>&#8377;2,000</del> &#8377;1,900", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private", "Cozy"], price: "<del>&#8377;2,400</del> &#8377;2,300", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#127860;", title: "Package Includes", items: ["Unlimited Buffet: Lunch (Veg), Dinner (Veg & Non-Veg), Breakfast", "Water: Boating, Kayaking, Swimming, Zorbing, Short Rafting, Zipline", "Indoor: Swimming Pool, Rain Dance, Fire Camp, Nature Walk, Music, Archery, Badminton, Chess, Carrom"] },
        { icon: "&#128683;", title: "Notes", items: ["25% advance to confirm booking", "Traveling charges not included", "Rafting depends on water level", "Children 5 to 10 years: 50% charges"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,900",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,400",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: sunbird_resort.html"

# ============ WILD MIST ============
$f = "$basePath\Wild Mist.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Standard Rooms", badge: "Comfort", image: "", desc: "Standard rooms with all essential amenities.", features: ["Attached Bath"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
        { name: "Maharaja Cottage", badge: "Premium", image: "", desc: "Spacious Maharaja-style cottages.", features: ["Spacious"], price: "<del>&#8377;1,500</del> &#8377;1,400", unit: "/ person" },
        { name: "Wooden Cottage", badge: "Rustic", image: "", desc: "Charming wooden cottages.", features: ["Wooden", "Cozy"], price: "<del>&#8377;1,500</del> &#8377;1,400", unit: "/ person" },
        { name: "Dormitory", badge: "Budget", image: "", desc: "Shared accommodation for groups.", features: ["Shared Space"], price: "<del>&#8377;1,400</del> &#8377;1,300", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private"], price: "<del>&#8377;1,600</del> &#8377;1,500", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 11:00 AM", "Check-out: 10:00 AM"] },
        { icon: "&#127860;", title: "Package", items: ["1 Night Stay, 12 Activities", "Buffet Meals (Veg & Non-Veg): 1 Lunch, 1 Dinner, 1 Breakfast", "Transportation NOT included"] },
        { icon: "&#128101;", title: "Children", items: ["Children 5-10 years: 50% charges", "Kids below 5 years: Complimentary"] },
        { icon: "&#128683;", title: "Activities", items: ["Water: Boating, Kayaking, Zorbing", "Rope: Zig-Zag Bridge, Quake Walk, Hanging Log", "Resort: Jungle Trekking, Rain Dance, Night Campfire, Music, Archery, Swimming"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,300",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;1,600",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: Wild Mist.html"

# ============ BISON RIVER RESORT ============
$f = "$basePath\bison_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Deluxe Room", badge: "Comfort", image: "", desc: "Well-appointed deluxe rooms.", features: ["Attached Bath"], price: "<del>&#8377;2,500</del> &#8377;2,400", unit: "/ person" },
        { name: "Premium Room", badge: "Best Pick", image: "", desc: "Premium rooms with superior amenities.", features: ["Premium", "Spacious"], price: "<del>&#8377;3,000</del> &#8377;2,900", unit: "/ person" },
      ],$1')
$c = $c -replace 'policies: \[.*?\],(\s*address:)', ('policies: [
        { icon: "&#128197;", title: "Check-in & Rules", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM", "Valid photo ID mandatory", "No pets permitted", "Room service not available"] },
        { icon: "&#128101;", title: "Children & Guests", items: ["Children below 5: Complementary", "Children below 10: Half charge", "Booking confirmed on 100% advance", "No refund on cancellation or no show"] },
        { icon: "&#128161;", title: "Good to Know", items: ["Sightseeing transport & entry fees extra", "Swimming costume/nylon compulsory for pool", "Rafting subject to water level", "Driver meals at staff cafeteria (Free)", "Meal Timings: Lunch 1:30-3 PM, Dinner 8:30-10 PM, Breakfast 9-10 AM"] },
        { icon: "&#127993;", title: "Activities", items: ["Water: Boating, Zorbing, Kayaking, River Swimming, Surfing", "Indoor: Carrom, Chess, Ludo, Archery, Cricket, Badminton, Volleyball, Dart Board", "Group: Nature Walk, Bird Watching, Star Gazing, Karaoke (on request)"] },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;2,400",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;3,000",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: bison_resort.html"

# ============ WHISTLING WOODZS ============
$f = "$basePath\whistling_woods_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "Executive Premium Cottages", badge: "Ultra Luxury", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-6.jpg", desc: "Top-tier suites with spacious layout, premium bedding, and private balcony overlooking the Kali river.", features: ["King Size Bed", "River View", "Private Balcony", "Bathtub", "Mini-bar"], price: "<del>&#8377;12,500</del> &#8377;11,625", unit: "/ night" },
        { name: "Penthouse Suite Room", badge: "Most Popular", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-8.jpg", desc: "Elevated living amidst the branches with river views and modern amenities.", features: ["Queen Bed", "Elevated Setup", "AC", "Private Sit-out"], price: "<del>&#8377;9,500</del> &#8377;8,699", unit: "/ night" },
        { name: "Family Cottage", badge: "Family Stay", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-19.jpg", desc: "Comfortable family cottage with all essential amenities.", features: ["Comfortable Beds", "Shared Bathrooms", "Nature Experience", "Fan"], price: "<del>&#8377;8,000</del> &#8377;6,999", unit: "/ night" },
        { name: "River Side Rooms", badge: "Adventure Stay", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-24.jpg", desc: "Rooms with direct river views for a serene stay.", features: ["River View", "Comfortable Beds", "Nature Experience"], price: "<del>&#8377;7,500</del> &#8377;6,499", unit: "/ night" },
        { name: "Executive Room", badge: "Luxury", image: "images/Whistling Woods/WWZ WhatsApp Cataloge_Sep 2025-images-30.jpg", desc: "Elegant executive rooms with premium furnishings.", features: ["Comfortable Beds", "AC", "Attached Bath"], price: "<del>&#8377;6,950</del> &#8377;5,999", unit: "/ night" },
        { name: "Suite Room with Terrace", badge: "Premium Luxury", image: "images/Whistling Woods/hq_1.jpg", desc: "Suite room with private terrace for exclusive relaxation.", features: ["Terrace", "Suite", "Premium"], price: "<del>&#8377;9,000</del> &#8377;8,499", unit: "/ night" },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;5,999",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;6,950",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: whistling_woods_resort.html"

# ============ WHITE WATER ============
$f = "$basePath\white_water_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "River View Room", badge: "Scenic", image: "", desc: "Rooms with beautiful river views.", features: ["River View", "Attached Bath"], price: "<del>&#8377;2,500</del> &#8377;2,199", unit: "/ person" },
        { name: "Family Room", badge: "Family", image: "", desc: "Spacious rooms for families.", features: ["Spacious", "Family"], price: "<del>&#8377;3,000</del> &#8377;2,499", unit: "/ person" },
        { name: "Couple Room", badge: "Romantic", image: "", desc: "Private rooms for couples.", features: ["Private", "Cozy"], price: "<del>&#8377;3,500</del> &#8377;2,999", unit: "/ person" },
        { name: "Dorm Room", badge: "Budget", image: "", desc: "Shared accommodation for budget travelers.", features: ["Shared Space"], price: "<del>&#8377;2,000</del> &#8377;1,800", unit: "/ person" },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;1,800",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,500",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: white_water_resort.html"

# ============ PALM MEADOWS ============
$f = "$basePath\palm_meadows_resort.html"
$c = [System.IO.File]::ReadAllText($f)
$c = $c -replace 'rooms: \[.*?\],(\s*activities:)', ('rooms: [
        { name: "AC Rooms", badge: "Comfort", image: "", desc: "Air-conditioned rooms with modern amenities.", features: ["AC", "Attached Bath"], price: "&#8377;2,500", unit: "/ person" },
        { name: "Non-AC Rooms", badge: "Value Stay", image: "", desc: "Comfortable non-AC rooms at a budget-friendly price.", features: ["Non-AC", "Attached Bath"], price: "&#8377;2,000", unit: "/ person" },
      ],$1')
$c = $c -replace 'price: "&#8377;[\d,]+",(\s*priceUnit:)', 'price: "&#8377;2,000",$1'
$c = $c -replace 'priceCrossed: "&#8377;[\d,]+",', 'priceCrossed: "&#8377;2,500",'
[System.IO.File]::WriteAllText($f, $c)
Write-Host "UPDATED: palm_meadows_resort.html"

Write-Host "`n=== ALL RESORTS UPDATED ==="
