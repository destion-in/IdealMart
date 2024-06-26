import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idealmart/src/ui/common/widgets/border_textfield.dart';
import 'package:idealmart/src/ui/pages/login_page.dart'; // Assuming this path is correct

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final url =
          Uri.parse('https://idealmart.onrender.com/api/v1/idm/customer');
      http
          .post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": _emailController.text,
          "password": _passwordController.text,
          "name": "Your Name", // You might want to add an input field for this
          "pcode": _pincodeController.text,
          "phone": _phoneController.text,
        }),
      )
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Signup Successful'),
          ));
          // Optionally navigate to login or another page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Signup Failed: ${jsonDecode(response.body)['message']}'),
          ));
        }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $error'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/logos/logo.png',
                fit: BoxFit.cover,
                // width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Ideal Mart',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    DividerSection(),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          EmailField(controller: _emailController),
                          const SizedBox(height: 16),
                          PasswordField(controller: _passwordController),
                          const SizedBox(height: 16),
                          PhoneField(controller: _phoneController),
                          const SizedBox(height: 16),
                          PincodeField(controller: _pincodeController),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? CircularProgressIndicator()
                        : SignupButton(onPressed: _signup),
                    const SizedBox(height: 20),
                    LoginSection(context),
                    const SizedBox(height: 20),
                    TermsText(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          'Create a Free Account',
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

Widget PhoneField({required TextEditingController controller}) {
  return BorderTextField(
    hintText: 'Phone',
    prefixIcon:
        const Icon(Icons.phone, color: Color.fromRGBO(169, 176, 185, 1)),
    keyboardType: TextInputType.phone,
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      }
      // Add more phone validation logic if needed
      return null;
    },
  );
}

Widget PincodeField({required TextEditingController controller}) {
  return BorderTextField(
    hintText: 'Pincode',
    prefixIcon:
        const Icon(Icons.location_pin, color: Color.fromRGBO(169, 176, 185, 1)),
    keyboardType: TextInputType.number,
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your pincode';
      }
      // Add more pincode validation logic if needed
      return null;
    },
  );
}

Widget SignupButton({required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: const Text(
      'Signup',
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

Widget LoginSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Already have an account?',
        style: TextStyle(color: Colors.grey),
      ),
      InkWell(
        onTap: () {
          // Replace the current route with the Login Page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage()), // Ensure LoginPage is correctly imported
          );
        },
        child: const Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF275F61),
            decoration:
                TextDecoration.underline, // Makes it clear it's clickable
          ),
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
