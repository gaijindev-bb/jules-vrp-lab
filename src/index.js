const imageopt = require('imageopt-lib');
const photos = [Buffer.from('fake-jpeg-1'), Buffer.from('fake-jpeg-2')];
const out = photos.map(p => imageopt.optimize(p));
console.log(`Processed ${out.length} photos with imageopt-lib v${imageopt.version}`);
