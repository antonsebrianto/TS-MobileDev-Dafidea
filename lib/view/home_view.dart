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
  // final PostAPI postAPI = PostAPI();
  // List<PostModel> posts = [];
  // // int page = 1;
  // static const int itemsPerPage = 10;
  // bool isLoading = false;

  // final PagingController<int, PostModel> _pagingController =
  //     PagingController(firstPageKey: 1);
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _pagingController.addPageRequestListener((pageKey) {
  //     fetchPosts(pageKey);
  //   });
  //   // fetchPosts();
  //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   //   Provider.of<PostViewModel>(context, listen: false).getPosts(page, 10);
  //   // });
  // }

  // Future<void> fetchPosts(int pageKey) async {
  //   try {
  //     final List<PostModel> posts =
  //         await postAPI.getPosts(pageKey, itemsPerPage);

  //     final isLastPage = posts.length < itemsPerPage;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(posts);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       _pagingController.appendPage(posts, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }
  // Future<void> fetchPosts() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     final List<PostModel> fetchedPosts =
  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //           Provider.of<PostViewModel>(context, listen: false)
  //             .getPosts(page, 10); // Fetch 10 posts per page
  //         },)
  //     setState(() {
  //       posts.addAll(fetchedPosts);
  //       page++;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     // Handle error
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Error'),
  //         content: Text('Failed to load posts. Please try again.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               fetchPosts();
  //             },
  //             child: Text('Retry'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  // Widget buildPostList() {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height,
  //     child: PagedListView<int, PostModel>(
  //       pagingController: _pagingController,
  //       builderDelegate: PagedChildBuilderDelegate<PostModel>(
  //         itemBuilder: (context, post, index) {
  //           return ListTile(
  //             title: Text(post.title ?? ''),
  //             // Add other details or UI components as needed
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

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
                  // title: 'Hi, ${user?.displayName}',
                  title: user?.displayName == null
                      ? 'Hi, ${user?.email}'
                      : 'Hi, ${user?.displayName}',
                  subtitle: 'Find topics that you like to read',
                  back: false,
                ),
                // const SizedBox(
                //   height: 2,
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                const PostWidgets(),

                // buildPostList(),
                // PagedListView<int, PostModel>(
                //   pagingController: _pagingController,
                //   builderDelegate: PagedChildBuilderDelegate<PostModel>(
                //       itemBuilder: (context, post, index) {
                //     return const PostWidgets();
                //   }),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
