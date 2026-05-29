import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test103/providers/profile_provider.dart';
import 'package:test103/services/api_service.dart';
import 'package:test103/BMI/dmi_result.dart'; // From original code

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String selectedGender = 'Male';
  double height = 175;
  int weight = 70;
  int age = 25;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF667EEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF667EEA),
        elevation: 0,
        title: const Text(
          'User Information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Gender Selection
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.people, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Select Gender',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedGender = 'Male'),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedGender == 'Male'
                                          ? const Color(0xFF667EEA)
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/male.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Male',
                                          style: TextStyle(
                                            color: selectedGender == 'Male'
                                                ? Colors.white
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedGender = 'Female'),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedGender == 'Female'
                                          ? const Color(0xFF667EEA)
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/female.png', width: 60, height: 60,),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Female',
                                          style: TextStyle(
                                            color: selectedGender == 'Female'
                                                ? Colors.white
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Height
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.straighten, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Height',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                height.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF667EEA),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  ' cm',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: height,
                            min: 100,
                            max: 250,
                            activeColor: const Color(0xFF667EEA),
                            onChanged: (value) =>
                                setState(() => height = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Weight and Age
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monitor_weight, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Weight',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  weight.toString(),
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D3142),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => setState(() => weight--),
                                      icon: const Icon(Icons.remove_circle),
                                      color: const Color(0xFF667EEA),
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      onPressed: () => setState(() => weight++),
                                      icon: const Icon(Icons.add_circle),
                                      color: const Color(0xFF667EEA),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cake, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  age.toString(),
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D3142),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => setState(() => age--),
                                      icon: const Icon(Icons.remove_circle),
                                      color: const Color(0xFF667EEA),
                                    ),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      onPressed: () => setState(() => age++),
                                      icon: const Icon(Icons.add_circle),
                                      color: const Color(0xFF667EEA),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Calculate Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () async {
                          setState(() {
                            _isLoading = true;
                          });

                          // Update profile in backend
                          final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                          await profileProvider.updateProfile({
                            "gender": selectedGender.toLowerCase(),
                            "age": age,
                            "heightCm": height,
                            "weightKg": weight,
                            "targetWeightKg": weight, // assuming maintain
                            "goal": "maintain",
                            "activityLevel": "sedentary"
                          });

                          setState(() {
                            _isLoading = false;
                          });

                          // Calculate BMI locally or fetch from provider
                          double heightM = height / 100;
                          double bmi = weight / (heightM * heightM);
                          String bmiCategory;

                          if (bmi < 18.5) {
                            bmiCategory = 'Underweight';
                          } else if (bmi < 25) {
                            bmiCategory = 'Normal Weight';
                          } else if (bmi < 30) {
                            bmiCategory = 'Overweight';
                          } else {
                            bmiCategory = 'Obese';
                          }

                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BMIResultScreen(
                                  bmi: bmi,
                                  bmiCategory: bmiCategory,
                                  height: height,
                                  weight: weight.toDouble(),
                                  age: age,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF667EEA),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading 
                           ? const CircularProgressIndicator()
                           : const Text(
                          'SAVE & CALCULATE MY BMI',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}