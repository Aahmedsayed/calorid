import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test103/providers/profile_provider.dart';
import 'package:test103/home/food_result.dart'; // From the original code
import 'package:image_picker/image_picker.dart';
import 'package:test103/services/api_service.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();
  bool _isUploading = false;

  Future<int?> _getExistingMealId(String targetMealType) async {
    try {
      final date = DateTime.now().toIso8601String().split('T')[0];
      final mealsResponse = await _apiService.getMealsByDate(date);
      if (mealsResponse.statusCode == 200) {
        final data = mealsResponse.data;
        List<dynamic>? meals;

        if (data is List) {
          meals = data;
        } else if (data is Map && data['content'] is List) {
          meals = data['content']; // Just in case it's paginated
        }

        if (meals != null) {
          for (var meal in meals) {
            if (meal is Map &&
                meal['mealType']?.toString().toLowerCase() ==
                    targetMealType.toLowerCase()) {
              return meal['id'] ?? meal['mealId'];
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to get existing meal ID: $e');
    }
    return null;
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;

      setState(() {
        _isUploading = true;
      });

      // 1. Create a meal
      int? mealId;
      try {
        final mealResponse = await _apiService.createMeal({
          "date": DateTime.now().toIso8601String().split('T')[0],
          "mealType": "snack",
        });

        if (mealResponse.statusCode == 200 || mealResponse.statusCode == 201) {
          mealId = mealResponse.data['id'];
        }
      } on DioException catch (e) {
        String serverError =
            e.response?.data?.toString() ?? e.message ?? 'Unknown error';
        if (e.response?.data is Map && e.response?.data['message'] != null) {
          serverError = e.response?.data['message'];
        }

        // If the meal already exists, try to get its ID from the dashboard
        if (serverError.toLowerCase().contains("already exists")) {
          mealId = await _getExistingMealId("snack");
          if (mealId == null) {
            throw Exception(
              "Meal already exists, but failed to fetch its ID. Server: $serverError",
            );
          }
        } else {
          rethrow;
        }
      }

      if (mealId != null) {
        // 2. Upload and analyze
        final bytes = await image.readAsBytes();
        final analyzeResponse = await _apiService.analyzeMealImage(
          mealId,
          bytes,
          image.name,
        );

        if (analyzeResponse.statusCode != null &&
            analyzeResponse.statusCode! >= 200 &&
            analyzeResponse.statusCode! < 300) {

          final foodName = analyzeResponse.data['foodName'];
          Map<String, dynamic>? foodData;
          if (foodName != null) {
            try {
              final foodRes = await _apiService.getFoodByName(foodName);
              if (foodRes.statusCode == 200) {
                foodData = foodRes.data;
              }
            } catch (e) {
              debugPrint('Could not fetch food details: $e');
            }
          }

          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => ScanResultScreen(
                  scanData: analyzeResponse.data,
                  foodData: foodData,
                  imageBytes: bytes,
                ),
              ),
            );
          }
        } else {
          throw Exception(
            "Analysis failed with status: ${analyzeResponse.statusCode}",
          );
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        String serverError =
            e.response?.data?.toString() ?? e.message ?? 'Unknown error';
        if (e.response?.data is Map && e.response?.data['message'] != null) {
          serverError = e.response?.data['message'];
        }
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Server Error'),
            content: Text(serverError),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture with Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickAndUploadImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickAndUploadImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profileData = profileProvider.profileData;
    final firstName = profileData?['firstName'] ?? 'User';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CalCount',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF667EEA),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Greeting Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF667EEA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    firstName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Capture Food Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Capture Your Food!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Share your delicious moments',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xFF667EEA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Upload your food photo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'JPG, PNG or HEIC (max 10MB)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _isUploading
                                    ? null
                                    : _showImageSourceDialog,
                                icon: _isUploading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.upload),
                                label: Text(
                                  _isUploading
                                      ? 'Analyzing...'
                                      : 'Upload Image!',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF667EEA),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Recent Uploads',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
