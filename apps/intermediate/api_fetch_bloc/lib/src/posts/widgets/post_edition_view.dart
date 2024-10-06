import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/src/posts/widgets/widgets.dart';
import 'package:api_fetch_bloc/utils/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostEditionView<T extends Bloc<ApiRequestEvent, ApiRequestState>>
    extends StatelessWidget {
  const PostEditionView({
    super.key,
    required this.onResolved,
    required this.onCancel,
    required this.onSubmit,
  });
  final AsyncValueSetter<PostItem> onResolved;
  final VoidCallback onCancel;
  final void Function(BuildContext, String title, String body) onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, ApiRequestState>(
      listener: (context, state) {
        if (state is ApiRequestStateResolved) {
          onResolved(state.item);
        }
      },
      child: Stack(
        children: [
          ListView(
            children: [
              _PostEditionForm(
                onCancel: onCancel,
                onSubmit: onSubmit,
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: BlocBuilder<T, ApiRequestState>(
              builder: (context, state) {
                ThemeData theme = Theme.of(context);
                if (state is ApiRequestStateRejected) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(8),
                    color: theme.colorScheme.errorContainer,
                    child: Text(
                      state.reason.toString(),
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.colorScheme.onErrorContainer),
                    ),
                  );
                }
                if (state is ApiRequestStateResolved) {
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
            ),
          )
        ],
      ),
    );
  }
}

class _PostEditionForm<T extends Bloc<ApiRequestEvent, ApiRequestState>>
    extends StatefulWidget {
  const _PostEditionForm({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  final void Function(BuildContext, String title, String body) onSubmit;
  final VoidCallback onCancel;

  @override
  State<_PostEditionForm> createState() => _PostEditionFormState();
}

class _PostEditionFormState extends State<_PostEditionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final String _title;
  late final String _body;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          children: [
            _TitleTextFormField(
              onSaved: (newValue) {
                _title = newValue!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _BodyTextFormField(
              onSaved: (newValue) {
                _body = newValue ?? "";
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _ButtonRow(
              formKey: _formKey,
              onCancel: widget.onCancel,
              onSubmit: (context) {
                widget.onSubmit(context, _title, _body);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonRow<T extends Bloc<ApiRequestEvent, ApiRequestState>>
    extends StatelessWidget {
  const _ButtonRow({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onSubmit,
    required this.onCancel,
  }) : _formKey = formKey;

  final ValueSetter<BuildContext> onSubmit;
  final VoidCallback onCancel;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 12,
      children: [
        FilledButton.tonal(
          onPressed: () {
            onCancel();
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState?.save();
            onSubmit(context);
          },
          child: BlocBuilder<T, ApiRequestState>(builder: (context, state) {
            if (state is ApiRequestStateWaiting) {
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
    );
  }
}

class _TitleTextFormField extends StatelessWidget {
  const _TitleTextFormField({super.key, required this.onSaved});
  final FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      maxLength: 100,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Required";
        }
        return null;
      },
      decoration: const MarkedInputDecoration(labelText: "Title"),
    );
  }
}

class _BodyTextFormField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _BodyTextFormField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 5000,
      maxLines: null,
      onSaved: onSaved,
      decoration: const InputDecoration(
        label: Text("Content here... "),
      ),
    );
  }
}
