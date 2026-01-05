require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Request logging
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
    next();
});

// Routes
const authRoutes = require('./routes/auth');
const dashboardRoutes = require('./routes/dashboard');
const environmentRoutes = require('./routes/environment');
const gardenRoutes = require('./routes/garden');
const lightingRoutes = require('./routes/lighting');
const plantRoutes = require('./routes/plants');
const profileRoutes = require('./routes/profile');
const aiRoutes = require('./routes/ai');

app.use('/api/auth', authRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/environment', environmentRoutes);
app.use('/api/garden', gardenRoutes);
app.use('/api/lighting', lightingRoutes);
app.use('/api/plants', plantRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/ai', aiRoutes);

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({ error: 'Route not found' });
});

// Error handler
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({
        error: 'Internal server error',
        message: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Breath Again API server running on port ${PORT}`);
    console.log(`📡 Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`🌿 Mock data enabled: ${process.env.MOCK_DATA_ENABLED || 'true'}`);
});
