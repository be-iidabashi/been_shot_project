import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_form.dart';
import '../providers/post_list.dart';
import '../services/posts.dart';

class PostFormPage extends ConsumerStatefulWidget {
  const PostFormPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostFormPageState();
}

class _PostFormPageState extends ConsumerState<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentKey = GlobalKey<FormFieldState>();
  File? _selectedImage;
  final _imagePicker = ImagePicker();

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
      await postService.createPost(formData);
      ref.invalidate(postListProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '投稿が完了しました',
          ),
        ),
      );
      context.pop();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '投稿に失敗しました',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポストの作成'),
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
                  key: _contentKey,
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
                      '画像を追加',
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
                content: _contentKey.currentState?.value,
                photo: _selectedImage,
              );
              handleSubmit(
                context,
                formData,
              );
            }
          },
          label: Text(
            '投稿',
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