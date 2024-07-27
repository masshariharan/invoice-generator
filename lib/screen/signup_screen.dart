import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/auth_controller.dart';
import 'package:invoice_generator/screen/signin_screen.dart';
import 'package:invoice_generator/utils/colors.dart';
import 'package:invoice_generator/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/auth_input_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, controller, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Form(
            key: controller.formKeySignup,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const HeadingText(text: "Create Account"),
                    const SizedBox(
                      height: 50,
                    ),
                    const SubHeadingText(text: "Your Name"),
                    const SizedBox(
                      height: 15,
                    ),
                    ReUsableTextFormField(
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.greyColor,
                      ),
                      controller: controller.signupNameController,
                      labelText: "Enter Your name",
                      validatorText: "Please enter your name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SubHeadingText(text: "Email"),
                    const SizedBox(
                      height: 15,
                    ),
                    ReUsableTextFormField(
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.greyColor,
                      ),
                      controller: controller.signupEmailController,
                      labelText: "Enter Your Email",
                      validatorText: "Please enter your email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SubHeadingText(text: "Password"),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginPasswordField(
                      visibility: () => controller.passwordVisibilty(),
                      obsecureText: controller.passwordObsecured,
                      controller: controller.signupPasswordController,
                      labelText: "Enter Your Password",
                      validatorText: "Please enter your password",
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: ReUsableElevatedButton(
                          child: controller.loaderSignup
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : const ButtonText(text: "Signup"),
                          onPressed: () => controller.signup(context),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () =>
                              controller.navigateToSigninScreen(context),
                          child: const Text(
                            "Signin",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.blue,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
