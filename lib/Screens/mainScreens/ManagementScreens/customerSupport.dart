import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';

class CustomerSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Support"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                SizedBox(height: 20),
                Column(
                  children: [
                    ExpansionTile(
                      title: Text('What is hall bookify?',
                          style: kmediumblackboldText),
                      trailing: Icon(Icons.arrow_downward),
                      children: [
                        Wrap(
                          children: [
                            Text(
                                'A online market place on mobile where wedding related service are sold and brought, providing a firm platform for service providers and a trust-able and stress-free marketplace for customers.')
                          ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('How to add a package/service?',
                          style: kmediumblackboldText),
                      trailing: Icon(Icons.arrow_downward),
                      children: [
                        Wrap(
                          children: [
                            Text(
                                'In the main menu screen, click on the 3rd option on the bottom navigation menu. First click on \'Add service\'. Add required details related to service. You can provide multiple services related to package. After adding services, add package name and location. Click on \'Add package\' and a bottom dialog box will appear where you can confirm all your provided details and click on confirm to add a package.')
                          ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('How to book a package',
                          style: kmediumblackboldText),
                      trailing: Icon(Icons.arrow_downward),
                      children: [
                        Wrap(
                          children: [
                            Text(
                                'You can search your required package related to price, location or ratings. On Clicking, you can see the details of package. Click on book package and fill the form according to your desire. It will send a notification to service provider that a package is added and once he confirms your booking, it will appear in your cart. Generate a receipt and it will be added for processing and you can proceed to payment. ')
                          ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('How to pay for the booked package?',
                          style: kmediumblackboldText),
                      trailing: Icon(Icons.arrow_downward),
                      children: [
                        Wrap(
                          children: [
                            Text(
                                'Goto the website as shown on the receipt. Search for your booked ID and click on pay. You will be directed to a screen where your package details will be shown and on clicking pay, metamask wallet will appear and your payment will be send to the service provider. Note: The service provider or the admins will not be paying gas fee. It will be on the customer.')
                          ],
                        )
                      ],
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
