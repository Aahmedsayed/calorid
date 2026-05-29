import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

void main() async {
  final dio = Dio(BaseOptions(baseUrl: 'https://calorie-tracker-backend-ybji.onrender.com'));
  try {
    final registerResponse = await dio.post('/api/auth/register', data: {
      'firstName': 'Test',
      'lastName': 'User',
      'username': 'testuser12345',
      'email': 'testuser12345@example.com',
      'password': 'Password123!',
    });
    print('Register: ${registerResponse.statusCode}');
  } catch (e) {
    print('Register error, might already exist');
  }

  try {
    final loginResponse = await dio.post('/api/auth/login', data: {
      'identifier': 'testuser12345@example.com',
      'password': 'Password123!',
    });
    final token = loginResponse.data['token'] ?? loginResponse.data['jwt'];
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      print('Logged in, token received');
      
      final mealResponse = await dio.post('/api/meals', data: {
        "date": DateTime.now().toIso8601String().split('T')[0],
        "mealType": "snack",
      });
      print('Meal created: ${mealResponse.data}');
      
      try {
        final mealResponse2 = await dio.post('/api/meals', data: {
          "date": DateTime.now().toIso8601String().split('T')[0],
          "mealType": "snack",
        });
      } catch (e) {
        if (e is DioException) {
          print('Create second meal error: ${e.response?.data}');
        }
      }
      
      final dashResponse = await dio.get('/api/dashboard/daily');
      print('Dashboard response:');
      print(dashResponse.data);
    }
  } catch (e) {
    if (e is DioException) {
      print('Login Error: ${e.response?.data}');
    } else {
      print(e);
    }
  }
}
