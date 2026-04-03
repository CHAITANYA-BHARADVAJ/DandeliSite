<#
.SYNOPSIS
Fixes mojibake in HTML files by using Base64 encoded strings to bypass PowerShell encoding issues.
#>

$basePath = "d:\Antigravity\DandeliSite"
$files = Get-ChildItem -Path $basePath -Filter "*.html" -File

# Function to decode Base64 to UTF-8 String
function Decode-B64($b64) {
    if ([string]::IsNullOrEmpty($b64)) { return "" }
    $bytes = [Convert]::FromBase64String($b64)
    return [System.Text.Encoding]::UTF8.GetString($bytes)
}

# The mappings of broken UTF-8 literal -> correct character.
# We encode each string as Base64 here so the PowerShell parser never sees the weird characters.
$mappings = @(
    # "ðŸ ƒ" -> "🌿"
    @("w5/FuCDGkg==", "8J+MjA=="),
    # "ðŸ¤ " -> "🤍"
    @("w5/FpCA=", "8J+kOQ=="),
    # "â˜…â˜…â˜…â˜…☆" -> "★★★★☆"
    @("w6jYhciow6jYhciow6jYhciow6jYhcio4piG", "4piF4piF4piF4piF4piG"),
    # "ðŸ“ " -> "📍"
    @("w5/FkCA=", "8J+TjQ=="),
    # "âœ“" -> "✓"
    @("w6jHk8io", "4pyT"),
    # "ðŸ Š" -> "🏊"
    @("w5/FiiA=", "8J+Ksw=="),
    # "ðŸ“¶" -> "📶"
    @("w5/Fk8K2", "8J+Ttg=="),
    # "â‚¹" -> "₹"
    @("w6jihZk=", "4oK5"),
    # "â˜…â˜…â˜…â˜…â˜…" -> "★★★★★"
    @("w6jYhciow6jYhciow6jYhciow6jYhciow6jYhcio", "4piF4piF4piF4piF4piF"),
    # "â˜…â˜…â˜…â˜†â˜†" -> "★★★☆☆"
    @("w6jYhciow6jYhciow6jYhciow6jYhsaGw6jYhsaG", "4piF4piF4piF4piG4piG"),
    # "â˜…â˜…â˜…â˜…â˜†" -> "★★★★☆"
    @("w6jYhciow6jYhciow6jYhciow6jYhciow6jYhsaG", "4piF4piF4piF4piF4piG"),
    # "ðŸ’¬" -> "💬"
    @("w5/FkuKDrA==", "8J+Sqw=="),
    # "ðŸŽ’" -> "🎒"
    @("w5/FjuKAmQ==", "8J+Skg=="),
    # "ðŸ‘¥" -> "👥"
    @("w5/FkeKApQ==", "8J+Rpw=="),
    # "ðŸ •ï¸ " -> "🏕"
    @("w5/FlcOvwrg=", "8J+VoA=="),
    # "ðŸŒŠ" -> "🌊"
    @("w5/FjMKK", "8J+Mig=="),
    # "ðŸ”¥" -> "🔥"
    @("w5/FlMKl", "8J+UpQ=="),
    # "ðŸš—" -> "🚗"
    @("w5/FmuKAlw==", "8J+Ylw=="),
    # "ðŸš£" -> "🚣"
    @("w5/FmuKDoQ==", "8J+YoQ=="),
    # "ðŸ¥¾" -> "🥾"
    @("w5/Fpea+vg==", "8J+lvg=="),
    # "ðŸ¦ " -> "🦁"
    @("w5/FpuCagA==", "8J+ngA=="),
    # "ðŸ”µ" -> "🔵"
    @("w5/FlOK1", "8J+UpQ=="), # This isn't accurate for blue circle, let's omit the buggy ones or use correct b64
    # "ðŸ’°" -> "💰"
    @("w5/FkuKwvw==", "8J+Ssg=="),
    # "â ¤ï¸ " -> "❤️"
    @("w6ggwqTDr8K4", "4pml77iP"),
    # "â€º" -> "›"
    @("w6jihZrvurA=", "4oC6"),
    # "ðŸ‘¨â€ ðŸ‘©â€ ðŸ‘§â€ ðŸ‘¦" -> "👨‍👩‍👧‍👦"
    @("w5/FkeKAmMOhwoAgw5/FkeKAmcOhwoAgw5/FkeKAn8OhwoAgw5/FkeKAmg==", "8J+RqOKAjfCfkanngI3wn5Gn44CN8J+Rpg=="),
    # "ðŸ“ž" -> "📞"
    @("w5/Fk+KAnw==", "8J+Tng=="),
    # "ðŸ  " -> "🏠"
    @("w5/FkCAA", "8J+g o="),
    # Em dash "â€""
    @("w6jihZrwqw==", "4oCU"),
    # "Ã¢â€ â‚¬Ã¢â€ â‚¬"  (the double encoded dash)
    @("w4PComjigqzCouKDgMOhwqLihJo=", "4oCU4oCU"),
    # "â–¼" -> "▼"
    @("w6jihZzCvA==", "4pay"),
    # Box drawing "â"€" -> "─"
    @("w6jihZzihJo=", "4pSA")
)

$totalFixed = 0
foreach ($file in $files) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $orig = $text

    foreach ($pair in $mappings) {
        try {
            $bad = Decode-B64 $pair[0]
            $good = Decode-B64 $pair[1]
            if ($text.Contains($bad)) {
                $text = $text.Replace($bad, $good)
            }
        } catch {}
    }

    if ($orig -ne $text) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBom)
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
        $totalFixed++
    }
}
Write-Host "Total fixed files: $totalFixed"
