import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:test_case_dafidea/theme/constant.dart';
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
        backgroundColor: Colors.blue,
        pathImage: "lib/assets/welcome.png",
        heightImage: 500,
        widthImage: 500,
      ),
      Slide(
        backgroundColor: Colors.green,
        pathImage: "lib/assets/introduction.png",
        heightImage: 500,
        widthImage: 500,
      ),
      Slide(
        backgroundColor: AppTheme.gradient_1,
        pathImage: "lib/assets/getstarted.png",
        heightImage: 500,
        widthImage: 500,
      ),
    ];
  }

  Future<void> checkLogin(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
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
