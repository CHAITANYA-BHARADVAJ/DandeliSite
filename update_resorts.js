const fs = require('fs');
const path = require('path');

const dir = 'd:\\Antigravity\\DandeliSite';

const files = [
    'whistling_woods_resort.html',
    'hornbill_resort.html',
    'laguna_resort.html'
];

const cssInjection = `
    /* ── ACCORDION AMENITIES ── */
    .am-details {
      border: 1px solid var(--border);
      background: #fff;
      margin-top: 16px;
    }
    .am-summary {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 14px 20px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 600;
      color: var(--forest);
      transition: background .2s;
      list-style: none;
    }
    .am-summary::-webkit-details-marker {
      display: none;
    }
    .am-summary:hover {
      background: rgba(201, 168, 76, .05);
    }
    .am-summary::after {
      content: '▼';
      font-size: 10px;
      color: var(--gold);
      transition: transform .3s;
    }
    .am-details[open] .am-summary::after {
      transform: rotate(180deg);
    }
    .am-details[open] .am-summary {
      border-bottom: 1px dashed var(--border);
    }
    .am-content {
      display: grid;
      grid-template-columns: 1fr;
    }
    .am-content .am-item {
      border: none !important;
      border-bottom: 1px solid var(--border) !important;
    }
    @media(min-width:560px) {
      .am-content {
        grid-template-columns: 1fr 1fr;
      }
      .am-content .am-item:nth-child(even) {
        border-left: 1px solid var(--border) !important;
      }
      .am-content .am-item:nth-last-child(-n+2) {
        border-bottom: none !important;
      }
    }
`;

const jsOldToken = `R.amenities.forEach(a => {
        document.getElementById('amenitiesGrid').innerHTML +=
          \`<div class="am-item"><span class="am-name">\${a.text}</span><span class="am-check"></span></div>\`;
      });`;

const jsNewToken = `/* amenities — list style */
      if (R.amenities) {
        R.amenities.forEach(a => {
          document.getElementById('amenitiesGrid').innerHTML +=
            \`<div class="am-item"><span class="am-name">\${a.text}</span><span class="am-check"></span></div>\`;
        });
      }

      /* grouped activities — dropdown accordion style */
      if (R.groupedActivities && R.groupedActivities.length > 0) {
        let gaHtml = '';
        R.groupedActivities.forEach(group => {
           gaHtml += \`<details class="am-details">
            <summary class="am-summary">\${group.name}</summary>
            <div class="am-content">\`;
           group.items.forEach(item => {
             let isPriced = item.toLowerCase().includes("cost") || item.toLowerCase().includes("charge");
             let icon = isPriced ? "💰" : "✓";
             gaHtml += \`<div class="am-item"><span class="am-name">\${item}</span><span class="am-check" style="\${isPriced ? 'background:rgba(255,165,0,.1);border-color:rgba(255,165,0,.2);color:#d97706;border-radius:3px;' : ''}">\${isPriced ? '' : ''}</span></div>\`;
           });
           gaHtml += \`</div></details>\`;
        });
        document.getElementById('amenitiesGrid').insertAdjacentHTML('afterend', gaHtml);
      }`;


const whistlingWoodsUpdates = (content) => {
    // We dynamically regex replace the blocks inside "const RESORT = { ... }"
    content = content.replace(/amenities:\s*\[[\s\S]*?\],/, `amenities: [
        { icon: "&#x2615;", text: "Buffet Breakfast (08:30am - 10:00am)" },
        { icon: "&#127869;", text: "Buffet Lunch (01:30pm - 03:00pm)" },
        { icon: "&#x1F958;", text: "Buffet Dinner (08:30pm - 10:00pm)" },
      ],
      groupedActivities: [
        {
          name: "Adventure & Nature",
          items: ["Jungle Trekking (7:30am - 8:30am)", "Bird Watching (4:30pm - 5:00pm)", "Firecamp (Based on weather)", "Boating (Depends on dam water level)", "Natural Jacuzzi (Depends on water level)"]
        },
        {
          name: "Resort Recreation",
          items: ["Swimming Pool (9am - 6pm)", "Indoor Games (Carom, Chess)", "Outdoor Games (Shuttlecock, Cricket)", "Kids Play Area"]
        },
        {
          name: "Obstacle Course (9am - 6pm)",
          items: ["Pipe line Activity", "Balancing Led Activity", "Zig Zag Activity", "Swing Ladder", "Multi Vain Activity", "Burma Bridge Activity"]
        }
      ],`);

      content = content.replace(/policies:\s*\[[\s\S]*?\],/, `policies: [
        { icon: "&#128197;", title: "Check-in & Rules", items: ["Valid photo ID mandatory during check-in", "Rooms are non-smoking, equipped with smoke detectors", "No pets permitted on premises", "Room service is not provided"] },
        { icon: "&#128101;", title: "Extra Guests & Children", items: ["Children aged 6 to 11 charged 50% of adult tariff", "Children above 11 considered as adults", "Driver meals at staff cafeteria (Free) or Restaurant (Rs1500+GST)"] },
        { icon: "&#128225;", title: "Connectivity & Entertainment", items: ["Only Airtel network is accessible", "Wi-Fi available exclusively in the reception area", "Riverside, Family Cottages, and Dormitories have no TV"] },
        { icon: "&#128161;", title: "Good to Know", items: ["Ala-carte services available in evening at extra charge", "No towels or soaps provided in the dormitory", "Carry umbrellas during rainy season"] },
      ],`);
    
    // Add Intro logic
    content = content.replace(/tagline: ".*?"/, 'tagline: "Welcome to the world of adventure! Discover the spirits of Wilderness in the lap of Dandeli forest."');

    return content;
};


