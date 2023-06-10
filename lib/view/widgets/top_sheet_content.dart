import 'package:flutter/material.dart';

import 'package:test_case_dafidea/models/post_model.dart';

class TopSheetContent extends StatelessWidget {
  final double height;
  final PostModel post;
  final bool isPressed;
  final bool isPopuler;
  const TopSheetContent({
    Key? key,
    required this.height,
    required this.post,
    required this.isPressed,
    this.isPopuler = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
            tag: 'animasi${post.id}',
            child: Image.asset(
              'lib/assets/foto.png',
              fit: BoxFit.cover,
              height: height / 2,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 48, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
