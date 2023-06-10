import 'package:dio/dio.dart';
import 'package:test_case_dafidea/models/post_model.dart';

class PostAPI {
  static const String url = "https://gorest.co.in/public/v2/posts";

  final Dio dio = Dio();
  Future<List<PostModel>> getPosts(int page, int limit) async {
    try {
      final response = await dio.get(url, queryParameters: {
        'page': page,
        'per_page': limit,
      });
      if (response.statusCode == 200) {
        final dataPost = response.data;
        List<PostModel> post = List<PostModel>.from(
            dataPost.map((model) => PostModel.fromJson(model)));
        return post;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Failed to connect server');
    }
  }

  Future<PostModel> inputPost(String title, String body) async {
    try {
      final response =
          await dio.post("https://gorest.co.in/public/v2/users/2731908/posts",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization':
                    'Bearer 899194e69e56516012076953034b5e7ef67f3f48bfae2e3e2fc81e043aabcdcb'
              }),
              data: {
            'title': title,
            'body': body,
          });
      if (response.statusCode == 201) {
        print(response.data);
        // final dataPost = response.data;
        // List<PostModel> post = List<PostModel>.from(
        //     dataPost.map((model) => PostModel.fromJson(model)));
        // final post = PostModel.fromJson(dataPost);

        return PostModel.fromJson(response.data);
        // return post;
      } else {
        throw Exception('Failed to input data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
