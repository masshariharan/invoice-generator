import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/email_controller.dart';
import 'package:invoice_generator/models/invoice_model.dart';
import 'package:invoice_generator/widgets/auth_input_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/text_widget.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key, required this.invoice});

  final Invoice invoice;

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmailController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Share invoice to email"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SubHeadingText(text: "Enter receiver email"),
                const SizedBox(
                  height: 8,
                ),
                ReUsableTextFormField(
                    controller: controller.toEmailController,
                    labelText: "Email",
                    validatorText: "Email is required",
                    prefixIcon: Icon(Icons.email_outlined)),
                const SizedBox(
                  height: 20,
                ),
                ReUsableElevatedButton(
                    child: const Text("Send"),
                    onPressed: () {
                      controller.sendAttachedmail(widget.invoice);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
