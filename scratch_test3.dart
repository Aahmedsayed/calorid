import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

void main() async {
  final dio = Dio(BaseOptions(baseUrl: 'https://calorie-tracker-backend-ybji.onrender.com'));
  
  try {
    final loginResponse = await dio.post('/api/auth/login', data: {
      'identifier': 'testuser12345@example.com',
      'password': 'Password123!',
    });
    final token = loginResponse.data['token'] ?? loginResponse.data['jwt'];
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      print('Logged in');
      
      try {
        final profileResponse = await dio.put('/api/profile', data: {
          "age": 25,
          "gender": "male",
          "height": 180,
          "weight": 75,
          "goal": "maintain",
          "activityLevel": "moderate"
        });
        print('Profile created');
      } catch(e) {
        if(e is DioException) print('Profile err: ${e.response?.data}');
      }
      
      final dashResponse = await dio.get('/api/dashboard/daily');
      print('Dashboard: ${dashResponse.data}');
      
      final mealsResponse = await dio.get('/api/meals');
      print('Meals endpoint: ${mealsResponse.data}');
    }
  } catch (e) {
    if (e is DioException) {
      print('Error: ${e.response?.data}');
    } else {
      print(e);
    }
  }
}
