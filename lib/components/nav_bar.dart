import 'package:bankingapp/pages/home_screen.dart';
import 'package:bankingapp/pages/messages_screen.dart';
import 'package:bankingapp/pages/search_screen.dart';
import 'package:bankingapp/pages/setting_screen.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MessagesScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: GNav(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          gap: 8,
          activeColor: Colors.white,
          tabBackgroundGradient: AppColor.bgColor,
          onTabChange: (index) => setState(() {
            selectedIndex = index;
          }),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              // textStyle: AppStyles.paragraphSmall.copyWith(color: Colors.white),
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
              iconColor: AppColor.neutral_2,
              textStyle: AppStyles.paragraphSmall.copyWith(color: Colors.white),
            ),
            GButton(
              icon: Icons.mail,
              text: 'Messages',
              textStyle: AppStyles.paragraphSmall.copyWith(color: Colors.white),
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              textStyle: AppStyles.paragraphSmall.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: _screens[selectedIndex],
    );
  }
}
