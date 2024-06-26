import 'package:flutter/material.dart';
import 'package:idealmart/src/ui/pages/login_page.dart';
import 'package:idealmart/src/ui/pages/signup_page.dart'; // Assuming this is the correct path to the LoginPage

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              buildPageContent(
                  image: 'assets/images/intro3.png',
                  title: 'Local Store Offers',
                  description: 'Discover amazing deals at stores near you.'),
              buildPageContent(
                  image: 'assets/images/intro2.jpg',
                  title: 'Exclusive Discounts',
                  description:
                      'Get exclusive access to the best products at lower prices.'),
              buildPageContent(
                  image: 'assets/images/intro1.png',
                  title: 'Convenient Shopping',
                  description:
                      'Shop from the comfort of your home with easy payment options.'),
            ],
          ),
          Positioned(
            bottom: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(context, 'Login', true, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }),
                SizedBox(width: 20), // Space between buttons
                _buildButton(context, 'Register', false, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            SignupPage()), // Change to your registration page route
                  );
                }),
              ],
            ),
          ),
          Positioned(
            bottom: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index, context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, bool isFilled,
      VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled
              ? Colors.white
              : Color(
                  0xFF275F61), // Text color changes based on the button style
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: isFilled ? Colors.white : Color(0xFF275F61),
        backgroundColor: isFilled
            ? Color(0xFF275F61)
            : Colors.white, // Effect color for splash
        side: BorderSide(color: Color(0xFF275F61), width: 1), // Border color
        elevation: 0, // Remove shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        minimumSize: Size(150, 50), // Button size
      ),
    );
  }

  Widget buildPageContent(
      {required String image,
      required String title,
      required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(image, height: 300, width: 300, fit: BoxFit.cover),
        const SizedBox(height: 25),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: _currentPage == index ? 24 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF275F61) : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
