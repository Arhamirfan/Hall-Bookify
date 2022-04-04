import 'package:hall_bookify/Models/Cart/supplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String packageName;
  final DateTime date;
  final String location;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.packageName,
    required this.date,
    required this.location,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
