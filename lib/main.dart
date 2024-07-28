
import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/auth_controller.dart';
import 'package:invoice_generator/controller.dart/email_controller.dart';
import 'package:invoice_generator/controller.dart/invoice_controller.dart';
import 'package:invoice_generator/routes/route_generator.dart';
import 'package:invoice_generator/routes/routes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InvoiceController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => EmailController())
      ],
      child: MaterialApp(
        title: 'Invoice Generator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: Routes.signin,
        onGenerateRoute: (settings) => RouteGenerator.onGenerateRoute(settings),
      ),
    );
  }
}
