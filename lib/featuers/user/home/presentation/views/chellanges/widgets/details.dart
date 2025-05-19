import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../cubits/Activities Cubit/activities_cubit.dart';
import '../../../../data/models/activities_model.dart';

class ActivitiesDetailsPage extends StatelessWidget {
  const ActivitiesDetailsPage({super.key, required this.activitiesModel});
  final ActivitiesModel activitiesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(activitiesModel.actName!)),
      body: BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {
          if (state is ActivitiesError) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is ActivityJoined) {
            Helper.showSnackBar(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ActivitiesLoading,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoCard(
                    Icons.description,
                    activitiesModel.actDescription!,
                  ),
                  _buildInfoCard(
                    Icons.date_range,
                    activitiesModel.actIntervalDate!,
                  ),
                  _buildInfoCard(Icons.check_circle, activitiesModel.actstate!),
                  _buildInfoCard(
                    Icons.group,
                    "Subscribers: ${activitiesModel.numOfSubscribers}",
                  ),
                  _buildInfoCard(
                    Icons.people_alt,
                    "Required: ${activitiesModel.numOfRequiredSubscribers}",
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    text: S.of(context).join,
                    onTap: () {
                      context.read<ActivitiesCubit>().joinActivity(
                        activityId: activitiesModel.id!,
                        data: activitiesModel.numOfSubscribers! + 1,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
