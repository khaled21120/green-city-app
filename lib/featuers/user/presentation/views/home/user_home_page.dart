import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../cubits/profile/profile_cubit.dart';
import 'widgets/user_home_body.dart';

/// User‑facing home screen. Fetches profile data once and reacts to updates.
class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
    // Kick off first‑time load as soon as the widget is inserted in the tree.
    context.read<ProfileCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is FetchDataFailure) {
          Helper.showSnackBar(context: context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        switch (state) {
          case FetchDataLoading() || ProfileStateInitial():
            return const _LoadingScaffold();

          case FetchDataFailure messageState:
            return ErrorsWidget(
              message: messageState.errMsg,
              onPressed: () => context.read<ProfileCubit>().fetchUserData(),
            );

          case FetchDataSuccess loadedState:
            return UserHomeBody(userData: loadedState.userModel);

          case UpdateDataSuccess updateState:
            return UserHomeBody(userData: updateState.userModel);

          default:
            return const _UnknownErrorScaffold();
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper scaffolds
// ─────────────────────────────────────────────────────────────────────────────
class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _UnknownErrorScaffold extends StatelessWidget {
  const _UnknownErrorScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Something went wrong'),
            TextButton(
              onPressed: () => context.read<ProfileCubit>().fetchUserData(),
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
}
