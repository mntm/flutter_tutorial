import 'package:api_fetch_bloc/src/posts/create/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/new_post_form.dart';

class NewFormPage extends StatelessWidget {
  const NewFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    var newPostForm = Padding(
      padding: const EdgeInsets.only(top: 24),
      child: NewPostForm(onSubmit: (item) async {
        Navigator.pop(context, item);
      }, onCancel: () {
        Navigator.pop(context);
      }),
    );

    return BlocProvider(
      create: (_) {
        PostRepository repo = context.read<PostRepository>();
        return CreateNewPostBloc(repo);
      },
      child: width > 400
          ? Dialog(
              child: newPostForm,
            )
          : Dialog.fullscreen(
              child: newPostForm,
            ),
    );
  }
}
