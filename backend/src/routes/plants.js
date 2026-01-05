const express = require('express');
const router = express.Router();

// Mock plant details
const mockPlantDetails = {
    '1': {
        id: '1',
        name: 'Monstera',
        botanicalName: 'Monstera deliciosa',
        image: 'assets/images/monstera_portrait.png',
        status: 'THRIVING',
        health: {
            score: 98,
            airPurity: 98
        },
        careRituals: {
            light: {
                status: 'GOOD',
                description: 'Indirect morning sun.'
            },
            water: {
                status: 'IN 3 DAYS',
                nextWatering: '2026-01-08',
                description: 'Soil is moist.'
            },
            temperature: {
                status: 'PERFECT',
                description: 'Ideal range 20-25°C.'
            }
        },
        journal: [
            {
                date: '2025-10-12',
                note: 'Acquired this beauty from the downtown nursery. It had two new leaves unfurling.'
            }
        ]
    }
};

// GET /api/plants/:id
router.get('/:id', (req, res) => {
    try {
        const plantId = req.params.id;
        const plant = mockPlantDetails[plantId];

        if (!plant) {
            return res.status(404).json({ error: 'Plant not found' });
        }

        res.json(plant);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// POST /api/plants/:id/journal
router.post('/:id/journal', (req, res) => {
    try {
        const { note } = req.body;

        if (!note) {
            return res.status(400).json({ error: 'Note is required' });
        }

        const entry = {
            date: new Date().toISOString().split('T')[0],
            note
        };

        res.json({ success: true, entry });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
