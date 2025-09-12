import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yingxin/core/constants/app_colors.dart';
import 'package:yingxin/core/constants/app_strings.dart';
import 'package:yingxin/core/integrations/service_locator.dart';
import 'package:yingxin/features/nursing/application/cubits/nursing_assessment_cubit.dart';
import 'package:yingxin/features/nursing/application/cubits/nursing_assessment_state.dart';
import 'package:yingxin/features/nursing/application/nursing_assessment_bottom_sheet.dart';
import 'package:yingxin/features/nursing/application/nursing_assessment_tile.dart';

class NursingAssessmentTab extends StatelessWidget {
  static const String className = 'NursingAssessmentTab';

  const NursingAssessmentTab({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: ServiceLocator.instance<NursingAssessmentCubit>(),
    child: const _NursingAssessmentTabView(),
  );
}

class _NursingAssessmentTabView extends StatelessWidget {
  const _NursingAssessmentTabView();

  Widget _emptyPatientProgressNote(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.content_paste_off_rounded,
              size: 128,
              color: AppColors.lightGray,
            ),
            Text(
              AppStrings.nursingAssessmentTabEmpty,
              style: textTheme.headlineLarge?.copyWith(
                color: AppColors.lightGray,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nurseAssessmentCubit = context.read<NursingAssessmentCubit>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              spacing: 0,
              children: [
                Text(
                  AppStrings.nursingAssessmentTabTitle,
                  style: textTheme.headlineLarge,
                ),
                BlocBuilder<NursingAssessmentCubit, NursingAssessmentState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed:
                          () => nurseAssessmentCubit.getNursingAssessments(),
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon:
                          state.isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.darkGray,
                                  strokeWidth: 3,
                                ),
                              )
                              : Icon(Icons.refresh_rounded, size: 32),
                    );
                  },
                ),
              ],
            ),

            Divider(color: AppColors.gray),

            // History Records
            BlocBuilder<NursingAssessmentCubit, NursingAssessmentState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Expanded(
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.lightGray,
                      ),
                    ),
                  );
                }

                if (state.nursingAssessments.isEmpty) {
                  return _emptyPatientProgressNote(context);
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: state.nursingAssessments.length,
                    itemBuilder: (context, index) {
                      if (index == state.nursingAssessments.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: NursingAssessmentTile(
                            nursingAssessment: state.nursingAssessments[index],
                          ),
                        );
                      }
                      return NursingAssessmentTile(
                        nursingAssessment: state.nursingAssessments[index],
                      );
                    },
                    separatorBuilder:
                        (context, index) => Divider(color: AppColors.lightGray),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nurseAssessmentCubit.emitState(
            nurseAssessmentCubit.state.copyWith(currentNursingAssessment: null),
          );
          NursingAssessmentBottomSheet.show(context);
        },
        elevation: 2,
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add_rounded, color: AppColors.white),
      ),
    );
  }
}
