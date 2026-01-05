# Breathe Again API

Backend API for the Breathe Again vertical garden monitoring and control system.

## Features

- 🌿 Real-time sensor data (mock)
- 💧 Water tank monitoring
- 💡 Lighting control
- 🌡️ Temperature & humidity tracking
- 📊 24-hour trend data
- 🪴 Plant management
- 👤 User profiles & settings

## Quick Start

### 1. Install Dependencies
```bash
cd backend
npm install
```

### 2. Configure Environment
```bash
cp .env.example .env
# Edit .env if needed
```

### 3. Start Server
```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

Server will run on `http://localhost:3000`

## API Endpoints

### Dashboard
- `GET /api/dashboard` - Get dashboard data (water tank, sensors, alerts)

### Environment
- `GET /api/environment/current` - Current sensor readings
- `GET /api/environment/trends?period=24h` - Trend data

### Garden
- `GET /api/garden` - Garden overview with all plants
- `GET /api/garden/health` - Garden health metrics

### Plants
- `GET /api/plants/:id` - Plant details
- `POST /api/plants/:id/journal` - Add journal entry

### Lighting
- `GET /api/lighting` - Current lighting status
- `PUT /api/lighting/power` - Turn lights on/off
- `PUT /api/lighting/brightness` - Set brightness (0-100)
- `PUT /api/lighting/preset` - Apply preset (FULL_SUN, PARTIAL_SHADE, etc.)

### Profile
- `GET /api/profile` - User profile
- `GET /api/profile/stats` - User statistics
- `PUT /api/profile` - Update profile
- `PUT /api/profile/settings` - Update settings

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login
- `GET /api/auth/me` - Get current user

### Health Check
- `GET /health` - Server health status

## Mock Data

The API uses mock sensor data that simulates realistic conditions:
- Temperature varies throughout the day
- Humidity inversely correlates with temperature
- Lighting follows a 6am-6pm schedule
- Water level decreases over time
- All data includes realistic fluctuations

## Testing with Flutter App

1. Start the backend server
2. Update Flutter app API base URL to `http://localhost:3000/api`
3. Test endpoints using the app

## Project Structure

```
backend/
├── src/
│   ├── routes/          # API route handlers
│   │   ├── auth.js
│   │   ├── dashboard.js
│   │   ├── environment.js
│   │   ├── garden.js
│   │   ├── lighting.js
│   │   ├── plants.js
│   │   └── profile.js
│   ├── services/        # Business logic
│   │   └── mockSensorService.js
│   └── server.js        # Express app setup
├── .env.example         # Environment template
├── .gitignore
├── package.json
└── README.md
```

## Next Steps

- [ ] Add database (PostgreSQL/MongoDB)
- [ ] Implement WebSocket for real-time updates
- [ ] Add AI botanist chat endpoint
- [ ] Integrate with real hardware sensors
- [ ] Add data persistence
- [ ] Implement proper authentication middleware

## Demo Credentials

Email: `demo@breathagain.com`
Password: `password123`
