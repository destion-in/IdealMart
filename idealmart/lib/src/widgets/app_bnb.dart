// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';

// import 'package:idealmart/src/ui/pages/home.dart';
// import 'package:idealmart/src/ui/pages/profile_screen.dart';
// import 'package:idealmart/src/ui/pages/stores_screen.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(userName: 'User Name'), // Replace with actual user name
//     StoresScreen(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         useLegacyColorScheme: false,
//         backgroundColor: Colors.black,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(IconlyBroken.home),
//             activeIcon: Icon(IconlyBold.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(IconlyBroken.home),
//             activeIcon: Icon(IconlyBold.home),
//             label: 'Stores',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(IconlyBroken.profile),
//             activeIcon: Icon(IconlyBold.profile),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//       ),
//     );
//   }
// }
