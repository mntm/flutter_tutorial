import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:flutter/material.dart';

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
        leading: Text("${item.id}"),
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge,
        ),
        subtitle: Text(
          item.body,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
