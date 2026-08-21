import 'package:riverpod_annotation/riverpod_annotation.dart';
// ↓Riverpod 2 系を使用しているので必要　※注釈参照
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/posts.dart';
import '../services/posts.dart';

part 'post_detail.g.dart';

@riverpod
Future<Post> postDetail(Ref ref, int id) async {
  final postService = PostsService();
  return postService.getPost(id);
}