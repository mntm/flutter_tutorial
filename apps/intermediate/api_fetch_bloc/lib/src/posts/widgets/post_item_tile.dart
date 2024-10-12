import 'package:api_fetch_bloc/src/posts/delete/ui/ui.dart';
import 'package:api_fetch_bloc/src/posts/edit/ui/ui.dart';
import 'package:api_fetch_bloc/src/posts/list/bloc/post_bloc.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostItemTile extends StatelessWidget {
  const PostItemTile({
    super.key,
    required this.item,
  });

  final PostItem item;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[2],
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        isThreeLine: false,
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: IconButton(
                  onPressed: () async {
                    final result = await showAdaptiveDialog<PostItem>(
                        context: context,
                        builder: (context) {
                          return EditPostPage(
                            item: item,
                          );
                        });
                    if (result != null && context.mounted) {
                      context.read<PostBloc>().add(PostInserted(result));
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 16,
                  )),
            ),
            Flexible(
              child: IconButton(
                  onPressed: () async {
                    final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return DeletionConfirmation(item: item);
                        });
                    if (result != null && context.mounted) {
                      context.read<PostBloc>().add(PostRemoved(result));
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 16,
                  )),
            ),
          ],
        ),
        leading: Text("${item.id}"),
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge,
        ),
        subtitle: Text(
          item.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
