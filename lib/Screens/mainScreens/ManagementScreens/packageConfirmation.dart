import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/ServiceProviderPackageCard.dart';

class PackageConfirmation extends StatelessWidget {
  String logedinID;
  PackageConfirmation({required this.logedinID});
  int length = 0;

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
                  Text(
                    "Delete Requests",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromRGBO(238, 21, 64, 1.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('review')
                    .where('selleruid', isEqualTo: logedinID)
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

                      return packageCard(id, temp);
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
