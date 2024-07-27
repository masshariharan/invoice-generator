import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/invoice_controller.dart';
import 'package:invoice_generator/models/invoice_model.dart';
import 'package:invoice_generator/screen/invoice_preview_screen.dart';
import 'package:invoice_generator/utils/colors.dart';
import 'package:provider/provider.dart';
import 'email_input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final controller = Provider.of<InvoiceController>(context, listen: false);

      controller.getInvoiceItem();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                controller.navigateToInvoiceCreateScreen(context);
              },
              child: const Icon(
                Icons.note_add_outlined,
                color: AppColors.blue,
                size: 35,
              ),
            ),
            appBar: AppBar(
              elevation: 0.9,
              backgroundColor: AppColors.blue,
              title: const Text("Invoice Maker"),
              actions: [
                TextButton(
                    onPressed: () => controller.signout(context),
                    child: const Row(
                      children: [
                        Text("Signout"),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(Icons.logout)
                      ],
                    ))
              ],
            ),
            body: controller.invoiceAddedItems.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.invoiceAddedItems.length,
                    itemBuilder: (context, index) {
                      Invoice invoice = controller.invoiceAddedItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 15, right: 0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InvoicePreviewScreen(
                                          invoice: invoice,
                                        )),
                              );
                            },
                            title: Text(invoice.to.name),
                            subtitle: Text("Invoice Id: ${invoice.id}"),
                            trailing: PopupMenuButton<int>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    controller.navigateEditInvoice(
                                        context: context, invoice: invoice);
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Edit")
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    controller.deleteInvoice(invoice, context);
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Delete")
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmailInputScreen(
                                                  invoice: invoice,
                                                )));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.email),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("share")
                                    ],
                                  ),
                                ),
                              ],
                              color: AppColors.liteBlue,
                              elevation: 2,
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text("You don't have any invoices"),
                  )),
      );
    });
  }
}
