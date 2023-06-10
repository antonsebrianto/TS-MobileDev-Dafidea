import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_case_dafidea/models/API/post_api.dart';
import 'package:test_case_dafidea/models/post_model.dart';

enum DataState {
  initial,
  loading,
  loaded,
  error,
}

class PostViewModel extends ChangeNotifier {
  PostAPI postAPI = PostAPI();
  List<PostModel> _posts = [];
  PostModel _post = PostModel();
  DataState _state = DataState.initial;
  PostModel get post => _post;
  List<PostModel> get posts => _posts;
  DataState get state => _state;

  getPosts(int page, int limit) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final posts = await postAPI.getPosts(page, limit);
      _posts = posts;
      _state = DataState.loaded;
      notifyListeners();
    } catch (e) {
      _state = DataState.error;
    }
    notifyListeners();
  }

  inputPost(String title, String body) async {
    _state = DataState.loading;
    notifyListeners();
    try {
      final post = await postAPI.inputPost(title, body);
      _post = post;
      _state = DataState.loaded;
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Post berhasil ditambahkan',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Gagal menambahkan post',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
