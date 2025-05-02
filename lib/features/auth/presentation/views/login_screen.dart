import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:interview_test/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:interview_test/features/auth/presentation/views/base_view.dart';
import 'package:interview_test/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:interview_test/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (context, model, child) => LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildLoginForm(),
          ),
        ],
      ),
    );
  }

  Future<void> onTap() async {
    if (formKey.currentState?.validate() ?? false) {
      final model = Provider.of<AuthViewModel>(context, listen: false);
      await model
          .login(id: usernameController.text, password: passwordController.text)
          .then((_) {
            if (model.userSession != null) {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            } else {
              EasyLoading.showToast(
                model.errorMessage ?? 'Login failed',
                duration: const Duration(seconds: 2),
                toastPosition: EasyLoadingToastPosition.center,
              );
            }
          });
    }
  }

  Widget _buildLoginForm() {
    return Consumer<AuthViewModel>(
      builder: (context, model, child) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                hintText: 'Username (or) Phone number / Email',
              ),
              CustomTextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                hintText: "Password",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    fillColor: WidgetStateProperty.all(
                      Color.fromRGBO(52, 107, 209, 1),
                    ),
                    checkColor: Colors.white,
                    value: model.acceptTermsAndConditions,
                    onChanged: (value) {
                      model.setAcceptTermsAndConditions(value ?? false);
                    },
                  ),
                  Expanded(child: Text('Terms and Conditions')),
                ],
              ),
              SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, model, child) {
                  return CustomButton(
                    onTap: onTap,
                    label: "Login",
                    isEnabled: model.acceptTermsAndConditions,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
