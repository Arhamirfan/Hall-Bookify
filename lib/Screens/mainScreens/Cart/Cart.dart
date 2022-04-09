import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Models/DatabaseCollections.dart';
import 'package:hall_bookify/Models/DatabaseOperations.dart';

import '../../../Constants.dart';
import '../../../Models/Cart/customer.dart';
import '../../../Models/Cart/invoice.dart';
import '../../../Models/Cart/supplier.dart';
import '../../../Models/sharedPreference/sharedPreference.dart';
import '../../../Widgets/progressDialog.dart';
import 'Api/pdf_api.dart';
import 'Api/pdf_invoice_api.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int cart_size = 0;
  late Map CartData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
          title: Text('Cart Details'),
          backgroundColor: Colors.purpleAccent,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('Cart').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                            child: Text('No Data found in DB cart.',
                                style: kmediumblackboldText)),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        cart_size = snapshot.data!.docs.length;
                        print("cart size : " + cart_size.toString());
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        final temp = snapshot.data!.docs[index].data() as Map;
                        if (temp.length > 0) {
                          CartData = temp;
                        }
                        print(temp['buyer uid']);
                        print(temp['Package']);
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cart Details",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "$cart_size Packages Found",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color.fromRGBO(255, 136, 0, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Wrap(
                                    children: [
                                      Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                "assets/images/cloudy.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: ListTile(
                                            title: Text(temp['Package'],
                                                style: klargeblackboldText),
                                            subtitle:
                                                Text("\$" + temp['Sub Total']),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                              ),
                                              color: Colors.red,
                                              onPressed: () async {
                                                showLoaderDialog(context);
                                                sharedPreferenceForCart
                                                    sharedpreference =
                                                    new sharedPreferenceForCart();
                                                sharedpreference.resetCounter();
                                                var collection =
                                                    FirebaseFirestore.instance
                                                        .collection('Cart');
                                                var snapshots =
                                                    await collection.get();
                                                for (var doc
                                                    in snapshots.docs) {
                                                  await doc.reference.delete();
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      DatabaseOperations dboperation = new DatabaseOperations();
                      print('--Fetching Cart Data from assigning from temp: ');
                      if (CartData.isNotEmpty) {
                        //TODO: Check if same user is buying pakage as providing. Uncomment it before publishing and finalizing..
                        // if(CartData['buyer uid'] == CartData['seller uid']){
                        //   print('Buyer cannot be the seller. Login with different ID');
                        // } else{
                        //   //paste all operations here..
                        // }
                        await dboperation.getBuyerData(CartData['buyer uid']);
                        await dboperation.getSellerData(CartData['seller uid']);
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
                                  'The package ${CartData['Package']} is booked by $buyerFullName. This invoice will be shown to $sellerFullName with the payment status as verified once you pay through ETH by metamask from our website.',
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
                        db.generateReceipt(invoiceNumber, dboperation.buyerData,
                            dboperation.sellerData, CartData);

                        // get by package name and update all_package data to booked
                        dboperation
                            .getAndUpdatePackageData(CartData['Package']);
//
//
//
//
//
//
//
//
//                     deleting package from cart after booking.. add receipt to db and review after it.
                        sharedPreferenceForCart sharedpreference =
                            new sharedPreferenceForCart();
                        sharedpreference.resetCounter();
                        var collection =
                            FirebaseFirestore.instance.collection('Cart');
                        var snapshots = await collection.get();
                        for (var doc in snapshots.docs) {
                          await doc.reference.delete();
                        }
                        Navigator.pop(context);
                      } else {
                        print(
                            "Cart Data is empty. Cart empty or didn't fetched data");
                      }
                    },
                    icon: Icon(Icons.document_scanner_outlined),
                    label: Text('Generate Invoice', style: kmediumwhiteText),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: Colors.purpleAccent),
                  )),
            ],
          ),
        ));
  }
}
