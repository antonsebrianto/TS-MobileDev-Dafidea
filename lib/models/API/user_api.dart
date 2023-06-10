import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_case_dafidea/models/user_model.dart';

class UserAPI {
  static const String url = "https://gorest.co.in/public/v2/users/2731908";

  final Dio dio = Dio();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserModel> getUser() async {
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 899194e69e56516012076953034b5e7ef67f3f48bfae2e3e2fc81e043aabcdcb'
        }),
        // queryParameters: {
        //   'page': page,
        //   'per_page': limit,
        // }
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to connect server $e');
    }
  }

  Future<UserModel> updateUser(String email, String name, String gender) async {
    try {
      final response = await dio.put(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 899194e69e56516012076953034b5e7ef67f3f48bfae2e3e2fc81e043aabcdcb'
          }),
          data: {'email': email, 'name': name, 'gender': gender});
      if (response.statusCode == 200) {
        print(response.data);
        // final dataPost = response.data;
        // List<UserModel> post = List<UserModel>.from(
        //     dataPost.map((model) => UserModel.fromJson(model)));
        // final post = UserModel.fromJson(dataPost);

        return UserModel.fromJson(response.data);
        // return post;
      } else {
        throw Exception('Failed to update data user');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await auth.signInWithCredential(credential);
    } catch (e) {
      print('Failed to login with google : $e');
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Wrong email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
