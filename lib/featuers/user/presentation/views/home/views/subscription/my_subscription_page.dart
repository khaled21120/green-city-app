import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/core/widgets/error_widget.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../cubits/user_report/user_reports_cubit.dart';

class MySubscriptionPage extends StatelessWidget {
  const MySubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).my_subscription),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<UserReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReportsError) {
            return ErrorsWidget(
              message: state.message,
              onPressed:
                  () => context.read<UserReportsCubit>().fetchSubscribStatus(),
            );
          } else if (state is FetchSubSuccess) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Subscription Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.primary, colors.primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user_rounded,
                              color: colors.onPrimary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              S.of(context).my_subscription,
                              style: MyStyle.title16(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildInfoTile(
                          context: context,
                          icon: Icons.card_membership,
                          label: S.of(context).subscriptionType,
                          value:
                              state.subscribe.subscriptionType ??
                              S.of(context).subscriptionType,
                          color: colors.onPrimary,
                        ),
                        // _buildInfoTile(
                        //   context: context,
                        //   icon: Icons.calendar_month,
                        //   label: S.of(context).subscriptionDuration,
                        //   value:
                        //       state.subscribe.subscriptionDuration ??
                        //       S.of(context).subscriptionDuration,
                        //   color: colors.onPrimary,
                        // ),
                        _buildInfoTile(
                          context: context,
                          icon: Icons.calendar_today,
                          label: S.of(context).remainingDays,
                          value:
                              '${state.subscribe.remainingDays ?? '0'} ${S.of(context).days}',
                          color: colors.onPrimary,
                        ),
                        _buildInfoTile(
                          context: context,
                          icon: Icons.payments,
                          label: S.of(context).price,
                          value: '${state.subscribe.price ?? '0'} EGP',
                          color: colors.onPrimary,
                        ),

                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: _calculateProgress(
                            state.subscribe.remainingDays ?? 0,
                          ),
                          backgroundColor: colors.onPrimary.withValues(
                            alpha: .2,
                          ),
                          color: colors.onPrimary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Benefits Section
                  _buildBenefitsSection(context),
                  const Spacer(),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: colors.errorContainer,
                        foregroundColor: colors.onErrorContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _showUnsubscribeDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cancel_outlined),
                          const SizedBox(width: 8),
                          Text(S.of(context).unsubscribe),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              S.of(context).no_data_available,
              style: MyStyle.title25(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: color),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    final List<String> benefits = [
      S.of(context).unlimited_reports,
      S.of(context).priority_support,
      S.of(context).exclusive_content,
      S.of(context).ad_free_experience,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).your_benefits,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...benefits.map(
          (benefit) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(benefit)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _calculateProgress(int remainingDays) {
    const totalDays = 30;
    return remainingDays / totalDays;
  }

  void _showUnsubscribeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(S.of(context).confirm_unsubscribe),
            content: Text(S.of(context).unsubscribe_confirmation_message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).cancel),
              ),
              ElevatedButton(
                onPressed:
                    () => context
                        .read<UserReportsCubit>()
                        .cancelSubscription()
                        .then((val) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          Helper.showSnackBar(
                            // ignore: use_build_context_synchronously
                            context: context,
                            message: 'Unsubscribed successfully',
                          );
                        }),
                child: Text(S.of(context).unsubscribe),
              ),
            ],
          ),
    );
  }
}
