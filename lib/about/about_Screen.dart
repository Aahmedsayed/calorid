import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AppBar
            Container(
              height: 90,
              padding: const EdgeInsets.only(left: 20, top: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff6E65C7),
                    Color(0xff667EEA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8
                    ),
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Icon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xff5D7BFF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.info_outline,
                  color: Colors.black, size: 50),
            ),

            const SizedBox(height: 12),

            const Text(
              "About Us",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xff5D7BFF),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Learn more about our story and mission",
              style: TextStyle(color: Color(0xff5D7BFF), fontSize: 16),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _box(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Our Mission",
                        style: TextStyle(color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,),
                      ),

                      const SizedBox(height: 15),

                      Text("We are dedicated to creating innovative solutions that empower people to achieve their goals. Our platform combines cutting-edge technology with user-friendly design to deliver exceptional experiences.",
                        style: TextStyle(color: Colors.grey,
                            fontSize: 15),
                      ),
                    ],
                  )
              ),
            ),

            const SizedBox(height: 25),

            // Stats (صف واحد)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _stat("10K+", "Users"),
                  const SizedBox(width: 10),
                  _stat("50+", "Countries"),
                  const SizedBox(width: 10),
                  _stat("4.9", "Rating"),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _title("What We Offer"),

            _offer(Icons.lightbulb, "Innovation",
                "Cutting-edge solutions for modern challenges"),
            _offer(Icons.verified_user, "Quality",
                "Premium experience in every interaction"),
            _offer(Icons.headset_mic, "Support",
                "24/7 assistance whenever you need it"),

            const SizedBox(height: 28),

            _title("Our Team"),

            // Team boxes (صف واحد)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _team("Mostafa", "CEO"),
                    _team("Ahmed", "CTO"),
                    _team("Youssef", "Designer"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            _title("Our Team"),

            // Values (صف واحد)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _value("Innovation",
                        "We constantly push boundaries and embrace new technologies"),
                    _value("Quality",
                        "Excellence is at the core of everything we do"),
                    _value("Support",
                        "Our team is always ready to help you succeed"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  static Widget _stat(String num, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: _box(),
        child: Column(
          children: [
            Text(num,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5D7BFF))),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  static Widget _offer(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _box(),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff5D7BFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(sub,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _team(String name, String role) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xff5D7BFF),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 8),
          Text(name,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(role,
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _value(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xff5D7BFF),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 8),
          Text(title,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text(desc,
              textAlign: TextAlign.center,
              style:
              const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}