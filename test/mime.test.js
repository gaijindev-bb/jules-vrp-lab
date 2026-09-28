const assert = require('assert');
const mimeModule = require('mime');
const mime = mimeModule.getType ? mimeModule : mimeModule.default;
assert.strictEqual(mime.getType('photo.jpg'), 'image/jpeg');
assert.strictEqual(mime.getType('photo.png'), 'image/png');
console.log('mime tests passed');
