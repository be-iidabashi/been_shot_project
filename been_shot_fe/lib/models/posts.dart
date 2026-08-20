import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
part 'posts.freezed.dart';
part 'posts.g.dart';

@freezed
abstract class PostUser with _$PostUser {
  const factory PostUser({
    required int id,
    required String username,
    String? icon,
  }) = _PostUser;

  factory PostUser.fromJson(Map<String, Object?> json) =>
      _$PostUserFromJson(json);
}

@freezed
abstract class Post with _$Post {
  const Post._();

  const factory Post({
    required int id,
    required PostUser user,
    required String content,
    String? photo,
    required String createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
  String get formattedDateTime {
    final dateTime = DateTime.parse(createdAt).toLocal();
    return DateFormat('M/d HH:mm').format(dateTime);
  }
}