import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/core/constants/app_assets.dart';
import 'package:yuanrung/core/constants/app_colors.dart';
import 'package:yuanrung/core/constants/app_strings.dart';
import 'package:yuanrung/core/integrations/service_locator.dart';
import 'package:yuanrung/features/auth/application/cubits/auth_cubit.dart';
import 'package:yuanrung/features/auth/application/cubits/auth_state.dart';
import 'package:yuanrung/features/home/application/home_page.dart';

class AuthPage extends StatelessWidget {
  static const String className = 'AuthPage';
  static const String routeName = '/auth';

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: ServiceLocator.instance<AuthCubit>(),
    child: const _AuthPageView(),
  );
}

class _AuthPageView extends StatefulWidget {
  const _AuthPageView();

  @override
  State<_AuthPageView> createState() => _AuthPageViewState();
}

class _AuthPageViewState extends State<_AuthPageView> {
  late final TextEditingController _userIdController;
  late final AuthCubit _authCubit;

  late TextTheme _textTheme;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    _userIdController = TextEditingController();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(AppAssets.logoTextImage),

              // Title
              Text(AppStrings.authTitle, style: _textTheme.headlineSmall),

              // User ID TextField
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.authUserIdTextFieldLabel,
                    style: _textTheme.titleLarge,
                  ),
                  TextField(
                    controller: _userIdController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: AppStrings.authUserIdTextFieldHint,
                      hintStyle: _textTheme.bodyLarge?.copyWith(
                        color: AppColors.lightGray,
                      ),
                      errorText: _errorText,
                      errorStyle: _textTheme.labelLarge?.copyWith(
                        color: AppColors.error,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.gray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.error),
                      ),
                    ),
                  ),
                ],
              ),

              // Login Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _errorText = null;
                      });

                      if (_userIdController.text.isEmpty) {
                        setState(() {
                          _errorText = AppStrings.authErrorEmptyUserId;
                        });
                        return;
                      }

                      if (_userIdController.text.length < 6) {
                        setState(() {
                          _errorText = AppStrings.authErrorShortUserId;
                        });
                        return;
                      }

                      final regex = RegExp(r'^[a-zA-Z0-9]+$');
                      if (!regex.hasMatch(_userIdController.text)) {
                        setState(() {
                          _errorText = AppStrings.authErrorInvalidUserId;
                        });
                        return;
                      }

                      _authCubit.signIn(_userIdController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: const Size(double.maxFinite, 40),
                      backgroundColor: AppColors.primary,
                      shape: StadiumBorder(),
                    ),
                    child:
                        state.isLoading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                            : Text(
                              AppStrings.authButtonLogin,
                              style: _textTheme.bodyLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
