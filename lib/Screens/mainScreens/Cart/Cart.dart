import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/mainScreens/Cart/Api/pdf_api.dart';

import '../../../Constants.dart';
import '../../../Models/Cart/customer.dart';
import '../../../Models/Cart/invoice.dart';
import '../../../Models/Cart/supplier.dart';
import '../../../Models/sharedPreference/sharedPreference.dart';
import '../../../Widgets/progressDialog.dart';
import 'Api/pdf_invoice_api.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int cart_size = 0;
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
                      return Center(child: CircularProgressIndicator());
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
                                      ListTile(
                                        leading: Icon(Icons.apartment,
                                            color: Colors.purpleAccent),
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
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('Cart');
                                            var snapshots =
                                                await collection.get();
                                            for (var doc in snapshots.docs) {
                                              await doc.reference.delete();
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
//
//
//
//
//
//
//
                      //TODO: generate a unique random invoice number
                      final date = DateTime.now();
                      final dueDate = date.add(Duration(days: 10));
                      //TODO: get name of loggedin user data from db (query: where id = loggedin id) and in setstate set it and display here
                      final invoice = Invoice(
                        supplier: Supplier(
                            name: 'arham',
                            address: 'sahiwal',
                            paymentaddress: '03206522050'),
                        customer:
                            Customer(name: 'yousaf', address: 'faisalabad'),
                        info: InvoiceInfo(
                            date: date,
                            dueDate: dueDate,
                            description: 'My description..',
                            number: '${DateTime.now().year}-9999'),
                        items: [
                          //Todo: change it to cart package name, description, price, creator fee, services names
                          InvoiceItem(
                            description: 'hall bookify',
                            date: date,
                            quantity: 1,
                            vat: 0.19,
                            unitPrice: 99,
                          ),
                        ],
                      );
                      //TODO: save invoice all details to DB Firestore.

                      final pdfFile = await PdfInvoiceApi.generate(invoice);

                      PdfApi.openFile(pdfFile);
//
//
//
//
//
//
//
//
//
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
