const mimeModule = require('mime');
const mime = mimeModule.getType ? mimeModule : mimeModule.default;
const samples = ['photo1.jpg', 'photo2.png', 'notes.txt'];
for (const f of samples) console.log(`${f} -> ${mime.getType(f)}`);
console.log('gallery-processor: sample gallery processed');
