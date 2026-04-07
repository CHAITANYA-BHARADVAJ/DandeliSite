import re

with open('resort-listing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Fix banner HTML
banner_old = '''      <div>
        <a class="rl-back" href="index.html#packages"> Back to Packages</a>
        <h1 class="rl-pkg-name" id="bannerTitle">Loading <em>Package</em></h1>
        <div class="rl-pkg-meta" id="bannerMeta">
          <!-- <span class="rl-pkg-pill"> 2 Nights  3 Days</span>
          <span class="rl-pkg-pill"> All Meals</span>
          <span class="rl-pkg-pill"> Instant Confirm</span> -->
        </div>
      </div>
      <div class="rl-pkg-price-box">
        <div class="rl-pkg-from">Starting from</div>
        <div class="rl-pkg-price-big" id="bannerPrice">1,300</div>
        <div class="rl-pkg-price-unit" id="bannerUnit">/person</div>
      </div>'''

banner_new = '''      <div>
        <a class="rl-back" href="index.html#packages">&#8592; Back to Packages</a>
        <h1 class="rl-pkg-name" id="bannerTitle">Loading <em>Package</em></h1>
        <div class="rl-pkg-meta" id="bannerMeta">
        </div>
      </div>'''

# Notice the unicode replacement characters! We can do a regex block replacement to be safe.
content = re.sub(r'<div>\s*<a class="rl-back"[^>]*>.*?Back to Packages</a>\s*<h1 class="rl-pkg-name" id="bannerTitle">Loading <em>Package</em></h1>\s*<div class="rl-pkg-meta" id="bannerMeta">\s*<!--.*?-->\s*</div>\s*</div>\s*<div class="rl-pkg-price-box">.*?</div>\s*</div>\s*</div>',
'''<div>
        <a class="rl-back" href="index.html#packages">&#8592; Back to Packages</a>
        <h1 class="rl-pkg-name" id="bannerTitle">Loading <em>Package</em></h1>
        <div class="rl-pkg-meta" id="bannerMeta">
        </div>
      </div>''', content, flags=re.DOTALL)

# Fix Javascript
js_old_regex = r"const pkgData\s*=\s*\{.*?\};\s*const d\s*=\s*pkgData\[pkg\][^;]*;\s*document\.getElementById\('bannerTitle'\)\.innerHTML\s*=\s*d\.name;\s*document\.getElementById\('bannerPrice'\)\.textContent\s*=\s*d\.price;\s*document\.getElementById\('bannerUnit'\)\.textContent\s*=\s*d\.unit;"

js_new = '''const pkgData = {
        'student-adventure': { name: 'Jungle Thrill <em>Adventure</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '🎒 Student Pack'] },
        'student-budget': { name: 'Budget Backpacker <em>Camp</em>', pills: ['⏱️ 2N 3D', '🍲 Breakfast', '💰 Budget Pick'] },
        'student-group': { name: 'College <em>Group Tour</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '👥 Min 10 Pax'] },
        'couple-romantic': { name: 'Riverside <em>Romance</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '🕯️ Candlelight'] },
        'couple-luxury': { name: 'Forest Luxury <em>Retreat</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '💆‍♀️ Spa'] },
        'couple-honeymoon': { name: 'Honeymoon <em>in the Wild</em>', pills: ['⏱️ 3N 4D', '🍲 All Meals', '💖 Honeymoon'] },
        'family-weekend': { name: 'Family <em>Weekend Getaway</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '👨‍👩‍👧‍�� 2+2'] },
        'family-adventure': { name: 'Wild Family <em>Adventure</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '🚙 Safari'] },
        'family-grand': { name: 'Grand Family <em>Expedition</em>', pills: ['⏱️ 3N 4D', '🍲 All Meals', '🌟 Premium'] }
      };

      const d = pkgData[pkg] || { name: 'Dandeli <em>Resort Packages</em>', pills: ['🍲 All Meals', '🚣 Activities'] };

      document.getElementById('bannerTitle').innerHTML = d.name;'''

content = re.sub(js_old_regex, js_new, content, flags=re.DOTALL)

with open('resort-listing.html', 'w', encoding='utf-8') as f:
    f.write(content)
print("Done!")
