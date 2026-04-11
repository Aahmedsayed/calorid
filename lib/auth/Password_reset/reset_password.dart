import 'package:flutter/material.dart';
import 'package:test103/utils/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final Color primaryColor = const Color(0xFF5B7CFD);
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6E65C7),
              Color(0xff667EEA),
            ],

            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _backButton(context),

              Column(
                children: [
                  const SizedBox(height: 50),
                  _lockIcon(),
                  const SizedBox(height: 10),
                  _mainCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 12,
      left: 12,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.signIn),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.18),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _lockIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(.5), width: 2),
      ),
      child: const Icon(
        Icons.lock_outline_rounded,
        color: Colors.white,
        size: 48,
      ),
    );
  }

  Widget _mainCard() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 55
        ),
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            const Text(
              "Secure Password\nRecovery",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter Verification Code",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 12),

            const Text(
              "We've sent a 4-digit code to your email",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 26),

            _otpFields(),

            const SizedBox(height: 20),

            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey),
                children: [
                  const TextSpan(text: "Didn’t receive code? "),
                  TextSpan(
                    text: "Resend",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Verify Code",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            _secureInfoBox(),
          ],
        ),
      ),
    );
  }

  Widget _secureInfoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.verified_user_outlined,
              size: 18, color: Color(0xff667EEA)),
          SizedBox(width: 8),
          Text(
            "Your information is secure and encrypted",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff667EEA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 60,
          height: 60,
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        );
      }),
    );
  }
}
