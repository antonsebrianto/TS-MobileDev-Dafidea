import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/widgets/header.dart';
import 'package:test_case_dafidea/view_model/user_view_model.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        isButtonActive = nameController.text.isNotEmpty ||
            emailController.text.isEmpty ||
            genderController.text.isEmpty;
      });
    });
    emailController.addListener(() {
      setState(() {
        isButtonActive = nameController.text.isNotEmpty ||
            emailController.text.isNotEmpty ||
            genderController.text.isNotEmpty;
      });
    });
    genderController.addListener(() {
      setState(() {
        isButtonActive = nameController.text.isNotEmpty ||
            emailController.text.isNotEmpty ||
            genderController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void editProfile() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure want to edit your profile ?',
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  Navigator.pop(context);
                  await Provider.of<UserViewModel>(context, listen: false)
                      .updateUser(
                          emailController.text.isEmpty
                              ? Provider.of<UserViewModel>(context,
                                      listen: false)
                                  .user
                                  .email
                                  .toString()
                              : emailController.text,
                          nameController.text.isEmpty
                              ? Provider.of<UserViewModel>(context,
                                      listen: false)
                                  .user
                                  .name
                                  .toString()
                              : nameController.text,
                          genderController.text.isEmpty
                              ? Provider.of<UserViewModel>(context,
                                      listen: false)
                                  .user
                                  .gender
                                  .toString()
                              : genderController.text);

                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await Provider.of<UserViewModel>(context, listen: false)
                        .getUser();
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
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const HeaderWidgets(
                title: 'Edit Profile',
                subtitle: 'Update your own profile',
                back: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.symmetric(horizontal: 52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: user.name,
                          hintStyle: const TextStyle(
                            color: AppTheme.greyText,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        // validator: (value) {
                        //   if (value!.length < 6) {
                        //     return 'Name must be at least 6 characters';
                        //   }
                        //   return null;
                        // },
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Email",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        //   LengthLimitingTextInputFormatter(20)
                        // ],
                        decoration: InputDecoration(
                          // suffixIcon: Transform(
                          //   alignment: Alignment.center,
                          //   transform: Matrix4.rotationY(math.pi),
                          //   child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         _secureText = !_secureText;
                          //       });
                          //     },
                          //     icon: Icon(
                          //       _secureText
                          //           ? Icons.visibility_off_outlined
                          //           : Icons.visibility,
                          //     ),
                          //   ),
                          // ),
                          hintText: user.email,
                          hintStyle: const TextStyle(
                            color: AppTheme.greyText,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                        // validator: (value) {
                        //   if (value!.length < 6) {
                        //     return 'Email must be at least 6 characters';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Gender",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        controller: genderController,
                        decoration: InputDecoration(
                          hintText: user.gender,
                          hintStyle: const TextStyle(
                            color: AppTheme.greyText,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        // validator: (value) {
                        //   if (value!.length < 6) {
                        //     return 'Name must be at least 6 characters';
                        //   }
                        //   return null;
                        // },
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 94),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.primaryTheme_2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            disabledBackgroundColor: AppTheme.disabled,
                          ),
                          onPressed: isButtonActive
                              ? () {
                                  if (formKey.currentState!.validate()) {
                                    editProfile();
                                  }
                                }
                              : null,
                          child: Text(
                            "Submit",
                            style: AppTextStyle.poppinsTextStyle(
                              fontSize: 14,
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
