import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/posts.dart';
import '../providers/post_list.dart'; // 追加
import '../services/posts.dart';
import 'action_sheet.dart';
import '../routes.dart'; 

class PostTile extends ConsumerStatefulWidget {
  const PostTile({super.key, required this.post});
  final Post post;

  @override
  ConsumerState<PostTile> createState() => _PostTileState();
}

class _PostTileState extends ConsumerState<PostTile> {

  void handleOnDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('本当に投稿を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await PostsService().deletePost(widget.post.id);
                  if (!context.mounted) return;
                  ref.invalidate(postListProvider);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('投稿を削除しました。'),
                    ),
                  );
                } on DioException {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('投稿の削除に失敗しました'),
                    ),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('投稿の削除に失敗しました'),
                    ),
                  );
                }
              },
              child: const Text('はい'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('いいえ'),
            ),
          ],
        );
      },
    );
  }

  void onMoreVertPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) => ActionSheet(
        actions: [
          ActionItem(
            icon: Icons.edit_note_outlined,
            text: '投稿を編集する',
            onTap: () => context.push('${Routes.postCreate}/${widget.post.id}'),
          ),
          ActionItem(
            icon: Icons.delete,
            text: '投稿を削除する',
            onTap: () {
              handleOnDelete(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.4,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.post.user.icon != null
                          ? NetworkImage(widget.post.user.icon!)
                          : const AssetImage(
                              'assets/images/default-user-icon.png',
                            ) as ImageProvider,
                      radius: 10,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.post.user.username,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                // child: Text(
                //   post.createdAt,
                //   style: TextStyle(
                //     color: Theme.of(context).colorScheme.onSurfaceVariant,
                //   ),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.post.formattedDateTime, // ★ ここを formattedDateTime に変更！
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    widget.post.createdByMe
                        ? GestureDetector(
                            onTap: () {
                              onMoreVertPressed(
                                  context);
                            },
                            child: const Icon(
                              Icons.more_vert,
                              size: 20.0,
                            ),
                          )
                        : const SizedBox(
                            width: 20.0,
                          ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.post.content,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          if (widget.post.photo != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.post.photo!,
                  width: MediaQuery.of(context).size.width - 40,
                  height: (MediaQuery.of(context).size.width - 40) / 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 2,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.favorite),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text('0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}