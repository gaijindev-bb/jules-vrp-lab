const assert = require('assert');
const imageopt = require('imageopt-lib');
const input = Buffer.from('sample-image-bytes');
const output = imageopt.optimize(input);
assert.ok(Buffer.isBuffer(output), 'optimize should return a Buffer');
assert.strictEqual(typeof imageopt.version, 'string');
console.log('imageopt tests passed');
