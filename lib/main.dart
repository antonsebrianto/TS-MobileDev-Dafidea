import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/login_view.dart';
import 'package:test_case_dafidea/view/splash_view.dart';
import 'package:test_case_dafidea/view_model/post_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_case_dafidea/view_model/user_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => PostViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserViewModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
        primary: AppTheme.primaryTheme,
        secondary: AppTheme.primaryTheme,
      )),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
