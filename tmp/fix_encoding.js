// Fix mojibake / broken encoding characters across all HTML files
// Run with: node fix_encoding.js

const fs = require('fs');
const path = require('path');

const basePath = 'd:\\Antigravity\\DandeliSite';

// Get all HTML files
const files = fs.readdirSync(basePath).filter(f => f.endsWith('.html'));

// Replacement map: broken UTF-8 mojibake -> correct character
const replacements = [
  // CSS comment box-drawing lines
  ['â\u0080\u0094', '—'],      // em dash (â€")
  ['â\u0080\u0093', '–'],      // en dash
  ['â\u0080\u0099', '\u2019'], // right single quote
  ['â\u0080\u009C', '\u201C'], // left double quote  
  ['â\u0080\u009D', '\u201D'], // right double quote
  ['â\u0080\u00BA', '\u203A'], // right angle bracket ›
  ['â\u0080\u00A6', '\u2026'], // ellipsis …
  ['â\u0096\u00BC', '\u25BC'], // down triangle ▼
  ['â\u0098\u0085', '\u2605'], // filled star ★
  ['â\u0098\u0086', '\u2606'], // empty star ☆
  ['â\u009C\u0093', '\u2713'], // checkmark ✓
];

let totalFixed = 0;

files.forEach(file => {
  const filePath = path.join(basePath, file);
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;
  let changes = 0;

  replacements.forEach(([broken, correct]) => {
    const regex = new RegExp(broken.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g');
    const matches = content.match(regex);
    if (matches) {
      changes += matches.length;
      content = content.replace(regex, correct);
    }
  });

  if (content !== original) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`FIXED: ${file} (${changes} replacements)`);
    totalFixed += changes;
  } else {
    console.log(`CLEAN: ${file}`);
  }
});

console.log(`\nTotal: ${totalFixed} replacements across ${files.length} files.`);
