import 'package:api_fetch_bloc/src/posts/create/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/new_post_form.dart';

class NewFormPage extends StatelessWidget {
  final Widget child;
  const NewFormPage({super.key, required this.child});

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
          child: NewPostForm(
            onSubmit: (item) async {
              Navigator.pop(context, item);
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
