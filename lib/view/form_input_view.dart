import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    if (mounted) {
      Navigator.pop(context);
    }
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
                      decoration: const InputDecoration(
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
                                  loading();
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
