import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:test_case_dafidea/view/bottom_navigation_view.dart';
import 'package:test_case_dafidea/view/login_view.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<Slide>? slides; // Update the type to List<Slide>?

  @override
  void initState() {
    super.initState();
    slides = [
      Slide(
        title: "Welcome",
        description: "Slide 1 description",
        backgroundColor: Colors.blue,
        pathImage: "lib/assets/slide1.png", // Replace with your image path
      ),
      Slide(
        title: "Introduction",
        description: "Slide 2 description",
        backgroundColor: Colors.green,
        pathImage: "lib/assets/slide2.png", // Replace with your image path
      ),
      Slide(
        title: "Get Started",
        description: "Slide 3 description",
        backgroundColor: Colors.orange,
        pathImage: "lib/assets/slide3.png", // Replace with your image path
      ),
    ];
  }

  // void onDonePress() {
  //   // Perform any necessary actions when the user presses the "Done" button
  //   // e.g., navigate to the home screen
  //   checkLogin();
  //   // Navigator.pushReplacementNamed(context, '/login');
  // }

  Future<void> checkLogin(BuildContext context) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User? user = FirebaseAuth.instance.currentUser;

    // final id = sharedPreferences.getString('id');
    if (user?.uid == null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 1550),
          ),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BottomNavigationView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 1550),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        slides: slides!,
        onDonePress: () => checkLogin(context),
      ),
    );
  }
}
