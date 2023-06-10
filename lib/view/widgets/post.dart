import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  // final PagingController<int, PostModel> _pagingController =
  //     PagingController(firstPageKey: 1);
  final ScrollController _pagingController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pagingController.addPageRequestListener((pageKey) {
    fetchPosts(page, itemsPerPage);
    _pagingController.addListener(() {
      _scrollListener();
    });
    // });
    // fetchPosts();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<PostViewModel>(context, listen: false).getPosts(page, 10);
    // });
  }

  Future<void> fetchPosts(int pageKey, int perPage) async {
    try {
      posts = await postAPI.getPosts(pageKey, perPage);
      setState(() {});
      // final isLastPage = posts.length < itemsPerPage;
      // if (isLastPage) {
      //   // _pagingController.appendLastPage(posts);
      // } else {
      //   final nextPageKey = pageKey + 1;
      //   // _pagingController.appendPage(posts, nextPageKey);
      // }
    } catch (error) {
      // _pagingController.error = error;
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
  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.32,

      child: ListView.builder(
          controller: _pagingController,
          // padding: EdgeInsets.only(bottom: 20),
          // item: PagedChildBuilderDelegate<PostModel>(
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            // PostModel post = value.posts[index];
            if (index < posts.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: InkWell(
                    onTap: () async {
                      // await context
                      //     .read<CommentViewModel>()
                      //     .getComments(post.id ?? 0);
                      // if (mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPostPage(
                                    post: posts[index],
                                    index: index,
                                  )));
                      // }
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
      // ),
      // ),
    );
  }
}
