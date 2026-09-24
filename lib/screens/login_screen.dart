import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate authentication request
      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Navigate to Home Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _handleSocialLogin(String provider) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate social authentication request
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed in with $provider!'),
        backgroundColor: const Color(0xFFE07A5F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFFAF7F2);
    const textColor = Color(0xFF2D2321);
    const subtitleColor = Color(0xFF7A736E);
    const primaryButtonColor = Color(0xFFE07A5F);
    const inputBorderColor = Color(0xFFE6E1DA);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  // Cat and Dog Logo Header
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2E8DC),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: primaryButtonColor.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const CatAndDogLogo(size: 140),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  const Text(
                    'Pet Care',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9E978F),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: primaryButtonColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleLogin(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9E978F),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF554D4A),
                            size: 22,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: inputBorderColor, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: primaryButtonColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Log In Button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryButtonColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Divider with "OR"
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: inputBorderColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: subtitleColor.withOpacity(0.8),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: inputBorderColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sign in with Google Button
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : () => _handleSocialLogin('Google'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: inputBorderColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GoogleGIcon(size: 22),
                          SizedBox(width: 12),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Sign in with Apple Button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () => _handleSocialLogin('Apple'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.apple, size: 24, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Sign in with Apple',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Bottom Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          fontSize: 15,
                          color: subtitleColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign up coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

/// Custom Vector Illustration displaying a Cat and Dog together.
class CatAndDogLogo extends StatelessWidget {
  final double size;

  const CatAndDogLogo({super.key, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.35,
      height: size,
      child: CustomPaint(
        painter: _CatAndDogPainter(),
      ),
    );
  }
}

class _CatAndDogPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final dogFacePaint = Paint()..color = const Color(0xFFE5AA70); // Golden tan
    final dogEarPaint = Paint()..color = const Color(0xFFC07A46);  // Brown ears
    final dogSnoutPaint = Paint()..color = const Color(0xFFFFF6ED);

    final catFacePaint = Paint()..color = const Color(0xFFF7B267); // Cat warm orange fur
    final catInnerEarPaint = Paint()..color = const Color(0xFFFFB8B8); // Pink inner ear
    final catSnoutPaint = Paint()..color = const Color(0xFFFFFFFF);

    final darkPaint = Paint()..color = const Color(0xFF2D2321);
    final highlightPaint = Paint()..color = Colors.white;
    final pinkPaint = Paint()..color = const Color(0xFFFF8A8A);

    final linePaint = Paint()
      ..color = const Color(0xFF2D2321)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // ------------------- DOG (LEFT) -------------------
    final dogCenter = Offset(w * 0.32, h * 0.52);
    final dogRadius = h * 0.32;

    // Dog Ears
    final leftEarPath = Path()
      ..addOval(Rect.fromLTWH(dogCenter.dx - dogRadius * 1.2, dogCenter.dy - dogRadius * 0.5, dogRadius * 0.6, dogRadius * 1.2));
    canvas.save();
    canvas.translate(dogCenter.dx - dogRadius * 0.9, dogCenter.dy - dogRadius * 0.1);
    canvas.rotate(-0.25);
    canvas.translate(-(dogCenter.dx - dogRadius * 0.9), -(dogCenter.dy - dogRadius * 0.1));
    canvas.drawPath(leftEarPath, dogEarPaint);
    canvas.restore();

    final rightEarPath = Path()
      ..addOval(Rect.fromLTWH(dogCenter.dx + dogRadius * 0.6, dogCenter.dy - dogRadius * 0.5, dogRadius * 0.6, dogRadius * 1.2));
    canvas.save();
    canvas.translate(dogCenter.dx + dogRadius * 0.9, dogCenter.dy - dogRadius * 0.1);
    canvas.rotate(0.25);
    canvas.translate(-(dogCenter.dx + dogRadius * 0.9), -(dogCenter.dy - dogRadius * 0.1));
    canvas.drawPath(rightEarPath, dogEarPaint);
    canvas.restore();

    // Dog Head
    canvas.drawCircle(dogCenter, dogRadius, dogFacePaint);

    // Dog Snout
    final dogSnoutRect = Rect.fromCenter(
      center: Offset(dogCenter.dx, dogCenter.dy + dogRadius * 0.35),
      width: dogRadius * 1.1,
      height: dogRadius * 0.8,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(dogSnoutRect, Radius.circular(dogRadius * 0.4)), dogSnoutPaint);

    // Dog Tongue
    final dogTongueRect = Rect.fromCenter(
      center: Offset(dogCenter.dx, dogCenter.dy + dogRadius * 0.75),
      width: dogRadius * 0.32,
      height: dogRadius * 0.4,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(dogTongueRect, Radius.circular(dogRadius * 0.16)), pinkPaint);

    // Dog Nose
    final dogNoseRect = Rect.fromCenter(
      center: Offset(dogCenter.dx, dogCenter.dy + dogRadius * 0.18),
      width: dogRadius * 0.38,
      height: dogRadius * 0.28,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(dogNoseRect, Radius.circular(dogRadius * 0.12)), darkPaint);

    // Dog Eyes
    final dogEyeLeft = Offset(dogCenter.dx - dogRadius * 0.42, dogCenter.dy - dogRadius * 0.18);
    final dogEyeRight = Offset(dogCenter.dx + dogRadius * 0.42, dogCenter.dy - dogRadius * 0.18);
    canvas.drawCircle(dogEyeLeft, dogRadius * 0.13, darkPaint);
    canvas.drawCircle(dogEyeRight, dogRadius * 0.13, darkPaint);
    canvas.drawCircle(Offset(dogEyeLeft.dx - 1.5, dogEyeLeft.dy - 1.5), dogRadius * 0.04, highlightPaint);
    canvas.drawCircle(Offset(dogEyeRight.dx - 1.5, dogEyeRight.dy - 1.5), dogRadius * 0.04, highlightPaint);

    // ------------------- CAT (RIGHT) -------------------
    final catCenter = Offset(w * 0.68, h * 0.52);
    final catRadius = h * 0.30;

    // Cat Ears
    final catLeftEar = Path()
      ..moveTo(catCenter.dx - catRadius * 0.8, catCenter.dy - catRadius * 0.3)
      ..lineTo(catCenter.dx - catRadius * 0.85, catCenter.dy - catRadius * 1.2)
      ..lineTo(catCenter.dx - catRadius * 0.2, catCenter.dy - catRadius * 0.75)
      ..close();

    final catRightEar = Path()
      ..moveTo(catCenter.dx + catRadius * 0.8, catCenter.dy - catRadius * 0.3)
      ..lineTo(catCenter.dx + catRadius * 0.85, catCenter.dy - catRadius * 1.2)
      ..lineTo(catCenter.dx + catRadius * 0.2, catCenter.dy - catRadius * 0.75)
      ..close();

    canvas.drawPath(catLeftEar, catFacePaint);
    canvas.drawPath(catRightEar, catFacePaint);

    // Cat Inner Ears
    final catLeftInnerEar = Path()
      ..moveTo(catCenter.dx - catRadius * 0.7, catCenter.dy - catRadius * 0.4)
      ..lineTo(catCenter.dx - catRadius * 0.78, catCenter.dy - catRadius * 1.0)
      ..lineTo(catCenter.dx - catRadius * 0.3, catCenter.dy - catRadius * 0.7)
      ..close();

    final catRightInnerEar = Path()
      ..moveTo(catCenter.dx + catRadius * 0.7, catCenter.dy - catRadius * 0.4)
      ..lineTo(catCenter.dx + catRadius * 0.78, catCenter.dy - catRadius * 1.0)
      ..lineTo(catCenter.dx + catRadius * 0.3, catCenter.dy - catRadius * 0.7)
      ..close();

    canvas.drawPath(catLeftInnerEar, catInnerEarPaint);
    canvas.drawPath(catRightInnerEar, catInnerEarPaint);

    // Cat Head
    canvas.drawCircle(catCenter, catRadius, catFacePaint);

    // Cat Snout
    final catSnoutRect = Rect.fromCenter(
      center: Offset(catCenter.dx, catCenter.dy + catRadius * 0.35),
      width: catRadius * 0.9,
      height: catRadius * 0.6,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(catSnoutRect, Radius.circular(catRadius * 0.3)), catSnoutPaint);

    // Cat Nose
    final catNosePath = Path()
      ..moveTo(catCenter.dx - catRadius * 0.15, catCenter.dy + catRadius * 0.18)
      ..lineTo(catCenter.dx + catRadius * 0.15, catCenter.dy + catRadius * 0.18)
      ..lineTo(catCenter.dx, catCenter.dy + catRadius * 0.32)
      ..close();
    canvas.drawPath(catNosePath, pinkPaint);

    // Cat Whiskers
    final whiskerY = catCenter.dy + catRadius * 0.32;
    canvas.drawLine(Offset(catCenter.dx - catRadius * 0.4, whiskerY - 3), Offset(catCenter.dx - catRadius * 1.05, whiskerY - 9), linePaint);
    canvas.drawLine(Offset(catCenter.dx - catRadius * 0.4, whiskerY + 3), Offset(catCenter.dx - catRadius * 1.05, whiskerY + 7), linePaint);
    canvas.drawLine(Offset(catCenter.dx + catRadius * 0.4, whiskerY - 3), Offset(catCenter.dx + catRadius * 1.05, whiskerY - 9), linePaint);
    canvas.drawLine(Offset(catCenter.dx + catRadius * 0.4, whiskerY + 3), Offset(catCenter.dx + catRadius * 1.05, whiskerY + 7), linePaint);

    // Cat Eyes
    final catEyeLeft = Offset(catCenter.dx - catRadius * 0.42, catCenter.dy - catRadius * 0.15);
    final catEyeRight = Offset(catCenter.dx + catRadius * 0.42, catCenter.dy - catRadius * 0.15);
    canvas.drawCircle(catEyeLeft, catRadius * 0.13, darkPaint);
    canvas.drawCircle(catEyeRight, catRadius * 0.13, darkPaint);
    canvas.drawCircle(Offset(catEyeLeft.dx - 1.5, catEyeLeft.dy - 1.5), catRadius * 0.04, highlightPaint);
    canvas.drawCircle(Offset(catEyeRight.dx - 1.5, catEyeRight.dy - 1.5), catRadius * 0.04, highlightPaint);

    // Floating Heart
    final heartCenter = Offset(w * 0.5, h * 0.18);
    final heartPath = Path()
      ..moveTo(heartCenter.dx, heartCenter.dy + 6)
      ..cubicTo(heartCenter.dx - 10, heartCenter.dy - 5, heartCenter.dx - 14, heartCenter.dy + 10, heartCenter.dx, heartCenter.dy + 18)
      ..cubicTo(heartCenter.dx + 14, heartCenter.dy + 10, heartCenter.dx + 10, heartCenter.dy - 5, heartCenter.dx, heartCenter.dy + 6)
      ..close();
    canvas.drawPath(heartPath, Paint()..color = const Color(0xFFE07A5F));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Official 4-color Google G icon vector painter
class GoogleGIcon extends StatelessWidget {
  final double size;

  const GoogleGIcon({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GoogleGIconPainter(),
      ),
    );
  }
}

class _GoogleGIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    final blue = Paint()..color = const Color(0xFF4285F4);
    final green = Paint()..color = const Color(0xFF34A853);
    final yellow = Paint()..color = const Color(0xFFFBBC05);
    final red = Paint()..color = const Color(0xFFEA4335);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Red arc (top)
    canvas.drawArc(rect, -0.8, 1.8, true, red);
    // Yellow arc (bottom-left)
    canvas.drawArc(rect, 1.0, 1.2, true, yellow);
    // Green arc (bottom-right)
    canvas.drawArc(rect, 2.2, 1.2, true, green);
    // Blue arc (right & bar)
    canvas.drawArc(rect, -0.4, 1.0, true, blue);

    // Inner white cutout
    canvas.drawCircle(center, radius * 0.55, Paint()..color = Colors.white);

    // Blue horizontal bar
    final barPath = Path()
      ..addRect(Rect.fromLTWH(center.dx, center.dy - radius * 0.22, radius, radius * 0.44));
    canvas.drawPath(barPath, blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
