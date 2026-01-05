const express = require('express');
const router = express.Router();
const aiBotanistService = require('../services/aiBotanistService');

// In-memory conversation storage (replace with database in production)
const conversations = new Map();

// POST /api/ai/chat
router.post('/chat', async (req, res) => {
    try {
        const { message, conversationId, plantId } = req.body;

        if (!message) {
            return res.status(400).json({ error: 'Message is required' });
        }

        // Get or create conversation history
        const convId = conversationId || 'default';
        let history = conversations.get(convId) || [];

        // Add context about specific plant if provided
        let contextualMessage = message;
        if (plantId) {
            contextualMessage = `[Context: User is asking about plant ID: ${plantId}] ${message}`;
        }

        // Get AI response
        const response = await aiBotanistService.chat(contextualMessage, history);

        // Update conversation history
        history.push({ isUser: true, text: message });
        history.push({ isUser: false, text: response.reply });
        conversations.set(convId, history);

        res.json({
            reply: response.reply,
            suggestions: response.suggestions,
            conversationId: convId
        });
    } catch (error) {
        console.error('AI Chat Error:', error);
        res.status(500).json({ error: error.message });
    }
});

// GET /api/ai/suggestions
router.get('/suggestions', (req, res) => {
    try {
        const suggestions = aiBotanistService.getSuggestions();
        res.json(suggestions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// DELETE /api/ai/conversation/:id
router.delete('/conversation/:id', (req, res) => {
    try {
        const { id } = req.params;
        conversations.delete(id);
        res.json({ success: true, message: 'Conversation cleared' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
