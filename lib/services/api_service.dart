import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://calorie-tracker-backend-1-eobz.onrender.com';
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> login(String identifier, String password) async {
    return await _dio.post('/api/auth/login', data: {
      'identifier': identifier,
      'password': password,
    });
  }

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    return await _dio.post('/api/auth/register', data: {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'password': password,
    });
  }

  Future<Response> getProfile() async {
    return await _dio.get('/api/profile');
  }

  Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await _dio.put('/api/profile', data: data);
  }

  Future<Response> calculateBMI(Map<String, dynamic> data) async {
    return await _dio.post('/api/bmi/calculate', data: data);
  }

  Future<Response> getDailyDashboard() async {
    return await _dio.get('/api/dashboard/daily');
  }

  Future<Response> getMealsByDate(String date) async {
    return await _dio.get('/api/meals/by-date', queryParameters: {'date': date});
  }

  Future<Response> getFoodByName(String name) async {
    return await _dio.get('/api/foods/search', queryParameters: {'name': name});
  }

  Future<Response> createMeal(Map<String, dynamic> data) async {
    return await _dio.post('/api/meals', data: data);
  }

  Future<Response> analyzeMealImage(int mealId, List<int> bytes, String fileName) async {
    // Determine extension
    String ext = fileName.split('.').last.toLowerCase();
    String type = ext == 'png' ? 'png' : 'jpeg';

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes, 
        filename: fileName,
        contentType: MediaType('image', type),
      ),
    });
    return await _dio.post(
      '/api/scan/analyze/$mealId',
      data: formData,
    );
  }
}
