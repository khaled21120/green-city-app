import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/error_widget.dart';
import '../../cubits/profile/profile_cubit.dart';
import 'widgets/user_home_body.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchUserData();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is FetchDataLoading) {
          return _buildLoadingState();
        } else if (state is FetchDataFailure) {
          return ErrorsWidget(
            message: state.errMsg,
            onPressed: () async => context.read<ProfileCubit>().fetchUserData(),
          );
        } else if (state is FetchDataSuccess) {
          return _buildSuccessState(context, state);
        }

        return _buildErrorState();
      },
    );
  }

  Widget _buildLoadingState() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildSuccessState(BuildContext context, FetchDataSuccess state) {
    return UserHomeBody(userData: state.userModel);
  }

  Widget _buildErrorState() {
    return const Scaffold(body: Center(child: Text('Something went wrong')));
  }
}
