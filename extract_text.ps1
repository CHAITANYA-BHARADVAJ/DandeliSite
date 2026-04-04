$xml = Get-Content -Path "D:\Antigravity\DandeliSite\extract\word\document.xml" -Raw
$text = [regex]::Replace($xml, '<w:p[^>]*>', "`r`n")
$text = [regex]::Replace($text, '<[^>]+>', '')
$text = [System.Net.WebUtility]::HtmlDecode($text)
$text | Out-File -FilePath "D:\Antigravity\DandeliSite\resort_data_clean.txt" -Encoding utf8
"Extraction complete"
