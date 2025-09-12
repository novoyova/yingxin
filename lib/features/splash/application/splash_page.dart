import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yingxin/core/constants/app_assets.dart';
import 'package:yingxin/core/constants/app_colors.dart';
import 'package:yingxin/core/constants/app_strings.dart';
import 'package:yingxin/core/integrations/service_locator.dart';
import 'package:yingxin/features/auth/application/auth_page.dart';
import 'package:yingxin/features/home/application/home_page.dart';
import 'package:yingxin/features/splash/application/cubits/splash_cubit.dart';
import 'package:yingxin/features/splash/application/cubits/splash_state.dart';

class SplashPage extends StatelessWidget {
  static const String className = 'SplashPage';
  static const String routeName = '/';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: ServiceLocator.instance<SplashCubit>(),
    child: const _SplashPageView(),
  );
}

class _SplashPageView extends StatelessWidget {
  const _SplashPageView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isSuccess) {
            state.isSignedIn
                ? Navigator.pushReplacementNamed(context, HomePage.routeName)
                : Navigator.pushReplacementNamed(context, AuthPage.routeName);
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(AppAssets.logoIconImage, width: 250),

              // Title
              Text(
                AppStrings.splashTitle,
                textAlign: TextAlign.center,
                style: textTheme.displayMedium?.copyWith(
                  color: AppColors.primaryTextLight,
                  fontWeight: FontWeight.normal,
                ),
              ),

              // Loading Indicator
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: CircularProgressIndicator(color: AppColors.accent),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
