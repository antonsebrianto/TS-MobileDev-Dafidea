import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case_dafidea/models/post_model.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/widgets/header.dart';
import 'package:test_case_dafidea/view_model/post_view_model.dart';

class FormInputPage extends StatefulWidget {
  const FormInputPage({super.key});

  @override
  State<FormInputPage> createState() => _FormInputPageState();
}

class _FormInputPageState extends State<FormInputPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {
        isButtonActive =
            titleController.text.isNotEmpty && bodyController.text.isNotEmpty;
      });
    });
    bodyController.addListener(() {
      setState(() {
        isButtonActive =
            titleController.text.isNotEmpty && bodyController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void loading() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await Provider.of<PostViewModel>(context, listen: false)
        .inputPost(titleController.text, bodyController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const HeaderWidgets(
                title: 'Create Post',
                subtitle: 'Create your own post',
                back: false,
              ),
              // Container(
              //   height: 300,
              //   margin:
              //       const EdgeInsets.symmetric(horizontal: 52, vertical: 40),
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("lib/assets/logo_logins.png"),
              //     ),
              //   ),
              // ),
              Container(
                height: 330,
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Input title post",
                        hintStyle: TextStyle(
                          color: AppTheme.greyText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title must be filled';
                        } else if (value.length < 6) {
                          return 'Title must be at least 6 characters';
                        }
                        return null;
                      },
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Body",
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: bodyController,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.deny(RegExp(r"\s")),
                      //   LengthLimitingTextInputFormatter(20)
                      // ],
                      decoration: const InputDecoration(
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
                        hintText: "Input body post",
                        hintStyle: TextStyle(
                          color: AppTheme.greyText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 14,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Body must be filled';
                        } else if (value.length < 20) {
                          return 'Body must be at least 20 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 64),
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
                            ? () async {
                                if (formKey.currentState!.validate()) {
                                  // final postViewModel =
                                  //     Provider.of<PostViewModel>(context,
                                  //         listen: false);
                                  // final createdPost =
                                  loading();
                                  // await Provider.of<PostViewModel>(context,
                                  //         listen: false)
                                  //     .inputPost(titleController.text,
                                  //         bodyController.text);

                                  // if (mounted) {
                                  //   final createdPost =
                                  //       Provider.of<PostViewModel>(context,
                                  //               listen: false)
                                  //           .post;
                                  //   if (createdPost.isNull) {
                                  //     showSuccessDialog(context, createdPost);
                                  //   } else {
                                  //     showFailedDialog(context, createdPost);
                                  //   }
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //         title: Text('Post Created'),
                                  //         content: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           mainAxisSize: MainAxisSize.min,
                                  //           children: [
                                  //             Text(
                                  //             'ID: ${createdPost ?? 0}'),
                                  //             Text(
                                  //                 'Title: ${createdPost?.title}'),
                                  //             Text(
                                  //                 'Body: ${createdPost.body}'),
                                  //           ],
                                  //         ),
                                  //         actions: [
                                  //           TextButton(
                                  //             onPressed: () {
                                  //               Navigator.of(context).pop();
                                  //             },
                                  //             child: Text('OK'),
                                  //           ),
                                  //         ],
                                  //       );
                                  //     });
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context, PostModel post) {
                                  //       return AlertDialog(
                                  //         title: Text('Success'),
                                  //         content: Column(
                                  //           children: [
                                  //             Text(
                                  //                 'Post created successfully.'),
                                  //             // Text()
                                  //           ],
                                  //         ),
                                  //         actions: [
                                  //           TextButton(
                                  //               onPressed: () {},
                                  //               child: Text('OK')),
                                  //         ],
                                  //       );
                                  //     });
                                  // }
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     pageBuilder:
                                  //         (context, animation1, animation2) =>
                                  //             HomePage(),
                                  //     transitionsBuilder: (context, animation1,
                                  //         animation2, child) {
                                  //       return FadeTransition(
                                  //         opacity: animation1,
                                  //         child: child,
                                  //       );
                                  //     },
                                  //     transitionDuration:
                                  //         const Duration(milliseconds: 1200),
                                  //   ),
                                  //   (route) => false,
                                  // );
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
            ],
          ),
        ),
      ),
    );
  }
}
