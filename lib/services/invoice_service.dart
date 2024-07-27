import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/invoice_model.dart';

class InvoiceService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Invoice>> getInvoice() async {
    List<Invoice> invoiceList = [];
    var invoiceData = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('invoiceItems')
        .get();
    for (var docs in invoiceData.docs) {
      Invoice invoiceItem = Invoice.fromJson(docs.data());

      invoiceList.add(invoiceItem);
    }
    return invoiceList;
  }

  Future<void> saveInvoice(
      {required Invoice invoiceData, required String invoiceDocId}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('invoiceItems')
        .doc(invoiceDocId)
        .set(invoiceData.toJson());
  }

  Future<void> editInvoice(
      {required Invoice invoiceData, required String invoiceDocId}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('invoiceItems')
        .doc(invoiceDocId)
        .update(invoiceData.toJson());
  }

  Future<void> deleteInvoice({required String invoiceDocId}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('invoiceItems')
        .doc(invoiceDocId)
        .delete();
  }
}
