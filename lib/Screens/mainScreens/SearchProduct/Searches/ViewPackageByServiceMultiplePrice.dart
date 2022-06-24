import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/property_card.dart';

class ViewPackageByServiceMultiplePrice extends StatelessWidget {
  String maxPrice, minPrice;
  int length = 0;
  ViewPackageByServiceMultiplePrice(
      {required this.minPrice, required this.maxPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price Range: \$ $minPrice - \$" + maxPrice),
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
                    "Related Packages",
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
                    .where('price', isLessThanOrEqualTo: double.parse(maxPrice))
                    .where('price',
                        isGreaterThanOrEqualTo: double.parse(minPrice))
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
