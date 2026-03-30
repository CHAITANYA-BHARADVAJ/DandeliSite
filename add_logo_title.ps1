$htmlFiles = Get-ChildItem -Filter *.html

$cssToInject = @"

/* ── LOGO TEXT STYLE ── */
.logo{text-decoration:none !important;}
.logo-title {
  margin-left: 8px;
  font-family: 'Cormorant Garamond', serif;
  font-size: 26px;
  font-weight: 700;
  letter-spacing: 0.5px;
  background: linear-gradient(135deg, var(--forest) 0%, var(--moss) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: flex;
  align-items: center;
  gap: 6px;
}
.logo-title em {
  background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-style: italic;
  font-weight: 600;
}
@media(max-width:600px){
  .logo-title { font-size: 20px; margin-left: 4px; gap: 4px; }
}
"@

$newLogoHtml = '<a href="index.html" class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"><span class="logo-title">Book <em>myDandeli</em></span></a>'

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw

    # Inject CSS before </style>
    if ($content -notmatch "\.logo-title \{") {
        $content = $content -replace "</style>", "$cssToInject`n</style>"
    }

    # Replace logo HTML
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?is)<a[^>]*?class="logo"[^>]*?>.*?</a>', $newLogoHtml)
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?is)<div[^>]*?class="logo"[^>]*?>.*?</div>', $newLogoHtml)

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}
Write-Host "Updated all HTML files with new logo text and style!"
