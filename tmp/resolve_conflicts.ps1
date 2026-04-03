$file = "d:\Antigravity\DandeliSite\family-packages.html"
$content = Get-Content -Raw -Encoding UTF8 $file

# Remove conflict markers and keep HEAD
# We match <<<<<<< HEAD\n(content)\n=======\n(other content)\n>>>>>>> hash
# and replace it with just (content)
$content = [regex]::Replace($content, "(?s)<<<<<<< HEAD\r?\n(.*?)\r?\n=======\r?\n.*?\r?\n>>>>>>> [a-f0-9]+\r?\n", "`$1`r`n")

[IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Resolved merge conflicts!"
