const express = require('express');
const router = express.Router();

// Mock user data
const mockUser = {
    id: '1',
    name: 'Elara Vance',
    email: 'elara@example.com',
    profileImage: 'assets/images/user_profile.png'
};

const mockSettings = {
    notifications: {
        hydrationAlerts: true,
        lightAdjustments: true,
        aiTips: false
    },
    preferences: {
        gardenName: 'Vertical Garden',
        temperatureUnit: 'FAHRENHEIT',
        theme: 'DARK'
    }
};

// GET /api/profile
router.get('/', (req, res) => {
    try {
        res.json({
            ...mockUser,
            settings: mockSettings
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET /api/profile/stats
router.get('/stats', (req, res) => {
    try {
        res.json({
            plantCount: 6,
            healthScore: 98,
            gardenName: 'Vertical Garden'
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT /api/profile
router.put('/', (req, res) => {
    try {
        const { name, email } = req.body;

        res.json({
            success: true,
            message: 'Profile updated',
            user: { ...mockUser, name: name || mockUser.name, email: email || mockUser.email }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT /api/profile/settings
router.put('/settings', (req, res) => {
    try {
        const { notifications, preferences } = req.body;

        res.json({
            success: true,
            message: 'Settings updated',
            settings: {
                notifications: { ...mockSettings.notifications, ...notifications },
                preferences: { ...mockSettings.preferences, ...preferences }
            }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
