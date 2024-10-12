import 'package:api_fetch_bloc/src/posts/data/post_repository.dart';
import 'package:api_fetch_bloc/src/posts/delete/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/api/bloc/api_access_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'deletion_confirmation_dialog.dart';

class DeletionConfirmation extends StatelessWidget {
  const DeletionConfirmation({super.key, required this.item});
  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        PostRepository repo = context.read<PostRepository>();
        return DeleteBloc(repo);
      },
      child: DeletionConfirmationDialog(item: item),
    );
  }
}
