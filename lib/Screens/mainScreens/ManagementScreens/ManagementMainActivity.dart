import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Models/FireBaseData/ProfileDatabase.dart';

class ManagementMainActivity extends StatefulWidget {
  @override
  _ManagementMainActivityState createState() => _ManagementMainActivityState();
}

class _ManagementMainActivityState extends State<ManagementMainActivity> {
  String uid = "",
      firstname = "",
      lastname = "",
      phoneno = "",
      address = "",
      city = "",
      cnic = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  fetchUserInfo() async {
    final User user = await _auth.currentUser!;
    uid = user.uid;
    dynamic userData = await DatabaseManager().getCurrentUserData(uid);
    setState(() {
      firstname = userData[0];
      lastname = userData[1];
      phoneno = userData[2];
      address = userData[3];
      city = userData[4];
    });
  }

  final List options = [
    {
      "name": "Talk to Support Now",
      "icon": Icons.support_agent_outlined,
      "key": "phone",
      "description": "Provide your phone number and we will call you"
    },
    {
      "name": "Update Package",
      "icon": Icons.autorenew,
      "key": "Update Package",
      "description": "Start a chat session with us",
    },
    {
      "name": "Delete Package",
      "icon": Icons.delete_rounded,
      "key": "Delete Package",
      "description": "Find an authorized service provider",
    },
  ];

  String active = "";

  void setActiveFunc(String key) {
    setState(() {
      active = key;
    });
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "How would you like to get help?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: options.map((e) {
                    int index = options.indexOf(e);
                    return serviceCard(options[index], active, setActiveFunc);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget serviceCard(Map item, String active, Function setActive) {
  bool isActive = active == item["key"];
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setActive(item["key"]);
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: 15.0),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isActive ? Colors.purpleAccent : Colors.black12,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(item["icon"]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: isActive
                        ? Colors.white
                        : Color.fromRGBO(20, 20, 20, 0.96),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  item["description"],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: isActive
                        ? Colors.white
                        : Color.fromRGBO(20, 20, 20, 0.96),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
