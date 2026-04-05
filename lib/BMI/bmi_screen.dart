import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  final double? height;
  final double? weight;
  final int? age;

  const BMICalculatorScreen({Key? key, this.height, this.weight, this.age})
    : super(key: key);

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();

  String exerciseFrequency = '3-4 days per week';
  String weightLossPace = 'Moderate (0.5 kg/week)';
  double bmi = 0;
  String bmiCategory = '';
  int dailyCalories = 0;
  int dailyDeficit = 0;
  int weeksToGoal = 0;
  String exerciseDays = '3-4 days';

  @override
  void initState() {
    super.initState();
    if (widget.weight != null) {
      currentWeightController.text = widget.weight!.toInt().toString();
    } else {
      currentWeightController.text = '70';
    }
    if (widget.height != null) {
      heightController.text = widget.height!.toInt().toString();
    } else {
      heightController.text = '170';
    }
    if (widget.age != null) {
      ageController.text = widget.age.toString();
    } else {
      ageController.text = '25';
    }
    targetWeightController.text = '65';
  }

  void calculateBMI() {
    double heightM = double.parse(heightController.text) / 100;
    double weight = double.parse(currentWeightController.text);

    setState(() {
      bmi = weight / (heightM * heightM);

      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
      } else if (bmi < 25) {
        bmiCategory = 'Normal Weight';
      } else if (bmi < 30) {
        bmiCategory = 'Overweight';
      } else {
        bmiCategory = 'Obese';
      }

      dailyCalories = 1850;
      dailyDeficit = -500;
      weeksToGoal = 10;
      exerciseDays = '3-4 days';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF667EEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF667EEA),
        elevation: 0,
        title: const Text(
          'BMI & Deficit Calculator',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Track your health and weight loss goals',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Input Fields
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Weight',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: currentWeightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '70',
                              suffixText: 'kg',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Height',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: heightController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '170',
                                        suffixText: 'cm',
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Age',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: ageController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '25',
                                        suffixText: 'years',
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Target Weight',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: targetWeightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '65',
                              suffixText: 'kg',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'How many days per week do you exercise?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: exerciseFrequency,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: '3-4 days per week',
                                child: Text('3-4 days per week'),
                              ),
                              DropdownMenuItem(
                                value: '5-6 days per week',
                                child: Text('5-6 days per week'),
                              ),
                              DropdownMenuItem(
                                value: 'Daily',
                                child: Text('Daily'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() => exerciseFrequency = value!);
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'What is your weight loss pace?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildPaceOption(
                            'Moderate (0.5 kg/week)',
                            weightLossPace == 'Moderate (0.5 kg/week)',
                            () => setState(
                              () => weightLossPace = 'Moderate (0.5 kg/week)',
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildPaceOption(
                            'Aggressive (1 kg/week)',
                            weightLossPace == 'Aggressive (1 kg/week)',
                            () => setState(
                              () => weightLossPace = 'Aggressive (1 kg/week)',
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildPaceOption(
                            'Slow & Steady (0.25 kg/week)',
                            weightLossPace == 'Slow & Steady (0.25 kg/week)',
                            () => setState(
                              () => weightLossPace =
                                  'Slow & Steady (0.25 kg/week)',
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: calculateBMI,
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
                              child: const Text(
                                'Calculate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Results
                    if (bmi > 0)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Your Results',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              bmi.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF667EEA),
                              ),
                            ),
                            Text(
                              bmiCategory,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildResultRow(
                              'Daily Calorie Goal',
                              '$dailyCalories kcal',
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow(
                              'Daily Deficit',
                              '$dailyDeficit kcal',
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow(
                              'Estimated Time to Goal',
                              '$weeksToGoal weeks',
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow('Weekly Exercise', exerciseDays),
                          ],
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

  Widget _buildPaceOption(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF667EEA).withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF667EEA) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF667EEA) : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF667EEA),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFF667EEA) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
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

  @override
  void dispose() {
    currentWeightController.dispose();
    heightController.dispose();
    ageController.dispose();
    targetWeightController.dispose();
    super.dispose();
  }
}
