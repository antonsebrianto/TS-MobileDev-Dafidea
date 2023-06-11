import 'package:flutter/material.dart';

import 'package:test_case_dafidea/models/API/post_api.dart';
import 'package:test_case_dafidea/models/post_model.dart';
import 'package:test_case_dafidea/theme/constant.dart';
import 'package:test_case_dafidea/view/detail_post_view.dart';

class PostWidgets extends StatefulWidget {
  const PostWidgets({Key? key}) : super(key: key);

  @override
  State<PostWidgets> createState() => _PostWidgetsState();
}

class _PostWidgetsState extends State<PostWidgets> {
  final PostAPI postAPI = PostAPI();
  List<PostModel> posts = [];
  int page = 1;
  int itemsPerPage = 10;
  bool isLoading = false;

  final ScrollController _pagingController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchPosts(page, itemsPerPage);
    _pagingController.addListener(() {
      _scrollListener();
    });
  }

  Future<void> fetchPosts(int pageKey, int perPage) async {
    try {
      posts = await postAPI.getPosts(pageKey, perPage);
      setState(() {});
    } catch (error) {
      print('Fetch posts : $error');
    }
  }

  @override
  void dispose() {
    _pagingController.removeListener(_scrollListener);
    _pagingController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_pagingController.position.pixels ==
        _pagingController.position.maxScrollExtent) {
      fetchPosts(page, itemsPerPage += 10);
      print(posts.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.32,
      child: ListView.builder(
          controller: _pagingController,
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPostPage(
                                    post: posts[index],
                                    index: index,
                                  )));
                    },
                    child: Stack(
                      children: [
                        Row(
                          children: <Widget>[
                            Hero(
                              tag: 'animasi${posts[index].id}',
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 4, bottom: 4),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(20, 20)),
                                  child: Image.asset(
                                    'lib/assets/foto.png',
                                    fit: BoxFit.cover,
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      posts[index].title ?? '',
                                      style: AppTextStyle.poppinsTextStyle(
                                        fontSize: 15,
                                        fontsWeight: FontWeight.w700,
                                        color: AppTheme.primaryTheme,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    posts[index].userId.toString(),
                                    style: AppTextStyle.poppinsTextStyle(
                                      fontSize: 14,
                                      fontsWeight: FontWeight.w600,
                                      color: AppTheme.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
