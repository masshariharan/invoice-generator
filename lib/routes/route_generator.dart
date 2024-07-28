import 'package:flutter/material.dart';
import 'package:invoice_generator/models/invoice_model.dart';
import 'package:invoice_generator/routes/routes.dart';
import 'package:invoice_generator/screen/create_invoice_screen.dart';
import 'package:invoice_generator/screen/email_input_screen.dart';
import 'package:invoice_generator/screen/error_screen.dart';
import 'package:invoice_generator/screen/home_screen.dart';
import 'package:invoice_generator/screen/invoice_preview_screen.dart';
import 'package:invoice_generator/screen/signin_screen.dart';
import 'package:invoice_generator/screen/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.signin:
        return MaterialPageRoute(builder: (context) => const SigninScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.createInvoie:
        return MaterialPageRoute(
            builder: (context) => const CreateInvoiceScreen());
      case Routes.invoicePreview:
        return MaterialPageRoute(builder: (context) {
          final args = route.arguments as Invoice;
          return InvoicePreviewScreen(
            invoice: args,
          );
        });
      case Routes.email:
        return MaterialPageRoute(builder: (context) {
          final args = route.arguments as Invoice;
          return EmailInputScreen(
            invoice: args,
          );
        });

      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}
