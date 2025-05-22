import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<String> validateLogin({
    required String username,
    required String password,
  }) {
    final errors = <String>[];

    final usernameError = validateUsername(username);
    if (usernameError.isNotEmpty) errors.add(usernameError);

    final passwordError = validateRegisterPassword(password);
    if (passwordError.isNotEmpty) errors.add(passwordError);

    return errors;
  }

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful')),
            );
            // Navigate to the next screen
            Navigator.of(context).pushReplacementNamed(Routes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Invalid credentials")),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is AuthLoading;

          return Stack(
            children: [
              SvgPicture.asset(
                'assets/images/Login.svg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    color: Colors.white.withAlpha(230),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            usernameController,
                            'Username',
                          ),
                          const SizedBox(height: 12),
                          buildTextField(
                            passwordController,
                            'Password',
                            TextInputType.visiblePassword,
                            true,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    final errors = validateLogin(
                                      username: usernameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );

                                    if (errors.isNotEmpty) {
                                      // Show errors in a dialog or SnackBar
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title:
                                              const Text("Validation Errors"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: errors
                                                .map((e) => Text("• $e"))
                                                .toList(),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      );
                                      return; // stop execution if there are validation errors
                                    }

                                    // If no errors, proceed to login
                                    context.read<AuthCubit>().login(
                                          usernameController.text.trim(),
                                          passwordController.text.trim(),
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.primaryColor,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
