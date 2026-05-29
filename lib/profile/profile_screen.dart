import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test103/providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profileData = profileProvider.profileData;
    
    final fullName = profileData?['fullName'] ?? 'User';
    final email = profileData?['email'] ?? 'N/A';
    final age = profileData?['age']?.toString() ?? '-';
    final height = profileData?['heightCm']?.toString() ?? '-';
    final weight = profileData?['currentWeightKg']?.toString() ?? '-';
    final targetWeight = profileData?['targetWeightKg']?.toString() ?? '-';
    final gender = profileData?['gender'] ?? '-';
    final dailyCalories = profileData?['dailyCalorieGoal']?.toString() ?? '-';
    final dailyDeficit = profileData?['dailyDeficit']?.toString() ?? '-';
    final timeToGoal = profileData?['timeToGoalWeeks']?.toString() ?? '-';
    final weeklyExercise = profileData?['exerciseDays']?.toString() ?? '-';
    final weightLossPace = profileData?['weightLossPace'] ?? '-';
    final bmi = profileData?['profileExtras']?['bmiCategory'] ?? '-'; // using the category or you can calculate

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context, fullName, email, weight, targetWeight, bmi),
              const SizedBox(height: 16),
              _buildInfoCard(
                title: "Personal Information",
                icon: Icons.person_outline,
                items: [
                  _InfoRow("Age", "$age years"),
                  _InfoRow("Height", "$height cm"),
                  _InfoRow("Gender", gender),
                ],
              ),
              _buildInfoCard(
                title: "Health Metrics",
                icon: Icons.monitor_heart_outlined,
                items: [
                  _InfoRow("Current Weight", "$weight kg"),
                  _InfoRow("Target Weight", "$targetWeight kg"),
                  _InfoRow("Daily Calorie Goal", "$dailyCalories kcal"),
                  _InfoRow("Daily Deficit", "$dailyDeficit kcal"),
                ],
              ),
              _buildInfoCard(
                title: "Exercise Routine",
                icon: Icons.fitness_center_outlined,
                items: [
                  _InfoRow("Weekly Exercise", "$weeklyExercise days"),
                  _InfoRow("Weight Loss Pace", weightLossPace),
                  _InfoRow("Estimated Time to Goal", "$timeToGoal weeks"),
                ],
              ),
              _buildProgressCard(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff667EEA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.edit,
                      color: Color(0xffffffff),),
                    label: const Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18,
                          color: Color(0xffffffff)
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, String email, String weight, String goalWeight, String bmi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff6E65C7),
            Color(0xff667EEA)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleIcon(Icons.arrow_back, () => Navigator.pop(context)),
              const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _circleIcon(Icons.settings, () {}),
            ],
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_4, size: 40, color: Color(0xff2F6FED)),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatCard(weight, "Weight (kg)"),
              _StatCard(bmi, "BMI Status"),
              _StatCard(goalWeight, "Goal (kg)"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<_InfoRow> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff667EEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xffffffff)),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(

                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff667EEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Icon(Icons.track_changes, color: Color(0xffffffff)),
                ),
                const SizedBox (width: 10),
                Text(
                  "Goals Progress",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Reach Target Weight"),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: 0.6,
              color: const Color(0xff2F6FED),
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            const Text("Weekly Exercise Target"),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: 0.75,
              color: const Color(0xff2F6FED),
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}