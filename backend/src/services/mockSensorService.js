const { v4: uuidv4 } = require('uuid');

class MockSensorService {
    constructor() {
        this.waterLevel = 45; // percentage
        this.lightsOn = true;
        this.brightness = 75;
        this.lightingSchedule = {
            startTime: '06:00',
            endTime: '18:00'
        };
    }

    // Generate current sensor reading
    getCurrentReading() {
        const now = new Date();
        const hour = now.getHours();

        // Determine if lights should be on based on schedule
        const scheduleStart = parseInt(this.lightingSchedule.startTime.split(':')[0]);
        const scheduleEnd = parseInt(this.lightingSchedule.endTime.split(':')[0]);
        const isScheduledOn = hour >= scheduleStart && hour < scheduleEnd;

        return {
            timestamp: now.toISOString(),
            airQuality: {
                aqi: this.randomRange(38, 48),
                status: 'GOOD',
                pm25: this.randomRange(10, 15),
                co2: this.randomRange(400, 500)
            },
            temperature: {
                celsius: this.randomRange(20, 24),
                fahrenheit: this.celsiusToFahrenheit(this.randomRange(20, 24)),
                status: 'OPTIMAL'
            },
            humidity: {
                percentage: this.randomRange(60, 70),
                status: 'IDEAL'
            },
            lightLevel: {
                lux: (this.lightsOn && isScheduledOn) ? this.randomRange(800, 900) : 0,
                status: (this.lightsOn && isScheduledOn) ? 'ACTIVE' : 'OFF',
                hoursRemaining: isScheduledOn ? scheduleEnd - hour : 0
            },
            waterLevel: {
                percentage: this.waterLevel,
                liters: (this.waterLevel / 100) * 5, // 5L tank capacity
                status: this.waterLevel > 50 ? 'NORMAL' : this.waterLevel > 30 ? 'LOW' : 'CRITICAL'
            }
        };
    }

    // Generate 24-hour trend data
    getTrendData(hours = 24) {
        const trends = {
            temperature: [],
            humidity: [],
            light: []
        };

        const now = new Date();
        for (let i = hours; i >= 0; i--) {
            const timestamp = new Date(now.getTime() - (i * 60 * 60 * 1000));
            const hour = timestamp.getHours();

            // Temperature varies slightly throughout day
            const tempBase = 22;
            const tempVariation = Math.sin((hour / 24) * Math.PI * 2) * 2;

            // Humidity inverse to temperature
            const humidityBase = 65;
            const humidityVariation = -tempVariation * 2;

            // Light follows schedule
            const isLightOn = hour >= 6 && hour < 18;

            trends.temperature.push({
                timestamp: timestamp.toISOString(),
                value: Math.round((tempBase + tempVariation) * 10) / 10
            });

            trends.humidity.push({
                timestamp: timestamp.toISOString(),
                value: Math.round(humidityBase + humidityVariation)
            });

            trends.light.push({
                timestamp: timestamp.toISOString(),
                value: isLightOn ? this.randomRange(800, 900) : 0
            });
        }

        return trends;
    }

    // Helper methods
    randomRange(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    celsiusToFahrenheit(celsius) {
        return Math.round((celsius * 9 / 5 + 32) * 10) / 10;
    }

    // Simulate water consumption
    consumeWater(amount = 0.5) {
        this.waterLevel = Math.max(0, this.waterLevel - amount);
    }

    // Refill water tank
    refillWater() {
        this.waterLevel = 100;
    }

    // Update lighting
    setLighting(isOn, brightness) {
        this.lightsOn = isOn;
        if (brightness !== undefined) {
            this.brightness = brightness;
        }
    }
}

// Singleton instance
const mockSensorService = new MockSensorService();

// Simulate water consumption every hour
setInterval(() => {
    mockSensorService.consumeWater(0.5);
}, 60 * 60 * 1000);

module.exports = mockSensorService;
