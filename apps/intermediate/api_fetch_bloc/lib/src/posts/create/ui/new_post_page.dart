import 'package:api_fetch_bloc/src/posts/create/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/models/post_creation_payload.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewFormPage extends StatelessWidget {
  const NewFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        PostRepository repo = context.read<PostRepository>();
        return CreateNewPostBloc(repo);
      },
      child: AdaptiveDialog(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: PostEditionView<CreateNewPostBloc>(
            onResolved: (item) async {
              Navigator.pop(context, item);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            onSubmit: (context, title, body) {
              context.read<CreateNewPostBloc>().add(CreateNewPostSubmitted(
                  PostCreationPayload.flexible(title: title, body: body)));
            },
          ),
        ),
      ),
    );
  }
}
