import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/auth_controller.dart';
import 'package:invoice_generator/screen/signup_screen.dart';
import 'package:invoice_generator/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/auth_input_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  void initState() {
    final controller = Provider.of<AuthController>(context, listen: false);
    controller.siginStatus(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, controller, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Form(
            key: controller.formKeySignin,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const HeadingText(text: "Signin here"),
                    const SizedBox(
                      height: 70,
                    ),
                    const SubHeadingText(text: "Email"),
                    const SizedBox(
                      height: 15,
                    ),
                    ReUsableTextFormField(
                      prefixIcon: const Icon(Icons.email_sharp,
                          color: AppColors.greyColor),
                      controller: controller.signinEmailController,
                      labelText: "Enter Your Email",
                      validatorText: "Please enter your email",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SubHeadingText(text: "Password"),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginPasswordField(
                      visibility: () {
                        setState(() {
                          controller.passwordObsecured =
                              !controller.passwordObsecured;
                        });
                      },
                      obsecureText: controller.passwordObsecured,
                      controller: controller.signinPasswordController,
                      labelText: "Enter Your Password",
                      validatorText: "Please enter your password",
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: ReUsableElevatedButton(
                          child: controller.loaderSignin
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : const ButtonText(text: "Signin"),
                          onPressed: () => controller.signin(context),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () =>
                              controller.navigateToSignupScreen(context),
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.blue,
                                color: AppColors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
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
