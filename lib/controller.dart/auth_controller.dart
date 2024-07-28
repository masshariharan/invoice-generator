import 'package:flutter/material.dart';
import 'package:invoice_generator/routes/routes.dart';
import 'package:invoice_generator/services/auth_service.dart';
import 'package:invoice_generator/utils/helper_method.dart';
import 'package:invoice_generator/utils/util.dart';
import 'package:logger/logger.dart';


class AuthController extends ChangeNotifier {
  AuthService authService = AuthService();

  TextEditingController signinEmailController = TextEditingController();
  TextEditingController signinPasswordController = TextEditingController();

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();

  bool passwordObsecured = true;

  final formKeySignin = GlobalKey<FormState>();
  final formKeySignup = GlobalKey<FormState>();

  bool loaderSignin = false;
  bool loaderSignup = false;

  void clearSigninController() {
    signinEmailController.clear();
    signinPasswordController.clear();
    passwordObsecured = true;
    notifyListeners();
  }

  void clearSignupController() {
    signupNameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    passwordObsecured = true;
    notifyListeners();
  }

  void passwordVisibilty() {
    passwordObsecured = !passwordObsecured;
    notifyListeners();
  }

  void siginStatus(context) async {
    try {
      var signinInfo = await HelperMethod.getsigninInfo();

      if (signinInfo.userid.isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          Routes.home,
        );
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void signin(context) async {
    try {
      if (formKeySignin.currentState!.validate()) {
        loaderSignin = true;
        notifyListeners();

        await authService
            .signinWithEmail(
                context: context,
                email: signinEmailController.text.trim(),
                password: signinPasswordController.text.trim())
            .then((value) {
          if (value == "success") {
            Logger().w(value);

            Navigator.pushReplacementNamed(
              context,
              Routes.home,
            );

            loaderSignin = false;
            clearSigninController();
            notifyListeners();
          } else {
            loaderSignin = false;
            notifyListeners();
          }
        });

        notifyListeners();
      }
    } catch (e) {
      loaderSignin = false;
      notifyListeners();
      Logger().e(e);
    }
  }

  void signup(context) async {
    try {
      if (formKeySignup.currentState!.validate()) {
        loaderSignup = true;
        notifyListeners();
        await authService
            .registerWithEmail(
                context: context,
                userName: signupNameController.text.trim(),
                email: signupEmailController.text.trim(),
                password: signupPasswordController.text.trim())
            .then((value) {
          if (value == "success") {
            Logger().w(value);
            showSnackBar(context: context, text: "Registration Successful");
            Navigator.pushReplacementNamed(
              context,
              Routes.signin,
            );

            loaderSignup = false;
            clearSignupController();
            notifyListeners();
          } else {
            loaderSignup = false;
            notifyListeners();
          }
        });
        notifyListeners();
      }
    } catch (e) {
      loaderSignup = false;
      notifyListeners();
      Logger().w(e);
    }
  }

  void navigateToSignupScreen(context) {
    Navigator.pushReplacementNamed(
      context,
      Routes.signup,
    );
  }

  void navigateToSigninScreen(context) {
    Navigator.pushReplacementNamed(
      context,
      Routes.signin,
    );
  }
}
