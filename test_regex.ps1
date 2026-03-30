
$content = @'
<nav>
  <div class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"></div>
  <a href="index.html" class="logo"><span class="leaf">&#127807;</span> Book myDandeli</a>
</nav>
'@

$newLogoHtml = '<a href="index.html" class="logo"><img src="images/logo.png" alt="Book myDandeli" class="logo-img"><span class="logo-title">Book <em>myDandeli</em></span></a>'

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?is)<a[^>]*?class="logo"[^>]*?>.*?</a>', $newLogoHtml)
$content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?is)<div[^>]*?class="logo"[^>]*?>.*?</div>', $newLogoHtml)

Write-Host $content

