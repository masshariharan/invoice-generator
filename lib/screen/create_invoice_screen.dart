import 'package:flutter/material.dart';
import 'package:invoice_generator/controller.dart/invoice_controller.dart';
import 'package:invoice_generator/utils/colors.dart';
import 'package:invoice_generator/widgets/input_field_widget.dart';
import 'package:invoice_generator/widgets/items_table_widget.dart';
import 'package:invoice_generator/widgets/text_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, controller, child) {
      return PopScope(
        onPopInvoked: (didPop) {
          controller.clearAll();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.blue,
                title:
                    Text(controller.isEdit ? "Edit Invoice" : "Create Invoice"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.saveInvoice(context);
                        },
                        child: Text(controller.isEdit ? "update" : "Save")),
                  )
                ],
              ),
              body: Form(
                key: controller.formKeyInvoice,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    children: [
                      CompanyInfoInput(
                        nameController: controller.companyNameController,
                        emailController: controller.companyEmailController,
                        phoneController: controller.companyPhoneController,
                        addressController: controller.companyAddressController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClientInfoInput(
                        nameController: controller.clientNameController,
                        emailController: controller.clientEmailController,
                        phoneController: controller.clientPhoneController,
                        addressController: controller.clientAddressController,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const HeadingText(text: "Add List of Items"),
                        trailing: InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  onPressedSave: () {
                                    controller.itemsAdd(context);
                                    FocusScope.of(context).unfocus();
                                  },
                                  nameController: controller.itemNameController,
                                  costController: controller.itemCostController,
                                  quantityController:
                                      controller.itemQuantityController,
                                );
                              },
                            );
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.blue),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.whiteGrey,
                              )),
                        ),
                      ),
                      controller.items.isNotEmpty
                          ? Table(
                              border: TableBorder.all(),
                              children: [
                                headerRowTable(),
                                ...controller.items
                                    .map((itemx) => customRowTable(
                                        item: itemx,
                                        onPressed: () {
                                          controller.removeItem(itemx);
                                        }))
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 35,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.nameController,
      required this.costController,
      required this.quantityController,
      required this.onPressedSave});

  final TextEditingController nameController;
  final TextEditingController costController;
  final TextEditingController quantityController;
  final void Function()? onPressedSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new Items"),
      content: ListView(
        shrinkWrap: true,
        children: [
          Text("Item Name"),
          ReusableInputField(
              controller: nameController, inputType: TextInputType.name),
          Text("Item Cost"),
          ReusableInputField(
              controller: costController, inputType: TextInputType.number),
          Text("Quantity"),
          ReusableInputField(
              controller: quantityController, inputType: TextInputType.number),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: Text("cancel")),
        TextButton(onPressed: onPressedSave, child: Text("Save")),
      ],
    );
  }
}
