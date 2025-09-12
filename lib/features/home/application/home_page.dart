import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yingxin/core/constants/app_colors.dart';
import 'package:yingxin/core/integrations/service_locator.dart';
import 'package:yingxin/features/auth/application/auth_page.dart';
import 'package:yingxin/features/home/application/cubits/home_cubit.dart';
import 'package:yingxin/features/home/application/cubits/home_state.dart';
import 'package:yingxin/features/home/domain/home_failure.dart';
import 'package:yingxin/features/nursing/application/nursing_assessment_tab.dart';

class HomePage extends StatelessWidget {
  static const String className = 'HomePage';
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: ServiceLocator.instance<HomeCubit>(),
    child: const _HomePageView(),
  );
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          spacing: 10,
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: AppColors.white,
              size: 32,
            ),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                  child: Text(
                    state.userId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.displaySmall?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryTextLight,
                      strokeWidth: 3.5,
                    ),
                  ),
                );
              }
              return IconButton(
                onPressed: () => homeCubit.signOut(),
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.white,
                  size: 32,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.failure != null) {
            switch (state.failure!.type) {
              case HomeFailureType.userNotFound:
                Navigator.pushReplacementNamed(context, AuthPage.routeName);
                break;
            }
          }
        },
        child: NursingAssessmentTab(),
      ),
    );
  }
}
