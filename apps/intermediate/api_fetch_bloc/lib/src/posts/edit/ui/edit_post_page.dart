import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/edit/bloc/post_edit_bloc.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key, required this.item});
  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        PostRepository repo = context.read<PostRepository>();
        return PostEditBloc(repo);
      },
      child: AdaptiveDialog(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: PostEditionView<PostEditBloc>(
            incomingItem: item,
            onResolved: (item) async {
              Navigator.pop(context, item);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            onSubmit: (context, result) {
              context.read<PostEditBloc>().add(
                    PostEditRequested(
                      PostModificationPayload.from(
                        result.original!
                            .copyWith(title: result.title, body: result.body),
                      ),
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
