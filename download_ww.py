import urllib.request, re, os, ssl
os.makedirs('images/Whistling Woods', exist_ok=True)
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
req = urllib.request.Request('https://whistlingwoodzs.com/', headers={'User-Agent': 'Mozilla/5.0'})
with urllib.request.urlopen(req, context=ctx) as r:
    html = r.read().decode('utf-8', errors='ignore')
    urls = set(re.findall(r'https://[^\s\"\'\\]+\.jpg', html, re.I))
    count = 1
    for u in urls:
        if 'favicon' in u.lower() or 'logo' in u.lower(): continue
        try:
            dest = f'images/Whistling Woods/hq_{count}.jpg'
            urllib.request.urlretrieve(u, dest)
            sz = os.path.getsize(dest)
            if sz > 150000:
                print(f"Downloaded hq_{count}.jpg")
                count += 1
            else:
                os.remove(dest)
            if count > 4: break
        except Exception as ex: pass
