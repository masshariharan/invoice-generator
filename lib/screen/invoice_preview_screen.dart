import 'package:flutter/material.dart';
import 'package:invoice_generator/models/invoice_model.dart';
import 'package:invoice_generator/utils/colors.dart';
import 'package:invoice_generator/utils/pdf_generator.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InvoicePreviewScreen extends StatefulWidget {
  const InvoicePreviewScreen({super.key, required this.invoice});

  final Invoice invoice;

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: PdfInvoiceGenerator().pdfGenerator(widget.invoice),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var documentBytes = snapshot.data;
              Logger().w(documentBytes!.length);
              return SfPdfViewer.memory(
                documentBytes,
                initialZoomLevel: 0.5,
              );
            }
            return const CircularProgressIndicator(
              color: AppColors.white,
            );
          }),
    );
  }
}
