part of 'deletion_confirmation.dart';

class DeletionConfirmationDialog extends StatelessWidget {
  const DeletionConfirmationDialog({super.key, required this.item});
  final PostItem item;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme typo = Theme.of(context).textTheme;

    return BlocListener<DeleteBloc, ApiRequestState>(
      listener: (context, state) {
        switch (state) {
          case ApiRequestStateResolved():
            Navigator.pop(context, item);
            break;
          case ApiRequestStateRejected():
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: colors.errorContainer,
                content: Text(
                  "An Error Occured",
                  style:
                      typo.bodySmall!.copyWith(color: colors.onErrorContainer),
                ),
              ),
            );
            break;
          default:
            break;
        }
      },
      child: AlertDialog.adaptive(
        title: const Text("Confirm deletion?"),
        icon: const Icon(Icons.dangerous),
        iconColor: Theme.of(context).colorScheme.error,
        content:
            Text("Are you really sure you want to delete post #${item.id}"),
        actions: [
          BlocBuilder<DeleteBloc, ApiRequestState>(builder: (context, state) {
            return FilledButton.tonal(
                onPressed: state is ApiRequestStateWaiting
                    ? null
                    : () async {
                        context.read<DeleteBloc>().add(DeleteItemEvent(item));
                      },
                child: const Text("Yes"));
          }),
          BlocBuilder<DeleteBloc, ApiRequestState>(builder: (context, state) {
            return FilledButton(
                onPressed: state is ApiRequestStateWaiting
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                child: const Text("No"));
          })
        ],
      ),
    );
  }
}