const hornbillUpdates = (content) => {
    content = content.replace(/amenities:\s*\[[\s\S]*?\],/, `amenities: [
        { icon: "&#x2615;", text: "Breakfast" },
        { icon: "&#127869;", text: "Lunch" },
        { icon: "&#x1F958;", text: "Dinner" },
      ],
      groupedActivities: [
        {
          name: "Water & Nature Activities",
          items: ["Kayaking", "Boating", "Swimming", "Adventure Walk", "Bird Watching", "Fishing", "Camp Fire"]
        }
      ],`);

      content = content.replace(/policies:\s*\[[\s\S]*?\],/, `policies: [
        { icon: "&#128197;", title: "Check-in & Check-out", items: ["Check-in: 1:00 PM (At Lunch)", "Check-out: 11:00 AM (After Breakfast)", "Identity Card is compulsory while check-in"] },
        { icon: "&#128176;", title: "Booking Confirmation", items: ["To confirm the booking you need to transfer 50% of the amount.", "Includes Taxes"] },
        { icon: "&#128101;", title: "Child Policy", items: ["Children up to 6 years are complimentary.", "Children between 6 to 12 are charged at 50% of adult rates."] },
      ],`);

    return content;
};

const lagunaUpdates = (content) => {
    content = content.replace(/amenities:\s*\[[\s\S]*?\],/, `amenities: [
        { icon: "&#127869;", text: "Buffet Lunch (01:30pm - 03:00pm) Veg & Non-veg" },
        { icon: "&#x1F958;", text: "Buffet Dinner (09:30pm - 10:30pm) Veg & Non-veg" },
        { icon: "&#x2615;", text: "Breakfast (09:00am - 10:00am)" },
        { icon: "&#x2615;", text: "Morning & Evening Tea/Coffee" },
      ],
      groupedActivities: [
        {
          name: "Included Activities",
          items: ["Night campfire with music (Depends on rain)", "Jungle trekking (Morning 06:30 Am)", "Archery", "Boating in river Kali", "Swimming in river kali", "Kayaking in river Kali"]
        },
        {
          name: "Activities (Extra Cost)",
          items: ["River Mid Rafting (5km)", "Short Rafting (1km)", "River Zip Line", "Moon Light Boating in kali River"]
        }
      ],`);

      content = content.replace(/policies:\s*\[[\s\S]*?\],/, `policies: [
        { icon: "&#128197;", title: "Check-in & Timings", items: ["Check-in: 12:00 PM", "Check-out: 11:00 AM", "After Food Buffet timing, it is strictly closed"] },
        { icon: "&#128225;", title: "Important Notes", items: ["All Adventure Activity depends on water level & weather condition", "Carry light cotton clothes, swimwear, suitable walking shoes, torch, cap etc", "For Extra Cost Activity transport charges will be extra or guest can avail own vehicle."] },
        { icon: "&#128205;", title: "Sightseeing", items: ["Supa Dam, Back water, Crocodile park, Honey park"] },
        { icon: "&#128176;", title: "Payment & Cancellation", items: ["Strictly No Cancellation & Non-refundable", "Booking confirmed only upon receipt of advance", "Balance amount must be paid before check-in", "Children (5 to 12 years) charged 50%"] },
      ],`);

    return content;
}

files.forEach(f => {
    const fPath = path.join(dir, f);
    if (fs.existsSync(fPath)) {
        let content = fs.readFileSync(fPath, 'utf8');

        // Add CSS
        if (!content.includes('.am-details {') && content.includes('.am-check::after {')) {
            content = content.replace(/\.amenities-list\s*{[\s\S]*?}/g, '.amenities-list {\n      display: none;\n    }'); // we're removing the old box implicitly since we use inline am-item or amGrid
            
            // Wait, we don't need to hide .amenities-list because JS injects into it!
            // Let's just restore the normal regex injection
            content = fs.readFileSync(fPath, 'utf8');
            content = content.replace(/(.am-check::after\s*{[\s\S]*?}\s*)/, "$1" + cssInjection);
            console.log(`Added CSS to ${f}`);
        }

        // Add JS logic
        if (!content.includes('groupedActivities') && content.includes(jsOldToken)) {
            content = content.replace(jsOldToken, jsNewToken);
            console.log(`Added JS to ${f}`);
        }

        // Add Content
        if (f === 'whistling_woods_resort.html') content = whistlingWoodsUpdates(content);
        if (f === 'hornbill_resort.html') content = hornbillUpdates(content);
        if (f === 'laguna_resort.html') content = lagunaUpdates(content);

        fs.writeFileSync(fPath, content, 'utf8');
        console.log(`Updated ${f}`);
    } else {
        console.log(`File not found: ${f}`);
    }
});
