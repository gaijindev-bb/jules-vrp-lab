const express = require('express');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'secret-key';

/**
 * Middleware to validate JWT in the Authorization header.
 * Rejects missing, malformed, or invalid tokens with HTTP status 401.
 */
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  if (!authHeader) {
    return res.status(401).json({ error: 'Unauthorized', message: 'Authorization header missing' });
  }

  const parts = authHeader.split(' ');
  if (parts.length !== 2 || parts[0].toLowerCase() !== 'bearer') {
    return res.status(401).json({ error: 'Unauthorized', message: 'Invalid Authorization header format' });
  }

  const token = parts[1];
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Unauthorized', message: 'Invalid or expired token' });
  }
}

const app = express();
app.use(express.json());

// Apply JWT validation middleware on every request
app.use(authenticateToken);

// Protected routes / catch-all handler
app.use((req, res) => {
  res.json({ message: 'Access granted', user: req.user });
});

const PORT = process.env.PORT || 3000;
let server;

if (require.main === module) {
  server = app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = {
  app,
  authenticateToken,
  JWT_SECRET,
  server
};
