class ApiConfig {
  // Change this to your computer's IP address when testing on physical device
  // Use 'localhost' for emulator/simulator
  static const String baseUrl = 'http://localhost:3000/api';
  
  // For physical device testing, use your computer's IP:
  // static const String baseUrl = 'http://192.168.1.XXX:3000/api';
  
  static const Duration timeout = Duration(seconds: 30);
}
