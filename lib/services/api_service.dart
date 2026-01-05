import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  // Dashboard
  static Future<Map<String, dynamic>> getDashboard() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/dashboard'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }

  // Environment
  static Future<Map<String, dynamic>> getEnvironmentCurrent() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/environment/current'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load environment data');
    }
  }

  static Future<Map<String, dynamic>> getEnvironmentTrends({String period = '24h'}) async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/environment/trends?period=$period'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load trend data');
    }
  }

  // Garden
  static Future<Map<String, dynamic>> getGarden() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/garden'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load garden data');
    }
  }

  static Future<Map<String, dynamic>> getGardenHealth() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/garden/health'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load garden health');
    }
  }

  // Lighting
  static Future<Map<String, dynamic>> getLighting() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/lighting'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load lighting data');
    }
  }

  static Future<Map<String, dynamic>> setLightingPower(bool isOn) async {
    final response = await http
        .put(
          Uri.parse('${ApiConfig.baseUrl}/lighting/power'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'isOn': isOn}),
        )
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update lighting power');
    }
  }

  static Future<Map<String, dynamic>> setLightingBrightness(double brightness) async {
    final response = await http
        .put(
          Uri.parse('${ApiConfig.baseUrl}/lighting/brightness'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'brightness': brightness}),
        )
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update brightness');
    }
  }

  static Future<Map<String, dynamic>> setLightingPreset(String preset) async {
    final response = await http
        .put(
          Uri.parse('${ApiConfig.baseUrl}/lighting/preset'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'preset': preset}),
        )
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to set preset');
    }
  }

  // AI Botanist
  static Future<Map<String, dynamic>> sendAIMessage(String message, {String? conversationId, String? plantId}) async {
    final body = {
      'message': message,
      if (conversationId != null) 'conversationId': conversationId,
      if (plantId != null) 'plantId': plantId,
    };

    final response = await http
        .post(
          Uri.parse('${ApiConfig.baseUrl}/ai/chat'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        )
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send message');
    }
  }

  static Future<List<String>> getAISuggestions() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/ai/suggestions'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  // Profile
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/profile'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  static Future<Map<String, dynamic>> getProfileStats() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/profile/stats'))
        .timeout(ApiConfig.timeout);
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile stats');
    }
  }
}
