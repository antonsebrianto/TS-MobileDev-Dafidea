import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case_dafidea/view/widgets/post.dart';
import 'package:test_case_dafidea/view/widgets/header.dart';
import 'package:test_case_dafidea/view_model/user_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderWidgets(
                  title: user?.displayName == null
                      ? 'Hi, ${user?.email}'
                      : 'Hi, ${user?.displayName}',
                  subtitle: 'Find topics that you like to read',
                  back: false,
                ),
                const PostWidgets(),
              ],
            ),
          );
        },
      ),
    );
  }
}
