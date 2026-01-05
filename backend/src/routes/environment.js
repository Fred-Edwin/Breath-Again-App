const express = require('express');
const router = express.Router();
const mockSensorService = require('../services/mockSensorService');

// GET /api/environment/current
router.get('/current', (req, res) => {
    try {
        const sensorData = mockSensorService.getCurrentReading();

        const response = {
            airQuality: {
                aqi: sensorData.airQuality.aqi,
                status: sensorData.airQuality.status,
                pm25: sensorData.airQuality.pm25,
                co2: sensorData.airQuality.co2,
                trend: '+2' // Mock trend
            },
            temperature: {
                value: sensorData.temperature.celsius,
                unit: 'celsius',
                status: sensorData.temperature.status,
                trend: '+1'
            },
            humidity: {
                value: sensorData.humidity.percentage,
                status: sensorData.humidity.status,
                trend: '-3'
            },
            lightLevel: {
                lux: sensorData.lightLevel.lux,
                status: sensorData.lightLevel.status,
                hoursRemaining: sensorData.lightLevel.hoursRemaining
            },
            waterUsage: {
                liters: 2.3,
                period: 'week',
                status: 'NORMAL'
            },
            timestamp: sensorData.timestamp
        };

        res.json(response);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET /api/environment/trends?period=24h
router.get('/trends', (req, res) => {
    try {
        const period = req.query.period || '24h';
        const hours = period === '24h' ? 24 : period === '7d' ? 168 : 24;

        const trends = mockSensorService.getTrendData(hours);

        res.json(trends);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
