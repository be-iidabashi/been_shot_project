import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_form.freezed.dart';

@freezed
abstract class PostForm with _$PostForm {
  const factory PostForm({
    required String content,
    File? photo,
  }) = _PostForm;
  const PostForm._();

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{
      'content': content,
    };

    if (photo != null) {
      map['photo'] = await MultipartFile.fromFile(photo!.path);
    }

    return FormData.fromMap(map);
  }
}