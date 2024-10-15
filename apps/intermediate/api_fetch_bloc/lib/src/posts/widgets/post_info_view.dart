import 'package:api_fetch_bloc/api/bloc/bloc.dart';
import 'package:api_fetch_bloc/src/posts/models/models.dart';
import 'package:api_fetch_bloc/src/users/bloc/user_bloc.dart';
import 'package:api_fetch_bloc/src/users/data/data.dart';
import 'package:api_fetch_bloc/src/users/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostInfoView extends StatelessWidget {
  const PostInfoView({super.key, required this.item});
  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        UserRepository repo = context.read<UserRepository>();
        return UserBloc(repo);
      },
      child: _PostInfoPage(item),
    );
  }
}

class _PostInfoPage extends StatelessWidget {
  final PostItem item;

  const _PostInfoPage(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, ApiRequestState>(builder: (context, state) {
      switch (state) {
        case ApiRequestStateInitial():
          context.read<UserBloc>().add(UserRequestByIdEvent(item.userId));
        case ApiRequestStateWaiting():
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ApiRequestStateResolved<User>():
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ElementWrap("Title", item.title),
                      _ElementWrap("Body", item.body),
                      const SizedBox(height: 32.0),
                      _ElementWrap("Username", state.item.name),
                      _ElementWrap("Company", state.item.company.name),
                      _ElementWrap("Website", state.item.website.toString())
                    ],
                  ),
                ),
              )
            ],
          );
        case ApiRequestStateRejected():
        default:
          return const Center(
            child: Icon(
              Icons.dangerous,
              size: 80,
              color: Colors.red,
            ),
          );
      }
      return const SizedBox();
    });
  }
}

class _ElementWrap extends StatelessWidget {
  const _ElementWrap(
    this.label,
    this.content, {
    super.key,
  });

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle heading =
        textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600);
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Wrap(
        runSpacing: 8.0,
        spacing: 8.0,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          Text(
            label,
            style: heading,
          ),
          Text(content)
        ],
      ),
    );
  }
}
