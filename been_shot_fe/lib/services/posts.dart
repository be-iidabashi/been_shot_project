import '../models/post_form.dart';
import '../models/posts.dart';
import 'dio.dart';

class PostsService {
  static const _protocol =
      String.fromEnvironment('PROTOCOL', defaultValue: 'http');
  static const _domain =
      String.fromEnvironment('DOMAIN', defaultValue: 'localhost:8000');
  static String baseUrl = '$_protocol://$_domain/api';
  final dioClient = DioClient().authDio;
  Future<List<Post>> fetchPosts() async {
    final url = '$baseUrl/posts/';
    final response = await dioClient.get(url);
    final jsonList = response.data as List<dynamic>;
    return jsonList
        .map((jsonItem) => Post.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }

  Future<Post> getPost(int id) async {
    final url = '$baseUrl/posts/$id/';
    final response = await dioClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('取得に失敗しました');
    }
    return Post.fromJson(response.data);
  }

  Future<void> createPost(PostForm post) async {
    final url = '$baseUrl/posts/';
    final formData = await post.toFormData();
    final response = await dioClient.post(url, data: formData);
    if (response.statusCode != 201) {
      throw Exception('作成に失敗しました');
    }
    if (response.data == null) {
      throw Exception('レスポンスが null です');
    }
  }

  Future<void> updatePost(int id, PostForm post) async {
    final url = '$baseUrl/posts/$id/';
    final formData = await post.toFormData();
    final response = await dioClient.patch(url, data: formData);
    if (response.statusCode != 200) {
      throw Exception('保存に失敗しました');
    }
    if (response.data == null) {
      throw Exception('レスポンスが null です');
    }
  }

  Future<void> deletePost(int id) async {
    final url = '$baseUrl/posts/$id/';
    final response = await dioClient.delete(url);
    if (response.statusCode != 204) {
      throw Exception('削除に失敗しました');
    }
  }

}