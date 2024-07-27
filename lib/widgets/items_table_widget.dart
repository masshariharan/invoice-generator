import 'package:flutter/material.dart';

import '../models/item_model.dart';

TableRow headerRowTable() {
  return const TableRow(
    children: <Widget>[
      ReusableHeaderTableCell(text: "Item Name"),
      ReusableHeaderTableCell(text: "Item quality"),
      ReusableHeaderTableCell(text: "Item cost"),
      ReusableHeaderTableCell(text: "Action"),
    ],
  );
}

TableRow customRowTable({required Item item, required void Function()? onPressed}) {
  return TableRow(
    children: <Widget>[
      ReusableTableCell(
        text: item.name,
      ),
      ReusableTableCell(
        text: "${item.quantity}",
      ),
      ReusableTableCell(
        text: "${item.price}",
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashRadius: 18,
                padding: const EdgeInsets.all(0),
                onPressed: onPressed,
                icon: const Icon(
                  Icons.delete,
                  // color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class ReusableHeaderTableCell extends StatelessWidget {
  const ReusableHeaderTableCell({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text),
      ),
    );
  }
}

class ReusableTableCell extends StatelessWidget {
  const ReusableTableCell({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(text)),
    );
  }
}
