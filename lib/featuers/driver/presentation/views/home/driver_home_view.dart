import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/featuers/driver/presentation/views/home/widgets/driver_home_body.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../../../user/presentation/cubits/profile/profile_cubit.dart';

/// User‑facing home screen. Fetches profile data once and reacts to updates.
class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
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
            return DriverHomeBody(userData: loadedState.userModel);

          case UpdateDataSuccess updateState:
            return DriverHomeBody(userData: updateState.userModel);

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
