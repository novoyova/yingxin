import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/core/constants/app_colors.dart';
import 'package:yuanrung/core/constants/app_strings.dart';
import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/core/utils/app_snackbar.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_player_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_recorder_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/audio_recorder_state.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_cubit.dart';
import 'package:yuanrung/features/nursing/application/cubits/nursing_assessment_state.dart';
import 'package:yuanrung/features/nursing/domain/nursing_assessment_failure.dart';

class NursingAssessmentBottomSheet extends StatefulWidget {
  static const String className = 'NursingAssessmentBottomSheet';

  static void show(BuildContext context) {
    final nursingAssessmentCubit = context.read<NursingAssessmentCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: ServiceLocator.instance<AudioRecorderCubit>(),
            ),
            BlocProvider.value(
              value: ServiceLocator.instance<AudioPlayerCubit>(),
            ),
            BlocProvider.value(value: nursingAssessmentCubit),
          ],
          child: const NursingAssessmentBottomSheet(),
        );
      },
    );
  }

  const NursingAssessmentBottomSheet({super.key});

  @override
  State<NursingAssessmentBottomSheet> createState() =>
      _NursingAssessmentBottomSheetState();
}

class _NursingAssessmentBottomSheetState
    extends State<NursingAssessmentBottomSheet> {
  late final TextEditingController _originalNoteController;
  late final TextEditingController _correctedNoteController;
  late final TextEditingController _formattedNoteController;

  late final NursingAssessmentCubit _nursingAssessmentCubit;
  late final bool _isUpdate;

  late TextTheme _textTheme;

  @override
  void initState() {
    super.initState();
    _originalNoteController = TextEditingController();
    _correctedNoteController = TextEditingController();
    _formattedNoteController = TextEditingController();
    _nursingAssessmentCubit = context.read<NursingAssessmentCubit>();
    _isUpdate = _nursingAssessmentCubit.state.currentNursingAssessment != null;
    if (_isUpdate) {
      _originalNoteController.text =
          _nursingAssessmentCubit.state.currentNursingAssessment!.originalNote;
      _correctedNoteController.text =
          _nursingAssessmentCubit.state.currentNursingAssessment!.correctedNote;
      _formattedNoteController.text =
          _nursingAssessmentCubit.state.currentNursingAssessment!.formattedNote;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NursingAssessmentCubit, NursingAssessmentState>(
          listener: (context, state) {
            if (state.isSuccess) {
              return Navigator.pop(context);
            }

            if (state.failure != null) {
              return switch (state.failure!.type) {
                NursingAssessmentFailureType.transcribeAudioFailed =>
                  AppSnackbar.error(
                    context,
                    message:
                        AppStrings
                            .nursingAssessmentBottomSheetErrorTranscribeFailed,
                  ),
                NursingAssessmentFailureType.userNotFound => AppSnackbar.error(
                  context,
                  message:
                      AppStrings.nursingAssessmentBottomSheetErrorUserNotFound,
                ),
                NursingAssessmentFailureType.createFailed => AppSnackbar.error(
                  context,
                  message: AppStrings.nursingAssessmentBottomSheetCreateFailed,
                ),
                NursingAssessmentFailureType.updateFailed => AppSnackbar.error(
                  context,
                  message: AppStrings.nursingAssessmentBottomSheetUpdateFailed,
                ),
                _ => null,
              };
            }

            if (state.currentNursingAssessment != null) {
              setState(() {
                _originalNoteController.text =
                    state.currentNursingAssessment!.originalNote;
                _correctedNoteController.text =
                    state.currentNursingAssessment!.correctedNote;
                _formattedNoteController.text =
                    state.currentNursingAssessment!.formattedNote;
              });
            }
          },
        ),
        BlocListener<AudioRecorderCubit, AudioRecorderState>(
          listener: (context, state) {
            if (state.path != null) {
              // Play audio
              context.read<AudioPlayerCubit>().play(state.path!);
              // Transcribe audio
              context.read<NursingAssessmentCubit>().transcribeAudio(
                state.path!,
              );
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                AppStrings.nursingAssessmentBottomTitle,
                style: _textTheme.headlineMedium,
              ),

              // Recognition Result
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.nursingAssessmentBottomNoteTextFieldLabel,
                    style: _textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: _originalNoteController,
                    readOnly: true,
                    enabled: false,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              // Corrected Recognition Result
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.nursingAssessmentBottomCorrectedTextFieldLabel,
                    style: _textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: _correctedNoteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.gray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Formatted Recognition Result
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.nursingAssessmentBottomFormattedTextFieldLabel,
                    style: _textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: _formattedNoteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.gray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom Buttons
              Column(
                children: [
                  // Speech Button
                  BlocBuilder<AudioRecorderCubit, AudioRecorderState>(
                    builder: (context, audioRecorderState) {
                      return BlocBuilder<
                        NursingAssessmentCubit,
                        NursingAssessmentState
                      >(
                        builder: (context, nursingAssessmentState) {
                          if (nursingAssessmentState.currentNursingAssessment !=
                              null) {
                            return SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed:
                                  nursingAssessmentState.isLoading
                                      ? () {}
                                      : () {
                                        if (audioRecorderState.isRecording) {
                                          context
                                              .read<AudioRecorderCubit>()
                                              .stopRecording();
                                        } else {
                                          context
                                              .read<AudioRecorderCubit>()
                                              .startRecording();
                                        }
                                      },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                fixedSize: const Size(100, 100),
                                overlayColor: Colors.transparent,
                                backgroundColor:
                                    audioRecorderState.isRecording
                                        ? Colors.transparent
                                        : AppColors.accent,
                                side:
                                    audioRecorderState.isRecording
                                        ? BorderSide(color: AppColors.accent)
                                        : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  nursingAssessmentState.isLoading
                                      ? Container(
                                        width: 24,
                                        height: 24,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )
                                      : Icon(
                                        audioRecorderState.isRecording
                                            ? Icons.stop_rounded
                                            : Icons.mic_rounded,
                                        size: 48,
                                        color:
                                            audioRecorderState.isRecording
                                                ? AppColors.accent
                                                : AppColors.white,
                                      ),
                                  Text(
                                    nursingAssessmentState.isLoading
                                        ? AppStrings
                                            .nursingAssessmentBottomButtonSpeechTranscribe
                                        : audioRecorderState.isRecording
                                        ? AppStrings
                                            .nursingAssessmentBottomButtonSpeechStop
                                        : AppStrings
                                            .nursingAssessmentBottomButtonSpeechStart,
                                    style: _textTheme.bodyLarge?.copyWith(
                                      color:
                                          audioRecorderState.isRecording
                                              ? AppColors.accent
                                              : AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Save Button
                  BlocBuilder<NursingAssessmentCubit, NursingAssessmentState>(
                    builder: (context, state) {
                      if (state.currentNursingAssessment == null) {
                        return SizedBox.shrink();
                      }

                      return ElevatedButton(
                        onPressed: () async {
                          // Hide soft keyboard
                          FocusManager.instance.primaryFocus?.unfocus();

                          final nursingAssessment =
                              state.currentNursingAssessment!;

                          // Save Nursing Assessment
                          context
                              .read<NursingAssessmentCubit>()
                              .saveNursingAssessment(
                                nursingAssessment: nursingAssessment.copyWith(
                                  correctedNote: _correctedNoteController.text,
                                  formattedNote: _formattedNoteController.text,
                                ),
                                isUpdate: _isUpdate,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(double.maxFinite, 40),
                          backgroundColor: AppColors.accent,
                          shape: StadiumBorder(),
                        ),
                        child:
                            state.isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                                : Text(
                                  AppStrings.nursingAssessmentBottomButtonSave,
                                  style: _textTheme.bodyLarge?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      );
                    },
                  ),

                  // Close Button
                  BlocBuilder<AudioRecorderCubit, AudioRecorderState>(
                    builder: (context, audioRecorderState) {
                      return BlocBuilder<
                        NursingAssessmentCubit,
                        NursingAssessmentState
                      >(
                        builder: (context, nursingAssessmentState) {
                          return OutlinedButton(
                            onPressed:
                                audioRecorderState.isRecording ||
                                        nursingAssessmentState.isLoading
                                    ? null
                                    : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(double.maxFinite, 40),
                              shape: const StadiumBorder(),
                              side: BorderSide(
                                width: 1,
                                color: AppColors.primary,
                              ),
                            ),
                            child: Text(
                              AppStrings.nursingAssessmentBottomButtonCancel,
                              style: _textTheme.bodyLarge?.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _originalNoteController.dispose();
    _correctedNoteController.dispose();
    _formattedNoteController.dispose();
    super.dispose();
  }
}
