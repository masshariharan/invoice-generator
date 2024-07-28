import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/user_model.dart';
import '../utils/helper_method.dart';
import '../utils/util.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> registerWithEmail(
      {required BuildContext context,
      required String userName,
      required String email,
      required String password}) async {
    String status = '';
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await auth.currentUser!.updateDisplayName(userName);
      await auth.currentUser!.verifyBeforeUpdateEmail(email);
      await saveUserData(
          name: userName, email: email, userid: credential.user!.uid);
      status = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (context.mounted) {
          showSnackBar(
              context: context, text: "The password provided is too weak.");
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          showSnackBar(
              context: context,
              text: "The account already exists for that email.");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, text: e.toString());
      }
    }

    return status;
  }

  Future<String> signinWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    String status = '';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var userData = UserModel(
            name: value.user!.displayName!,
            email: value.user!.email!,
            userid: value.user!.uid);
         
        Logger().w(userData.toJson());
        await HelperMethod.saveSigninInfo(userData);
      });

      status = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        if (context.mounted) {
          showSnackBar(context: context, text: "No user found for that email.");
        }
      } else if (e.code == 'invalid-credential') {
        if (context.mounted) {
          showSnackBar(context: context, text: "Wrong password provided ");
        }
      } else {
        if (context.mounted) {
          showSnackBar(context: context, text: e.code);
        }
      }
    }

    return status;
  }

  saveUserData(
      {required String name,
      required String email,
      required String userid}) async {
    var userData = UserModel(name: name, email: email, userid: userid);
    await firestore.collection('users').doc(userid).set(userData.toJson());
  }
}
