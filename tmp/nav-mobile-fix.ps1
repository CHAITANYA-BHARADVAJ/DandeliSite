$files = Get-ChildItem -Path d:\Antigravity\DandeliSite -Filter *.html -File
$inject = @"
  <!-- nav-mobile-fix -->
  <style>
    @media(max-width: 600px) {
      .nav-right { gap: 6px !important; }
      .nav-phone, .rl-nav-phone { white-space: nowrap !important; font-size: 13px !important; letter-spacing: -0.2px !important; }
      .nav-wa, .rl-nav-wa { display: none !important; }
      .logo-title { font-size: 18px !important; }
    }
  </style>
</head>
"@

foreach ($f in $files) {
    if ($f.Name -eq 'tarang_homestay.html') { Write-Host "Processing $($f.Name)..." }
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    if ($content -match '</head>' -and $content -notmatch 'nav-mobile-fix') {
        $content = $content -replace '</head>', $inject
        [IO.File]::WriteAllText($f.FullName, $content, (New-Object System.Text.UTF8Encoding($true)))
    }
}
Write-Host "Done!"
