import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Models/DatabaseOperations.dart';

import '../Models/Cart/customer.dart';
import '../Models/Cart/invoice.dart';
import '../Models/Cart/supplier.dart';
import '../Models/DatabaseCollections.dart';
import '../Models/sharedPreference/sharedPreference.dart';
import '../Screens/mainScreens/Cart/Api/pdf_api.dart';
import '../Screens/mainScreens/Cart/Api/pdf_invoice_api.dart';
import '../Widgets/progressDialog.dart';

class CartCard extends StatelessWidget {
  final String docsID;
  final Map CartData;
  CartCard(this.docsID, this.CartData);
  DatabaseOperations dboperations = new DatabaseOperations();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/fyplogocolored.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        CartData['Package'],
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                      'Total: \$ ${CartData['Total']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Buyer: ${CartData['buyeruid']}",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF343434),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(
                      FlutterIcons.event_available_mdi,
                      size: 15.0,
                      color: Color.fromRGBO(255, 136, 0, 1),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      CartData['status'].toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF343434),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //remove from card
                        dboperations.removeFromCart(docsID);
                      },
                      child: Text('Remove'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DatabaseOperations dboperation =
                            new DatabaseOperations();
                        print(
                            '--Fetching Cart Data from assigning from temp: ');
                        if (CartData.isNotEmpty) {
                          await dboperation.getBuyerData(CartData['buyeruid']);
                          await dboperation
                              .getSellerData(CartData['selleruid']);
                          String buyerFullName =
                              dboperation.buyerData['firstname'] +
                                  " " +
                                  dboperation.buyerData['lastname'];
                          String sellerFullName =
                              dboperation.sellerData['firstname'] +
                                  " " +
                                  dboperation.sellerData['lastname'];
                          print(sellerFullName);
                          print(dboperation.buyerData['address']);
                          //
//
//
//
//
//
//
                          final date = DateTime.now();
                          final dueDate = date.add(Duration(days: 10));
                          final String invoiceNumber =
                              '1${DateTime.now().microsecond}830${DateTime.now().second}';
                          final invoice = Invoice(
                            supplier: Supplier(
                                name: sellerFullName,
                                address: dboperation.sellerData['address'],
                                paymentaddress:
                                    dboperation.sellerData['paymentaddress']),
                            customer: Customer(
                                name: buyerFullName,
                                address: dboperation.buyerData['address']),
                            info: InvoiceInfo(
                                date: date,
                                dueDate: dueDate,
                                description:
                                    'The package ${CartData['Package']} is booked by $buyerFullName. This invoice will be shown to $sellerFullName with the payment status as verified once you pay through ETH by metamask from our website(https://arhamirfan.github.io/Hall-Bookify-Payment-Web3/).',
                                number: invoiceNumber),
                            items: [
                              InvoiceItem(
                                packageName: CartData['Package'],
                                date: date,
                                location: CartData['Location'],
                                quantity: 1,
                                vat: 0.020,
                                unitPrice: double.parse(CartData['Total']),
                              ),
                            ],
                          );

                          final pdfFile = await PdfInvoiceApi.generate(invoice);

                          PdfApi.openFile(pdfFile);

                          showLoaderDialog(context);
                          //DB receipt : invoice number, buyer/seller uid,name, address, walletaddress, package, price, total, creater fee, sub total, status: pending/paid
                          DatabaseService db = new DatabaseService(
                              uid: dboperation.sellerData['userid']);
                          db.generateReceipt(
                              invoiceNumber,
                              dboperation.buyerData,
                              dboperation.sellerData,
                              CartData);

                          // get by package name and update all_package data to booked
                          //dboperation.getAndUpdatePackageData(CartData['Package']);

                          //sharedpreference for receipt to show status order booked.. remove in orderstatus file when receipt status is paid.
                          sharedPreferenceForReceipt spr =
                              new sharedPreferenceForReceipt();
                          await spr
                              .setValueForReceipt(int.parse(invoiceNumber));
//
//
//
//
//
//
//
//

                          dboperations.removeFromCart(docsID);
                          Navigator.pop(context);
                        } else {
                          print(
                              "Cart Data is empty. Cart empty or didn't fetched data");
                        }
                      },
                      child: Text('Generate Invoice'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
