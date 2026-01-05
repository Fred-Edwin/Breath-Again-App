const express = require('express');
const router = express.Router();

// Mock plant data
const mockPlants = [
    {
        id: '1',
        name: 'Monstera',
        botanicalName: 'Monstera deliciosa',
        image: 'assets/images/monstera_portrait.png',
        status: 'THRIVING',
        healthScore: 98,
        position: 1
    },
    {
        id: '2',
        name: 'Boston Fern',
        botanicalName: 'Nephrolepis exaltata',
        image: 'assets/images/fern_portrait.png',
        status: 'THRIVING',
        healthScore: 95,
        position: 2
    },
    {
        id: '3',
        name: 'Areca Palm',
        botanicalName: 'Dypsis lutescens',
        image: 'assets/images/palm_portrait.png',
        status: 'THRIVING',
        healthScore: 97,
        position: 3
    },
    {
        id: '4',
        name: 'Fiddle Leaf Fig',
        botanicalName: 'Ficus lyrata',
        image: 'assets/images/ficus_portrait.png',
        status: 'THRIVING',
        healthScore: 96,
        position: 4
    },
    {
        id: '5',
        name: 'Pothos',
        botanicalName: 'Epipremnum aureum',
        image: 'assets/images/monstera_portrait.png',
        status: 'THRIVING',
        healthScore: 99,
        position: 5
    },
    {
        id: '6',
        name: 'Snake Plant',
        botanicalName: 'Sansevieria trifasciata',
        image: 'assets/images/fern_portrait.png',
        status: 'THRIVING',
        healthScore: 94,
        position: 6
    }
];

// GET /api/garden
router.get('/', (req, res) => {
    try {
        const response = {
            name: 'Vertical Garden',
            plantCount: mockPlants.length,
            overallHealth: 98,
            status: 'ALL_THRIVING',
            plants: mockPlants
        };

        res.json(response);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// GET /api/garden/health
router.get('/health', (req, res) => {
    try {
        const response = {
            health: 98,
            water: 'OPTIMAL',
            light: 'GOOD',
            temperature: 'OPTIMAL',
            humidity: 'IDEAL'
        };

        res.json(response);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
