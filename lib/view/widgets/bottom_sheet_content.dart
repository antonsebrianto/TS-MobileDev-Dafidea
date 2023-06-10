import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_case_dafidea/models/post_model.dart';

class BottomSheetContent extends StatelessWidget {
  final double height;
  final double width;
  final PostModel post;
  const BottomSheetContent({
    Key? key,
    required this.height,
    required this.width,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: height / 20),
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.title ?? '',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            // const SizedBox(
            //   height: 12,
            // ),
            // Text(
            //   post.subtitle ?? '',
            //   style: const TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            // ),
            const SizedBox(
              height: 12,
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/3/34/PICA.jpg'))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  post.userId.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              post.body ?? '',
              style: const TextStyle(
                  color: Colors.black54, fontSize: 16.5, height: 1.4),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
