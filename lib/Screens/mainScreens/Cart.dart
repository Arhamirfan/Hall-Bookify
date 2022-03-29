import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

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
          title: Text('Cart'),
          backgroundColor: Colors.purpleAccent,
          centerTitle: true,
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
                          child: Text(temp['Package']),
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
                    onPressed: () async {},
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
