import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/pdf_generator.dart';

class EmailController extends ChangeNotifier {
  TextEditingController toEmailController = TextEditingController();

  void sendAttachedmail(invoice) async {
    String filePath = await savePdfFile(
        await PdfInvoiceGenerator().pdfGenerator(invoice), "invoice");

    await sendEmailWithAttachment(filePath);
    toEmailController.clear();
  }

  Future<String> savePdfFile(Uint8List fileBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(fileBytes);
    return filePath;
  }

  Future<void> sendEmailWithAttachment(String filePath) async {
    final Email email = Email(
      body: 'Invoice Document',
      subject: 'Invoice',
      recipients: [(toEmailController.text.trim())],
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
