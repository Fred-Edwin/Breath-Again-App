const { GoogleGenerativeAI } = require('@google/generative-ai');

class AIBotanistService {
    constructor() {
        this.genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
        this.model = this.genAI.getGenerativeModel({ model: 'gemini-2.0-flash' });

        // System context for the AI botanist
        this.systemContext = `You are an expert AI botanist assistant for the "Breath Again" vertical garden system. 
You help users care for their indoor plants with practical, friendly advice.

Key information:
- The system monitors 6 plants in a vertical garden
    - Sensors track: air quality(AQI), temperature, humidity, light levels, water
        - Lighting is automated(6am - 6pm schedule)
            - Water tank capacity is 5 liters

Your personality:
- Friendly and encouraging
    - Practical and concise
        - Use plant emojis occasionally 🌿
- Keep responses under 100 words unless asked for details

Focus on:
    - Plant health diagnostics
        - Watering schedules
            - Light requirements
                - Common plant problems
                    - Seasonal care tips`;
    }

    async chat(userMessage, conversationHistory = []) {
        try {
            if (!process.env.GEMINI_API_KEY || process.env.GEMINI_API_KEY === 'your-gemini-api-key-here') {
                return this.getFallbackResponse(userMessage);
            }

            // Build conversation context
            const context = this.buildContext(conversationHistory);
            const fullPrompt = `${this.systemContext} \n\n${context} \n\nUser: ${userMessage} \n\nAI Botanist: `;

            const result = await this.model.generateContent(fullPrompt);
            const response = await result.response;
            const text = response.text();

            return {
                reply: text,
                suggestions: this.generateSuggestions(userMessage)
            };
        } catch (error) {
            console.error('Gemini API Error:', error);
            return this.getFallbackResponse(userMessage);
        }
    }

    buildContext(history) {
        if (!history || history.length === 0) return '';

        return history
            .slice(-5) // Last 5 messages for context
            .map(msg => `${msg.isUser ? 'User' : 'AI Botanist'}: ${msg.text} `)
            .join('\n');
    }

    generateSuggestions(lastMessage) {
        const allSuggestions = [
            "Diagnose leaf spots",
            "Is my Monstera happy?",
            "Watering advice",
            "Fertilizer schedule",
            "Why are leaves yellowing?",
            "Best light for ferns",
            "Humidity tips",
            "Pest prevention"
        ];

        // Return 4 random suggestions
        return allSuggestions
            .sort(() => Math.random() - 0.5)
            .slice(0, 4);
    }

    getFallbackResponse(message) {
        // Fallback responses when API key is not configured
        const responses = {
            'diagnose': '🌿 To diagnose plant issues, I need to see the symptoms. Common problems include yellowing leaves (overwatering), brown tips (low humidity), or drooping (needs water). Can you describe what you\'re seeing?',
            'water': '💧 Most indoor plants prefer soil that\'s slightly moist but not soggy. Stick your finger 2 inches into the soil - if it\'s dry, it\'s time to water. Your vertical garden\'s automated system helps maintain optimal moisture!',
            'light': '☀️ Your vertical garden has automated lighting (6am-6pm). Most tropical plants thrive with bright, indirect light. If leaves are pale or leggy, they might need more light. Dark green, compact growth means they\'re happy!',
            'default': '🌱 I\'m your AI botanist assistant! I can help with plant care, diagnose issues, and provide watering/lighting advice. What would you like to know about your vertical garden?'
        };

        const lowerMessage = message.toLowerCase();
        if (lowerMessage.includes('water')) return { reply: responses.water, suggestions: this.generateSuggestions(message) };
        if (lowerMessage.includes('light')) return { reply: responses.light, suggestions: this.generateSuggestions(message) };
        if (lowerMessage.includes('diagnose') || lowerMessage.includes('problem')) return { reply: responses.diagnose, suggestions: this.generateSuggestions(message) };

        return { reply: responses.default, suggestions: this.generateSuggestions(message) };
    }

    getSuggestions() {
        return [
            "Diagnose leaf spots",
            "Is my Monstera happy?",
            "Watering advice",
            "Fertilizer schedule"
        ];
    }
}

// Singleton instance
const aiBotanistService = new AIBotanistService();

module.exports = aiBotanistService;
