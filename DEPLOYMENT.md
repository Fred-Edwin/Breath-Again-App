# Deploying Backend to Render

This guide walks you through deploying the Breathe Again backend API to Render.

## Prerequisites

- ✅ GitHub repository pushed: `https://github.com/Fred-Edwin/Breathe-Again-App`
- ✅ Render account (sign up at [render.com](https://render.com))
- ✅ Gemini API key (get one at [Google AI Studio](https://makersuite.google.com/app/apikey))

## Step-by-Step Deployment

### 1. Create New Web Service

1. Log in to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub account if not already connected
4. Select the **`Breath-Again-App`** repository

### 2. Configure Service Settings

Fill in the following configuration:

| Setting | Value |
|---------|-------|
| **Name** | `breath-again-backend` (or your preferred name) |
| **Root Directory** | `backend` |
| **Environment** | `Node` |
| **Region** | Choose closest to your users |
| **Branch** | `main` |
| **Build Command** | `npm install` |
| **Start Command** | `npm start` |
| **Instance Type** | Free (or paid tier for production) |

### 3. Add Environment Variables

Click **"Advanced"** and add these environment variables:

| Key | Value | Notes |
|-----|-------|-------|
| `NODE_ENV` | `production` | Required |
| `JWT_SECRET` | `<generate-secure-random-string>` | Use a password generator for a 32+ character string |
| `GEMINI_API_KEY` | `<your-gemini-api-key>` | Get from Google AI Studio |
| `MOCK_DATA_ENABLED` | `true` | Set to `false` when connecting real sensors |
| `SENSOR_UPDATE_INTERVAL` | `5000` | Milliseconds between sensor updates |

> [!WARNING]
> **Generate a secure JWT_SECRET**: Use a tool like `openssl rand -base64 32` or an online password generator. Never use a simple password!

### 4. Deploy

1. Click **"Create Web Service"**
2. Render will automatically:
   - Clone your repository
   - Install dependencies (`npm install`)
   - Start your server (`npm start`)
3. Monitor the deployment logs for any errors

### 5. Verify Deployment

Once deployed, your backend will be available at:
```
https://breath-again-backend.onrender.com
```

Test the API endpoints:

**Health Check** (if you have one):
```bash
curl https://breath-again-backend.onrender.com/api/health
```

**Login Endpoint**:
```bash
curl -X POST https://breath-again-backend.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"demo@example.com","password":"password123"}'
```

**Garden Data**:
```bash
curl https://breath-again-backend.onrender.com/api/garden \
  -H "Authorization: Bearer <your-jwt-token>"
```

## Update Flutter App

After deployment, update your Flutter app to use the Render backend URL:

**File**: `lib/config/api_config.dart`

```dart
class ApiConfig {
  static const String baseUrl = 'https://breath-again-backend.onrender.com';
  // ... rest of config
}
```

## Troubleshooting

### Deployment Failed
- Check the deployment logs in Render dashboard
- Verify all environment variables are set correctly
- Ensure `package.json` has correct `start` script

### API Returns 500 Errors
- Check if `GEMINI_API_KEY` is valid
- Verify environment variables are set
- Check application logs in Render dashboard

### Free Tier Limitations
- Free tier services spin down after 15 minutes of inactivity
- First request after spin-down may take 30-60 seconds
- Consider upgrading to paid tier for production use

## Next Steps

1. ✅ Backend deployed on Render
2. Update Flutter app with production API URL
3. Test all API endpoints from the mobile app
4. Set up custom domain (optional)
5. Configure CORS if needed for web deployment
6. Set up monitoring and alerts

## Useful Commands

**View Logs**:
- Go to Render Dashboard → Your Service → Logs

**Redeploy**:
- Push changes to GitHub `main` branch
- Render will auto-deploy (if enabled)
- Or manually click "Deploy latest commit" in dashboard

**Environment Variables**:
- Dashboard → Your Service → Environment
- Add/edit variables and click "Save Changes"
- Service will automatically restart

---

🎉 **Congratulations!** Your Breathe Again backend is now live on Render!
