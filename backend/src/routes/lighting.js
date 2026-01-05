const express = require('express');
const router = express.Router();
const mockSensorService = require('../services/mockSensorService');

// GET /api/lighting
router.get('/', (req, res) => {
    try {
        const now = new Date();
        const hour = now.getHours();
        const scheduleStart = 6;
        const scheduleEnd = 18;
        const isScheduledOn = hour >= scheduleStart && hour < scheduleEnd;

        const response = {
            isOn: mockSensorService.lightsOn && isScheduledOn,
            brightness: mockSensorService.brightness,
            timeRemaining: isScheduledOn ? `${scheduleEnd - hour}h ${60 - now.getMinutes()}m` : '0h 0m',
            preset: 'FULL_SUN',
            schedule: {
                startTime: mockSensorService.lightingSchedule.startTime,
                endTime: mockSensorService.lightingSchedule.endTime,
                duration: 12
            },
            manualOverride: false
        };

        res.json(response);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT /api/lighting/power
router.put('/power', (req, res) => {
    try {
        const { isOn } = req.body;

        if (typeof isOn !== 'boolean') {
            return res.status(400).json({ error: 'isOn must be a boolean' });
        }

        mockSensorService.setLighting(isOn);

        res.json({
            success: true,
            isOn: mockSensorService.lightsOn,
            message: `Lights turned ${isOn ? 'ON' : 'OFF'}`
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT /api/lighting/brightness
router.put('/brightness', (req, res) => {
    try {
        const { brightness } = req.body;

        if (typeof brightness !== 'number' || brightness < 0 || brightness > 100) {
            return res.status(400).json({ error: 'brightness must be a number between 0 and 100' });
        }

        mockSensorService.setLighting(mockSensorService.lightsOn, brightness);

        res.json({
            success: true,
            brightness: mockSensorService.brightness,
            message: `Brightness set to ${brightness}%`
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// PUT /api/lighting/preset
router.put('/preset', (req, res) => {
    try {
        const { preset } = req.body;

        const presets = {
            'FULL_SUN': { hours: 12, brightness: 100 },
            'PARTIAL_SHADE': { hours: 8, brightness: 70 },
            'LOW_LIGHT': { hours: 6, brightness: 50 },
            'CUSTOM': { hours: 10, brightness: 75 }
        };

        if (!presets[preset]) {
            return res.status(400).json({ error: 'Invalid preset' });
        }

        mockSensorService.setLighting(true, presets[preset].brightness);

        res.json({
            success: true,
            preset,
            brightness: presets[preset].brightness,
            message: `Preset changed to ${preset}`
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
