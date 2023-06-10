import 'package:flutter/material.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/form_input_view.dart';
import 'package:test_case_dafidea/view/home_view.dart';
import 'package:test_case_dafidea/view/profile_view.dart';

class BottomNavigationView extends StatefulWidget {
  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FormInputPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          // need rounded corner bottom navbar
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_2,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppTheme.primaryTheme,
          selectedLabelStyle: AppTextStyle.poppinsTextStyle(
            color: AppTheme.primaryTheme,
            fontSize: 12,
            fontsWeight: FontWeight.w700,
          ),
          unselectedIconTheme: const IconThemeData(color: AppTheme.gray_2),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // icon: Icon(PhosphorIcons.book_open_bold),
              icon: Icon(Icons.home, size: 24, color: AppTheme.gray_2),
              activeIcon:
                  Icon(Icons.home, size: 24, color: AppTheme.primaryTheme),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Form Input',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
