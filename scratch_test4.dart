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
      
      try {
        final mealsResponse = await dio.get('/api/meals');
        print('Meals endpoint: ${mealsResponse.data}');
      } catch (e) {
        if (e is DioException) {
          print('Meals err: ${e.response?.data}');
        }
      }
    }
  } catch (e) {
    print(e);
  }
}
