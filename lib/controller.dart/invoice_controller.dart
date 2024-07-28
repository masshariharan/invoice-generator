import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invoice_generator/models/client_model.dart';
import 'package:invoice_generator/models/company_model.dart';
import 'package:invoice_generator/models/invoice_model.dart';
import 'package:invoice_generator/routes/routes.dart';
import 'package:invoice_generator/services/invoice_service.dart';
import 'package:invoice_generator/utils/helper_method.dart';
import 'package:invoice_generator/utils/util.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../models/item_model.dart';


class InvoiceController extends ChangeNotifier {
  ///company input controller
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();

  ///Client input controller
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();

  ///Items input controller
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCostController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  final formKeyInvoice = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    notifyListeners();
  }

  List<Item> items = [];

  List<Invoice> invoiceAddedItems = [];

  double addedItemsTotal = 0;

  bool isEdit = false;
  String invoiceDate = '';
  String invoiceId = '';

  var uuid = const Uuid();

  Invoice? invoiceItem;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  InvoiceService invoiceService = InvoiceService();

  void clearAll() {
    isEdit = false;
    invoiceId = '';
    companyNameController.clear();
    companyEmailController.clear();
    companyAddressController.clear();
    companyPhoneController.clear();
    clientNameController.clear();
    clientEmailController.clear();
    clientPhoneController.clear();
    clientAddressController.clear();
    itemNameController.clear();
    itemCostController.clear();
    itemQuantityController.clear();
    items.clear();
    notifyListeners();
  }

  void itemsAdd(context) {
    try {
      items.add(Item(
          name: itemNameController.text.trim(),
          quantity: int.parse(itemQuantityController.text.trim()),
          price: double.parse(itemCostController.text.trim())));

      Future.delayed(Duration.zero, () {
        scrollDown();
      });
      Navigator.pop(context);
      itemNameController.clear();
      itemCostController.clear();
      itemQuantityController.clear();

      notifyListeners();
    } catch (e) {
      showSnackBar(context: context, text: "Something went wrong");
    }
  }

  void removeItem(Item item) {
    items.remove(item);
    notifyListeners();
  }

  void signout(context) async {
    await auth.signOut();
    HelperMethod.clearedPref();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.signin,
      (route) => false,
    );
    notifyListeners();
  }

  void deleteInvoice(Invoice invoice, BuildContext context) async {
    try {
      await invoiceService.deleteInvoice(invoiceDocId: invoice.invoiceDocId!);
      await getInvoiceItem();
      notifyListeners();
      if (context.mounted) {
        showSnackBar(context: context, text: "Invoice deleted");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void shareInvoiceToEmail(context, invoice) {
    HelperMethod.sendAttachedmail(invoice);
  }

  void navigateToInvoicePreviewScreen(context, invoice) {
    Navigator.pushNamed(context, Routes.invoicePreview, arguments: invoice);
  }

  void navigateEditInvoice(
      {required BuildContext context, required Invoice invoice}) {
    var uniqueId = uuid.v4();
    Logger().w(invoice.toJson());
    Logger().w(uniqueId);
    items.clear();
    isEdit = true;
    companyNameController.text = invoice.from.name;
    companyEmailController.text = invoice.from.email;
    companyAddressController.text = invoice.from.address;
    companyPhoneController.text = invoice.from.phone;
    clientNameController.text = invoice.to.name;
    clientEmailController.text = invoice.to.email;
    clientPhoneController.text = invoice.to.phone;
    clientAddressController.text = invoice.to.address;
    invoiceDate = invoice.date;
    invoiceId = invoice.id;

    invoiceItem = invoice;

    items.addAll(invoice.items);
    Navigator.pushNamed(context, Routes.createInvoie);
    notifyListeners();
  }

  Future<void> getInvoiceItem() async {
    invoiceAddedItems = await invoiceService.getInvoice();
    notifyListeners();
  }

  void saveInvoice(context) async {
    try {
      if (formKeyInvoice.currentState!.validate()) {
        if (isEdit) {
          var invoiceData = Invoice(
              id: invoiceId,
              date: invoiceDate,
              from: Company(
                      name: companyNameController.text,
                      email: companyEmailController.text,
                      phone: companyPhoneController.text,
                      address: companyAddressController.text)
                  .toJson(),
              to: Client(
                      name: clientNameController.text,
                      address: clientAddressController.text,
                      phone: clientPhoneController.text,
                      email: clientEmailController.text)
                  .toJson(),
              items: items,
              total: items.fold(
                  0,
                  (previousValue, next) =>
                      previousValue + (next.price * next.quantity)),
              invoiceDocId: invoiceItem!.invoiceDocId);

          await invoiceService.saveInvoice(
              invoiceData: invoiceData,
              invoiceDocId: invoiceItem!.invoiceDocId!);
          showSnackBar(context: context, text: "Successfully Edited");
          Navigator.pop(context);
          clearAll();
          getInvoiceItem();
          notifyListeners();
        } else {
          var invoiceDocId = uuid.v4();

          invoiceId = DateTime.now().millisecondsSinceEpoch.toString();
          invoiceDate = HelperMethod.formatDate(DateTime.now());

          var invoiceData = Invoice(
              id: invoiceId,
              date: invoiceDate,
              from: Company(
                      name: companyNameController.text,
                      email: companyEmailController.text,
                      phone: companyPhoneController.text,
                      address: companyAddressController.text)
                  .toJson(),
              to: Client(
                      name: clientNameController.text,
                      address: clientAddressController.text,
                      phone: clientPhoneController.text,
                      email: clientEmailController.text)
                  .toJson(),
              items: items,
              total: items.fold(
                  0,
                  (previousValue, next) =>
                      previousValue + (next.price * next.quantity)),
              invoiceDocId: invoiceDocId);

          await invoiceService.saveInvoice(
              invoiceData: invoiceData, invoiceDocId: invoiceDocId);
          showSnackBar(context: context, text: "Successfully created");
          Navigator.pop(context);
          clearAll();
          getInvoiceItem();
          notifyListeners();
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  navigateToInvoiceCreateScreen(context) {
    items.clear();
    Navigator.pushNamed(
      context,
      Routes.createInvoie,
    );
  }
}
