import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yuanrung/core/constants/app_colors.dart';
import 'package:yuanrung/core/constants/app_strings.dart';
import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/core/utils/app_snackbar.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_player_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_player_state.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_tile_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_tile_state.dart';
import 'package:yuanrung/features/nursing/application/nursing_assessment_bottom_sheet.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment_failure.dart';

class NursingAssessmentTile extends StatelessWidget {
  static const String className = 'NursingAssessmentTile';

  final NursingAssessment nursingAssessment;

  const NursingAssessmentTile({super.key, required this.nursingAssessment});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ServiceLocator.instance<NursingAssessmentTileCubit>(),
        ),
        BlocProvider.value(value: ServiceLocator.instance<AudioPlayerCubit>()),
        BlocProvider.value(value: context.read<NursingAssessmentCubit>()),
      ],
      child: _NursingAssessmentTileView(nursingAssessment: nursingAssessment),
    );
  }
}

class _NursingAssessmentTileView extends StatelessWidget {
  final NursingAssessment nursingAssessment;

  const _NursingAssessmentTileView({required this.nursingAssessment});

  String _formatDate(DateTime dateTime) {
    final localDateTime = dateTime.toLocal();
    final now = DateTime.now().toLocal();
    final difference = now.difference(localDateTime).inDays;

    final isToday =
        now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day;

    final isYesterday =
        now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day - 1;

    if (isToday) {
      return AppStrings.nursingAssessmentTileToday;
    }

    if (isYesterday) {
      return AppStrings.nursingAssessmentTileYesterday;
    }

    if (difference < 7) {
      return DateFormat('EEEE', 'zh_TW').format(localDateTime);
    }

    return DateFormat('yyyy/MM/dd', 'zh_TW').format(localDateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm a').format(dateTime.toLocal());
  }

  void _showDeleteAlertDialog(
    BuildContext context, {
    required NursingAssessment nursingAssessment,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final nursingAssessmentCubit = context.read<NursingAssessmentCubit>();

    showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text(AppStrings.nursingAssessmentTileDeleteDialogTitle),
          content: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '【${nursingAssessment.note}】',
                style: textTheme.bodySmall?.copyWith(color: AppColors.error),
              ),
              Text(
                AppStrings.nursingAssessmentTileDeleteDialogContent,
                style: textTheme.bodyLarge,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppStrings.nursingAssessmentTileDeleteDialogButtonCancel,
                style: textTheme.bodyLarge?.copyWith(color: AppColors.darkGray),
              ),
            ),
            TextButton(
              onPressed: () {
                nursingAssessmentCubit.deleteNursingAssessment(
                  nursingAssessment: nursingAssessment,
                );
                Navigator.pop(context);
              },
              child: Text(
                AppStrings.nursingAssessmentTileDeleteDialogButtonDelete,
                style: textTheme.bodyLarge?.copyWith(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nursingAssessmentCubit = context.read<NursingAssessmentCubit>();

    return BlocListener<NursingAssessmentTileCubit, NursingAssessmentTileState>(
      listener: (context, state) {
        if (state.audioPath != null) {
          context.read<AudioPlayerCubit>().play(state.audioPath!);
          return;
        }

        if (state.failure != null) {
          return switch (state.failure!.type) {
            NursingAssessmentFailureType.downloadAudioFailed =>
              AppSnackbar.error(
                context,
                message:
                    AppStrings
                        .nursingAssessmentTileDeleteDialogErrorDownloadFailed,
              ),
            _ => null,
          };
        }
      },
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        leading: SizedBox(
          width: 78,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Date
              Text(
                _formatDate(nursingAssessment.date),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Time
              Text(
                _formatTime(nursingAssessment.date),
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Note
            Expanded(
              child: Text(nursingAssessment.note, style: textTheme.bodyLarge),
            ),

            // Audio Button
            BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
              builder: (context, audioPlayerState) {
                return BlocBuilder<
                  NursingAssessmentTileCubit,
                  NursingAssessmentTileState
                >(
                  builder: (context, tileState) {
                    return IconButton(
                      onPressed:
                          audioPlayerState.isPlaying || tileState.isLoading
                              ? () {}
                              : () => context
                                  .read<NursingAssessmentTileCubit>()
                                  .downloadAudio(
                                    nursingAssessment: nursingAssessment,
                                  ),
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon:
                          !tileState.isLoading
                              ? Icon(
                                Icons.volume_up_rounded,
                                color:
                                    audioPlayerState.isPlaying
                                        ? AppColors.accent
                                        : AppColors.darkGray,
                              )
                              : SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: AppColors.accent,
                                  strokeWidth: 2,
                                ),
                              ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  nursingAssessmentCubit.emitState(
                    nursingAssessmentCubit.state.copyWith(
                      currentNursingAssessment: nursingAssessment,
                    ),
                  );
                  NursingAssessmentBottomSheet.show(context);
                },
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
              ),
            ),

            // Delete Button
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  _showDeleteAlertDialog(
                    context,
                    nursingAssessment: nursingAssessment,
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
