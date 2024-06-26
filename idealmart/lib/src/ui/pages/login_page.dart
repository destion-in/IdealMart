import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idealmart/src/ui/common/widgets/border_textfield.dart';
import 'package:idealmart/src/ui/pages/home.dart';
import 'package:idealmart/src/ui/pages/signup_page.dart'; // Assuming this path is correct
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse(
          'https://idealmart.onrender.com/api/v1/idm/customer/verify');
      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": _emailController.text,
            "password": _passwordController.text,
          }),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          var user = jsonDecode(response.body);

          // Store data locally
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userName', user['name']);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login Successful, welcome ${user['name']}'),
          ));

          // Navigate to home page or wherever appropriate
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(
              userName: user['name'],
            ), // Adjust accordingly
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Login Failed: ${jsonDecode(response.body)['message']}'),
          ));
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = viewInsets > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Flexible(
                flex: isKeyboardVisible ? 1 : 2,
                child: Image.asset(
                  'assets/images/bg.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height:
                      constraints.maxHeight * (isKeyboardVisible ? 0.3 : 0.4),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: const Text(
                          '#1 Grocery Delivery and Deals App',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DividerSection(),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EmailField(controller: _emailController),
                            const SizedBox(height: 16),
                            PasswordField(controller: _passwordController),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : LoginButton(onPressed: _login),
                      const SizedBox(height: 20),
                      RegisterSection(context),
                      const SizedBox(height: 20),
                      TermsText(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget DividerSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ),
    ],
  );
}

Widget EmailField({required TextEditingController controller}) {
  return BorderTextField(
    hintText: 'Email',
    prefixIcon:
        const Icon(Icons.email, color: Color.fromRGBO(169, 176, 185, 1)),
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      // Add more email validation logic if needed
      return null;
    },
  );
}

Widget PasswordField({required TextEditingController controller}) {
  return BorderTextField(
    hintText: 'Password',
    obscureText: true,
    prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(169, 176, 185, 1)),
    suffixIcon: const Icon(Icons.remove_red_eye,
        color: Color.fromRGBO(169, 176, 185, 1)),
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      // Add more password validation logic if needed
      return null;
    },
  );
}

Widget LoginButton({required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: const Text(
      'Login',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: Color(0xFF275F61),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}

Widget RegisterSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Don\'t have an account?',
        style: TextStyle(color: Colors.grey),
      ),
      TextButton(
        onPressed: () {
          // Assuming RegistrationPage is the widget for the registration screen
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    SignupPage()), // Ensure RegistrationPage is correctly imported
          );
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Color(0xFF275F61)),
        ),
      ),
    ],
  );
}

Widget TermsText() {
  return const Text(
    'By continuing, you agree to our Terms of Service and Privacy Policy',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.grey, fontSize: 12),
  );
}
