import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'text_widget.dart';

class ReusableInputField extends StatelessWidget {
  const ReusableInputField(
      {super.key,
      required this.controller,
      this.inputType,
      this.validatorText});
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? validatorText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
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
        filled: true,
        fillColor: AppColors.whiteBlue,
      ),
    );
  }
}

class AddressInputField extends StatelessWidget {
  const AddressInputField(
      {super.key, required this.controller, this.validatorText});
  final TextEditingController? controller;
  final String? validatorText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 3,
      maxLines: 10,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
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
        filled: true,
        fillColor: AppColors.whiteBlue,
      ),
    );
  }
}

class CompanyInfoInput extends StatelessWidget {
  const CompanyInfoInput(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.addressController});

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const HeadingText(text: "Add Company Details"),
      const SubHeadingText(text: "Company Name"),
      ReusableInputField(
        controller: nameController,
        inputType: TextInputType.name,
        validatorText: "Name is required",
      ),
      const SubHeadingText(text: "Email Address"),
      ReusableInputField(
        controller: emailController,
        inputType: TextInputType.emailAddress,
        validatorText: "Email is required",
      ),
      const SubHeadingText(text: "Phone Number"),
      ReusableInputField(
        controller: phoneController,
        inputType: TextInputType.phone,
        validatorText: "Phone number is required",
      ),
      const SubHeadingText(text: "Address"),
      AddressInputField(
        controller: addressController,
        validatorText: "Address is required",
      ),
    ]);
  }
}

class ClientInfoInput extends StatelessWidget {
  const ClientInfoInput(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.addressController});
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HeadingText(text: "Add Client Details"),
      SubHeadingText(text: "Client Name"),
      ReusableInputField(
        controller: nameController,
        inputType: TextInputType.name,
        validatorText: "Name is required",
      ),
      SubHeadingText(text: "Email Address"),
      ReusableInputField(
        controller: emailController,
        inputType: TextInputType.emailAddress,
        validatorText: "Email is required",
      ),
      SubHeadingText(text: "Phone Number"),
      ReusableInputField(
        controller: phoneController,
        inputType: TextInputType.phone,
        validatorText: "Phone numberis required",
      ),
      SubHeadingText(text: "Address"),
      AddressInputField(
        controller: addressController,
        validatorText: "Address is required",
      ),
    ]);
  }
}
