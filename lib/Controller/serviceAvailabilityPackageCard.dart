import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Models/DatabaseOperations.dart';

class AvailabilitypackageCard extends StatelessWidget {
  final Map package_details;
  final String docsID;
  AvailabilitypackageCard(this.docsID, this.package_details);
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
                        package_details['Package'],
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                      'Total: \$ ${package_details['Total']}',
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
                  "Buyer: ${package_details['buyeruid']}",
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
                      package_details['status'].toString(),
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
                        //dboperations.removeFromReview(docsID);
                        dboperations.stopService(docsID);
                      },
                      child: Text('Stop Service'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        dboperations.resumeService(docsID);
                        // DatabaseService dbs = new DatabaseService(
                        //     uid: package_details['buyeruid']);
                        // dboperations.approveFromReview(docsID);
                        // dbs.ApprovedCartPackage(package_details);
                        // dboperations.removeFromReview(docsID);
                      },
                      child: Text('Resume Service'),
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
