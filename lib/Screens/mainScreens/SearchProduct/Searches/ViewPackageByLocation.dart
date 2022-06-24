import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/property_card.dart';

class ViewPackageByLocation extends StatelessWidget {
  String PackageName;
  int length = 0;
  ViewPackageByLocation({required this.PackageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Searched - " + PackageName),
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
                    "Packages Found",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "View with Map",
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('AllPackages')
                    .where('location', isGreaterThanOrEqualTo: PackageName)
                    .where('location',
                        isLessThanOrEqualTo: "$PackageName\uf7ff")
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
                      length = snapshot.data!.docs.length;
                      print('Length of Search Packages : ' + length.toString());
                      return productCard2(temp);
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
