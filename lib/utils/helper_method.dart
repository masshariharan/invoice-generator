import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:invoice_generator/models/user_model.dart';
import 'package:invoice_generator/utils/pdf_generator.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperMethod {
  static const String loginInfo = "loginInfo";

  ///date format
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  ///db
  static Future<bool> saveSigninInfo(UserModel signinResponse) async {
    Logger().d("save login info ${signinResponse.toJson()}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(loginInfo, jsonEncode(signinResponse));
  }

  ///db
  static Future<UserModel> getsigninInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(loginInfo);
    if (data != null) {
      return UserModel.fromJson(json.decode(data));
    } else {
      throw "No Value Found";
    }
  }

  ///db
  static void clearedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(loginInfo);
    await prefs.clear();
  }

  ///email
  static void sendAttachedmail(invoice) async {
    String filePath = await savePdfFile(
        await PdfInvoiceGenerator().pdfGenerator(invoice), "invoice");

    await sendEmailWithAttachment(filePath);
  }

  static Future<String> savePdfFile(Uint8List fileBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.pdf';

    final file = File(filePath);
    await file.writeAsBytes(fileBytes);
    return filePath;
  }

  static Future<void> sendEmailWithAttachment(String filePath) async {
    final Email email = Email(
      body: 'Invoice Document',
      subject: 'Invoice',
      attachmentPaths: [filePath],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      Logger().e('Failed to send email: $error');
    }
  }
}
