import 'package:flutter/material.dart';
import 'package:test_case_dafidea/theme/constant.dart';

class HeaderWidgets extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool back;
  const HeaderWidgets(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.back});

  @override
  Widget build(BuildContext context) {
    return back == false
        ? Container(
            height: 150,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gray_2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.gradient_1, AppTheme.gradient_2],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Hi, Anton',
                        title,
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.white,
                            fontSize: 14,
                            fontsWeight: FontWeight.w700),
                      ),
                      Text(
                        // 'Find topics that you like to read',
                        subtitle,
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.white,
                          fontSize: 14,
                          fontsWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: 180,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gray_2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.gradient_1, AppTheme.gradient_2],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppTheme.white,
                          size: 28,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 28),
                      child: Text(
                        // 'Hi, Anton',
                        title,
                        style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.white,
                            fontSize: 14,
                            fontsWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        // 'Find topics that you like to read',
                        subtitle,
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.white,
                          fontSize: 14,
                          fontsWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
