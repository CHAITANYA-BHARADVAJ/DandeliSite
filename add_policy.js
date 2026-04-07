const fs = require('fs');
const path = require('path');

const dir = 'd:\\Antigravity\\DandeliSite';

const files = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

const policyObject = `        { icon: "&#128176;", title: "Booking Confirmation", items: ["25% Advance of total pax charged for confirmation", "Traveling charges not included"] },`;

files.forEach(f => {
    // Avoid files that are structural or we know already have it / don't need it.
    // Let's just check if it has the "const RESORT = {" and "policies: [".
    const fPath = path.join(dir, f);
    let content = fs.readFileSync(fPath, 'utf8');

    if (content.includes('const RESORT = {') && content.includes('policies: [')) {
        if (!content.includes('"Booking Confirmation"')) {
            content = content.replace(/policies:\s*\[/, `policies: [\n${policyObject}`);
            fs.writeFileSync(fPath, content, 'utf8');
            console.log(`Added policy to ${f}`);
        } else {
            console.log(`Policy already exists in ${f}`);
        }
    }
});
