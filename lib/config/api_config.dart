class ApiConfig {
  // Production backend deployed on Render
  static const String baseUrl = 'https://breath-again-app-backend.onrender.com/api';
  
  // For local development, use:
  // static const String baseUrl = 'http://localhost:3000/api';
  
  // For physical device testing with local backend, use your computer's IP:
  // static const String baseUrl = 'http://192.168.1.XXX:3000/api';
  
  static const Duration timeout = Duration(seconds: 30);
}
