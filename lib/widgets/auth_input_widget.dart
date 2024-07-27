import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validatorText,
      required this.obsecureText,
      required this.visibility});

  final TextEditingController controller;
  final String labelText;
  final String validatorText;
  final bool obsecureText;
  final void Function()? visibility;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: AppColors.whiteBlue,
        labelText: labelText,
        contentPadding: EdgeInsets.all(3),
        prefixIcon: Icon(Icons.lock, color: AppColors.greyColor),
        suffix: IconButton(
            onPressed: visibility,
            icon: obsecureText
                ? const Icon(Icons.visibility_off, color: AppColors.greyColor)
                : const Icon(Icons.visibility, color: AppColors.greyColor)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.liteGreyColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ReUsableTextFormField extends StatelessWidget {
  const ReUsableTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validatorText,
      required this.prefixIcon});

  final TextEditingController controller;
  final String labelText;
  final String validatorText;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
   
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: AppColors.whiteBlue,
        prefixIcon: prefixIcon,
        labelText: labelText,
        
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.liteGreyColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ReUsableElevatedButton extends StatelessWidget {
  const ReUsableElevatedButton(
      {super.key, required this.child, required this.onPressed});
  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            AppColors.lightBlue,
            AppColors.blue,
          ])),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: child,
          )),
    );
  }
}
