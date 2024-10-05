import 'package:api_fetch_bloc/src/posts/create/bloc/new_post_bloc.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostForm extends StatefulWidget {
  const NewPostForm({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });
  final AsyncValueSetter<PostItem> onSubmit;
  final VoidCallback onCancel;

  @override
  State<NewPostForm> createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    PostCreationPayload payload = const PostCreationPayload.flexible();
    return BlocListener<CreateNewPostBloc, CreateNewPostState>(
      listener: (context, state) {
        if (state is CreateNewPostStateResolved) {
          widget.onSubmit(state.item);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      onSaved: (newValue) {
                        debugPrint("title: $newValue");
                        payload = payload.copyWith(title: newValue);
                      },
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Row(
                          children: [
                            Text("Title"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 5000,
                      maxLines: null,
                      onSaved: (newValue) {
                        debugPrint("body: $newValue");
                        payload = payload.copyWith(body: newValue);
                      },
                      decoration: const InputDecoration(
                        label: Text("Content here... "),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 12,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            widget.onCancel();
                          },
                          child: const Text("Cancel"),
                        ),
                        FilledButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState?.save();
                            debugPrint(payload.toString());
                            context
                                .read<CreateNewPostBloc>()
                                .add(CreateNewPostSubmitted(payload));
                          },
                          child: BlocBuilder<CreateNewPostBloc,
                              CreateNewPostState>(builder: (context, state) {
                            if (state is CreateNewPostStateWaiting) {
                              return const SizedBox.square(
                                dimension: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return const Text("Save");
                          }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateNewPostBloc, CreateNewPostState>(
                builder: (context, state) {
                  ThemeData theme = Theme.of(context);
                  if (state is CreateNewPostStateRejected) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.errorContainer,
                      child: Text(
                        state.error.toString(),
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onErrorContainer),
                      ),
                    );
                  }
                  if (state is CreateNewPostStateResolved) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.primaryContainer,
                      child: Text(
                        state.item.toString(),
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onPrimaryContainer),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
