import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupport extends StatelessWidget {
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _subjectcontroller = new TextEditingController();
  TextEditingController _messagecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
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
                    ),
                    ExpansionTile(
                      title:
                          Text('Customer Support', style: kmediumblackboldText),
                      subtitle: Text(
                          'Resolve your dispute and query by contacting us.'),
                      trailing: Icon(Icons.arrow_downward),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Wrap(
                            children: [
                              Text('Subject', style: klargeblackboldText),
                              TextField(
                                controller: _subjectcontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Subject',
                                ),
                                onChanged: (text) {
                                  //fullName = text;
                                },
                              ),
                              Text('Message', style: klargeblackboldText),
                              TextField(
                                controller: _messagecontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Message',
                                ),
                                onChanged: (text) {
                                  //fullName = text;
                                },
                              ),
                              FlatButton(
                                onPressed: () {
                                  _launchEmail(_subjectcontroller.text,
                                      _messagecontroller.text);
                                },
                                child: Text('Submit Query',
                                    style: kmediumwhiteText),
                                color: Colors.purpleAccent,
                              )
                            ],
                          ),
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
  //
  // void _launchURL(String subject) async {
  //   String? encodeQueryParameters(Map<String, String> params) {
  //     return params.entries
  //         .map((e) =>
  //             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  //         .join('&');
  //   }
  //
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: 'arhamirfan18@gmail.com',
  //     query: encodeQueryParameters(<String, String>{'subject': '$subject'}),
  //   );
  //   String url = params.toString();
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }

  _launchEmail(String subject, String message) async {
    String uri =
        'mailto:arhamirfan18@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }
}
