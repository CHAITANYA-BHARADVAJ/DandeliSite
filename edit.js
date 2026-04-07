const fs = require('fs');
let content = fs.readFileSync('resort-listing.html', 'utf8');

// 1. Remove the price box and fix back button emoji
content = content.replace(/<div>\s*<a class=\"rl-back\"[^>]*>([\s\S]*?)Back to Packages<\/a>\s*<h1 class=\"rl-pkg-name\" id=\"bannerTitle\">([\s\S]*?)<\/h1>\s*<div class=\"rl-pkg-meta\" id=\"bannerMeta\">\s*<!--(.*?)-->\s*<\/div>\s*<\/div>\s*<div class=\"rl-pkg-price-box\">([\s\S]*?)<\/div>/s,
`<div>
        <a class="rl-back" href="index.html#packages">&#8592; Back to Packages</a>
        <h1 class="rl-pkg-name" id="bannerTitle">Loading <em>Package</em></h1>
        <div class="rl-pkg-meta" id="bannerMeta">
        </div>
      </div>`);

// 2. Fix the JS array
content = content.replace(/const pkgData\s*=\s*\{[\s\S]*?\};\s*const d\s*=\s*pkgData\[pkg\][^;]*;\s*document\.getElementById\('bannerTitle'\)\.innerHTML\s*=\s*d\.name;\s*document\.getElementById\('bannerPrice'\)\.textContent\s*=\s*d\.price;\s*document\.getElementById\('bannerUnit'\)\.textContent\s*=\s*d\.unit;/s,
`const pkgData = {
        'student-adventure': { name: 'Jungle Thrill <em>Adventure</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '🎒 Student Pack'] },
        'student-budget': { name: 'Budget Backpacker <em>Camp</em>', pills: ['⏱️ 2N 3D', '🍲 Breakfast', '💰 Budget Pick'] },
        'student-group': { name: 'College <em>Group Tour</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '👥 Min 10 Pax'] },
        'couple-romantic': { name: 'Riverside <em>Romance</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '🕯️ Candlelight'] },
        'couple-luxury': { name: 'Forest Luxury <em>Retreat</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '💆‍♀️ Spa'] },
        'couple-honeymoon': { name: 'Honeymoon <em>in the Wild</em>', pills: ['⏱️ 3N 4D', '🍲 All Meals', '💖 Honeymoon'] },
        'family-weekend': { name: 'Family <em>Weekend Getaway</em>', pills: ['⏱️ 1N 2D', '🍲 All Meals', '👨‍👩‍👧‍👦 2+2'] },
        'family-adventure': { name: 'Wild Family <em>Adventure</em>', pills: ['⏱️ 2N 3D', '🍲 All Meals', '🚙 Safari'] },
        'family-grand': { name: 'Grand Family <em>Expedition</em>', pills: ['⏱️ 3N 4D', '🍲 All Meals', '🌟 Premium'] }
      };

      const d = pkgData[pkg] || { name: 'Dandeli <em>Resort Packages</em>', pills: ['🍲 All Meals', '🚣 Activities'] };

      document.getElementById('bannerTitle').innerHTML = d.name;`);

fs.writeFileSync('resort-listing.html', content);
