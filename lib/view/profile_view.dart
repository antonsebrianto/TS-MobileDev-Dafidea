import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/login_view.dart';
import 'package:test_case_dafidea/view/update_profile_view.dart';
import 'package:test_case_dafidea/view_model/user_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserViewModel>(context, listen: false).getUser();
    });
    // emailController.text = 'kristina.faboulus@mail.com';
    // telponController.text = '081213476509';
    // jurusanController.text = 'Seni Rupa';
    // tahunController.text = '2020/Semester 6';
    // ipkController.text = '3,85';
  }

  void logout() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure want to logout ?',
            style: AppTextStyle.poppinsTextStyle(
              fontSize: 15,
              fontsWeight: FontWeight.w700,
              color: AppTheme.black,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: AppTextStyle.poppinsTextStyle(
                    fontSize: 15,
                    fontsWeight: FontWeight.w500,
                    color: AppTheme.primaryTheme,
                  ),
                )),
            TextButton(
                onPressed: () async {
                  await Provider.of<UserViewModel>(context, listen: false)
                      .signOut();
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const LoginPage(),
                        transitionsBuilder:
                            (context, animation1, animation2, child) {
                          return FadeTransition(
                              opacity: animation1, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                child: Text(
                  'OK',
                  style: AppTextStyle.poppinsTextStyle(
                    fontSize: 15,
                    fontsWeight: FontWeight.w500,
                    color: AppTheme.primaryTheme,
                  ),
                ))
          ],
        );
      },
    );

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(21),
                height: 130,
                width: 130,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: AppTheme.white,
                      child: ClipPath(
                        clipper: const ShapeBorderClipper(
                          shape: CircleBorder(),
                        ),
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/3/34/PICA.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name ?? '',
                style: AppTextStyle.poppinsTextStyle(
                    fontSize: 24,
                    fontsWeight: FontWeight.w500,
                    color: AppTheme.black),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              Text(
                user.status ?? '',
                style: AppTextStyle.poppinsTextStyle(
                  fontSize: 16,
                  fontsWeight: FontWeight.w400,
                  color: AppTheme.black_3,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                    'Email',
                    user.email.toString() == 'null'
                        ? emailController
                        : TextEditingController(text: user.email.toString())),
                const SizedBox(
                  height: 14,
                ),
                _buildTextField(
                    'Gender',
                    user.gender.toString() == 'null'
                        ? genderController
                        : TextEditingController(text: user.gender.toString())),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 180)),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const UpdateProfilePage(),
                      transitionsBuilder:
                          (context, animation1, animation2, child) {
                        return FadeTransition(
                            opacity: animation1, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTheme_2,
                  foregroundColor: AppTheme.white,
                ),
                child: const Text('Edit Profile'),
              ),
              OutlinedButton(
                onPressed: () {
                  // await Provider.of<UserViewModel>(context, listen: false)
                  //     .logout();
                  logout();
                  // await Provider.of<UserViewModel>(context, listen: false)
                  //     .signOut();
                  // if (mounted) {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     PageRouteBuilder(
                  //       pageBuilder: (context, animation1, animation2) =>
                  //           const LoginPage(),
                  //       transitionsBuilder:
                  //           (context, animation1, animation2, child) {
                  //         return FadeTransition(
                  //             opacity: animation1, child: child);
                  //       },
                  //       transitionDuration: const Duration(milliseconds: 300),
                  //     ),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.primaryTheme),
                    foregroundColor: AppTheme.primaryTheme),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controllers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.poppinsTextStyle(
            fontSize: 16,
            fontsWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 245,
          height: 40,
          child: TextField(
            style: AppTextStyle.poppinsTextStyle(
              fontSize: 14,
              fontsWeight: FontWeight.w400,
              color: AppTheme.black,
            ),
            readOnly: true,
            controller: controllers,
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryTheme_4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
