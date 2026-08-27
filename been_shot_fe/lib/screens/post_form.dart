import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_form.dart';
import '../providers/post_detail.dart';
import '../providers/post_list.dart';
import '../services/posts.dart';

class PostFormPage extends ConsumerStatefulWidget {
  const PostFormPage({super.key, this.postId}); // postId を追加
  final int? postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostFormPageState();
}

class _PostFormPageState extends ConsumerState<PostFormPage> {
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final _imagePicker = ImagePicker();
  String? _initialImageUrl;

  @override
  void dispose() { // 追加
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> handleSubmit(
    BuildContext context,
    PostForm formData,
  ) async {
    final postService = PostsService();
    try {
      if (widget.postId == null) {
        await postService.createPost(formData);
      } else {
        await postService.updatePost(widget.postId!, formData); // updatePost を追加
      }

      ref.invalidate(postListProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.postId == null ? '投稿が完了しました' : '保存が完了しました',
          ),
        ),
      );
      context.pop();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.postId == null ? '投稿に失敗しました' : '保存に失敗しました',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.postId != null) {
      ref.watch(postDetailProvider(widget.postId!)).whenData((post) {
        if (_contentController.text.isEmpty) {
          _contentController.text = post.content;
          _initialImageUrl = post.photo;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postId == null ? 'ポストの作成' : 'ポストの編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 3,
                  controller: _contentController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '最近何があった？',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '内容を入力してください';
                    }
                    if (value.length > 500) {
                      return '内容は500文字以内にしてください';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: _pickImage,
                    label: Text(
                      _initialImageUrl == null ? '画像を追加' : '画像を変更',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImage!,
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      )
                    : _initialImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _initialImageUrl!,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 45,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final formData = PostForm(
                content: _contentController.text,
                photo: _selectedImage,
              );
              handleSubmit(
                context,
                formData,
              );
            }
          },
          label: Text(
            widget.postId == null ? '投稿' : '保存',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}