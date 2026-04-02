const fs = require('fs');

const files = [
  'd:/website/DandeliSite/couple-packages.html',
  'd:/website/DandeliSite/family-packages.html',
  'd:/website/DandeliSite/swayam_cottage.html',
  'd:/website/DandeliSite/riverpoint_resort.html',
  'd:/website/DandeliSite/jungle_edge.html'
];

const replacements = [
  { search: /ðŸ ƒ/g, replace: '🌿' },
  { search: /ðŸ Š/g, replace: '🏊' },
  { search: /ðŸ“¶/g, replace: '📶' },
  { search: /â‚¹/g, replace: '₹' },
  { search: /â˜…/g, replace: '★' },
  { search: /â˜†/g, replace: '☆' },
  { search: /ðŸ“ /g, replace: '📍' },
  { search: /âœ“/g, replace: '✓' },
  { search: /â ¤ï¸ /g, replace: '❤️' },
  { search: /ðŸ¤ /g, replace: '🤍' },
  { search: /â€”/g, replace: '—' },
  { search: /â”€â”€/g, replace: '──' },
  { search: /â€™/g, replace: "'" },
  { search: /ðŸŒ„/g, replace: '🌅' },
  { search: /ðŸŒŠ/g, replace: '🌊' },
  { search: /ðŸ ¡/g, replace: '🏡' },
  { search: /ðŸ ›ï¸ /g, replace: '🪵' },
  { search: /ðŸš¶/g, replace: '🚶' },
  { search: /ðŸš£/g, replace: '🛶' },
  { search: /â–¼/g, replace: '▼' },
  { search: /ðŸŒŸ/g, replace: '⭐' },
  { search: /ðŸ’°/g, replace: '💰' },
  { search: /âœ¨/g, replace: '✨' },
  { search: /ðŸŒ´/g, replace: '🍃' }
];

files.forEach(file => {
  if (fs.existsSync(file)) {
    let content = fs.readFileSync(file, 'utf8');
    let original = content;
    replacements.forEach(r => {
      content = content.replace(r.search, r.replace);
    });
    if (content !== original) {
      fs.writeFileSync(file, content, 'utf8');
      console.log(`Fixed characters in ${file}`);
    } else {
      console.log(`No changes needed for ${file}`);
    }
  } else {
    console.log(`File not found: ${file}`);
  }
});
