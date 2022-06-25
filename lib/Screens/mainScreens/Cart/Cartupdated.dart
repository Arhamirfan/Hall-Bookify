import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/CartCard.dart';

import '../../../Widgets/progressDialog.dart';

class CartUpdated extends StatefulWidget {
  @override
  State<CartUpdated> createState() => _CartUpdatedState();
}

class _CartUpdatedState extends State<CartUpdated> {
  int length = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String buyer_uid = "", seller_uid = "";

  fetchinfo() async {
    final User user = await _auth.currentUser!;
    setState(() {
      buyer_uid = user.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Packages",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showLoaderDialog(context);
                      var collection =
                          FirebaseFirestore.instance.collection('Cart');
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        await doc.reference.delete();
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Empty Cart",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(238, 21, 64, 1.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Cart')
                    .where('buyeruid', isEqualTo: buyer_uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      var temp = snapshot.data!.docs[index].data() as Map;
                      var id = snapshot.data!.docs[index].id;
                      length = snapshot.data!.docs.length;
                      print('Length of Search Packages : ' + length.toString());
                      print("document id: " + id);
                      return CartCard(id, temp);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
