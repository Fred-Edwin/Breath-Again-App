const express = require('express');
const router = express.Router();
const mockSensorService = require('../services/mockSensorService');

// GET /api/dashboard
router.get('/', (req, res) => {
    try {
        const sensorData = mockSensorService.getCurrentReading();

        const response = {
            waterTank: {
                percentage: sensorData.waterLevel.percentage,
                status: sensorData.waterLevel.status,
                color: sensorData.waterLevel.percentage > 60 ? '#22C55E' :
                    sensorData.waterLevel.percentage > 30 ? '#FBBF24' : '#EF4444'
            },
            sensors: {
                airQuality: {
                    value: sensorData.airQuality.aqi,
                    status: sensorData.airQuality.status
                },
                temperature: {
                    value: `${sensorData.temperature.celsius}°C`,
                    status: sensorData.temperature.status
                },
                humidity: {
                    value: `${sensorData.humidity.percentage}%`,
                    status: sensorData.humidity.status
                }
            },
            alerts: generateAlerts(sensorData),
            gardenStatus: 'THRIVING',
            timestamp: sensorData.timestamp
        };

        res.json(response);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

function generateAlerts(sensorData) {
    const alerts = [];

    if (sensorData.waterLevel.percentage < 50) {
        alerts.push({
            type: 'WATER_LOW',
            severity: sensorData.waterLevel.percentage < 30 ? 'CRITICAL' : 'WARNING',
            message: `Water tank at ${sensorData.waterLevel.percentage}%`,
            icon: 'water_drop'
        });
    }

    if (sensorData.temperature.celsius > 26) {
        alerts.push({
            type: 'TEMP_HIGH',
            severity: 'INFO',
            message: 'Temperature slightly elevated',
            icon: 'thermostat'
        });
    }

    return alerts;
}

module.exports = router;
