import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/invoice_model.dart';

class PdfInvoiceGenerator {
  Future<Uint8List> pdfGenerator(Invoice invoice) async {
    final headers = ['Item', 'Quantity', 'Price per item', 'Total'];
    final invoicesData = [...invoice.items.map((e) => e.toList())];

    final pdf = Document();

    pdf.addPage(Page(build: (Context context) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice.from!.name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 1 * PdfPageFormat.mm),
                    Text(invoice.from!.address!),
                    Text(invoice.from!.phone!),
                    Text(invoice.from!.email!),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text("Invoice Number"),
                        SizedBox(width: 20),
                        Text(invoice.id),
                      ]),
                      SizedBox(width: 5),
                      Row(children: [
                        Text("Invoice Date"),
                        SizedBox(width: 20),
                        Text(invoice.date),
                      ]),
                    ])
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BILL TO", style: TextStyle(fontSize: 10)),
                    Text(invoice.to!.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(invoice.to!.address!),
                    Text(invoice.to!.phone!),
                    Text(invoice.to!.email!),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 3 * PdfPageFormat.cm),
        Text(
          'Invoice details',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        TableHelper.fromTextArray(
          headers: headers,
          data: invoicesData,
          border: null,
          headerStyle: TextStyle(fontWeight: FontWeight.bold),
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.centerLeft,
            1: Alignment.centerRight,
            2: Alignment.centerRight,
            3: Alignment.centerRight,
            4: Alignment.centerRight,
            
          },
        ),
        Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      title: 'Total amount due',
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      value: "\$${invoice.total}",
                      unite: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]);
    }));

    Uint8List bytes = await pdf.save();
    return bytes;
  }
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unite ? style : null),
      ],
    ),
  );
}
