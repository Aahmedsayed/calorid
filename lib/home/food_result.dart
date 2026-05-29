import 'dart:typed_data';
import 'package:flutter/material.dart';

class ScanResultScreen extends StatelessWidget {
  final Map<String, dynamic>? scanData;
  final Map<String, dynamic>? foodData;
  final Uint8List? imageBytes;

  const ScanResultScreen({
    super.key,
    this.scanData,
    this.foodData,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final foodName = scanData?['foodName'] ?? 'Unknown Food';
    final calories = scanData?['calories']?.toStringAsFixed(0) ??
        foodData?['calories']?.toStringAsFixed(0) ??
        '0';
    final quantity = scanData?['quantity']?.toStringAsFixed(1) ?? '1.0';

    // Macros strictly from foodData (default to 0.0 if API doesn't provide them)
    final protein = foodData?['protein']?.toDouble() ?? 0.0;
    final carbs = foodData?['carbs']?.toDouble() ?? 0.0;
    final fat = foodData?['fat']?.toDouble() ?? 0.0;

    // Detailed nutrition set to 0 as they are not provided by the API currently
    final fiber = 0.0;
    final sugar = 0.0;
    final sodium = 0;
    final cholesterol = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E88FF), Color(0xFF6C63FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Scan Result',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Food Image Circle
                    Container(
                      width: 160,
                      height: 160,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: imageBytes != null
                            ? Image.memory(
                                imageBytes!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/food.png',
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.fastfood,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      foodName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$quantity serving (250g)',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Calories Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E88FF), Color(0xFF6C63FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          calories,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Total Calories',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Per serving',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Macronutrients Card
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Macronutrients',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildMacroRow('Protein', '${protein.toStringAsFixed(1)}g',
                            protein / 100),
                        const SizedBox(height: 16),
                        _buildMacroRow('Carbohydrates', '${carbs.toStringAsFixed(1)}g',
                            carbs / 100),
                        const SizedBox(height: 16),
                        _buildMacroRow(
                            'Fat', '${fat.toStringAsFixed(1)}g', fat / 100),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Detailed Nutrition Card
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detailed Nutrition',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow('Fiber', '${fiber.toStringAsFixed(1)}g'),
                        const SizedBox(height: 16),
                        _buildDetailRow('Sugar', '${sugar.toStringAsFixed(1)}g'),
                        const SizedBox(height: 16),
                        _buildDetailRow('Sodium', '${sodium}mg'),
                        const SizedBox(height: 16),
                        _buildDetailRow('Cholesterol', '${cholesterol}mg'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add to favourite Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to favourite!')),
                        );
                      },
                      icon: const Icon(Icons.add, color: Colors.white, size: 22),
                      label: const Text(
                        'Add to favourite',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Scan Another Food Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xFF6C63FF),
                        size: 22,
                      ),
                      label: const Text(
                        'Scan Another Food',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF6C63FF),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget _buildMacroRow(String label, String value, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF7A7E8C),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: const Color(0xFFF0F0F5),
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF7A7E8C),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }
}