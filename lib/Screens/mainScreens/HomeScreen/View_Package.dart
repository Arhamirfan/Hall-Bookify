import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hall_bookify/Constants.dart';

class View_Package extends StatefulWidget {
  final Map package_details;
  View_Package(this.package_details);

  @override
  _View_PackageState createState() => _View_PackageState();
}

class _View_PackageState extends State<View_Package> {
  int total = 0;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.package_details['price'].length; i++) {
      int value = int.parse(widget.package_details['price'][i]);
      total = total + value;
    }
    print("Total price is : " + total.toString());
  }

  @override
  void dispose() {
    total = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back),
      //   title: Text(widget.package_details['package']),
      //   backgroundColor: Colors.purpleAccent,
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 300),
              child: ImageSlider(context, widget.package_details['pictures']),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.package_details['package'],
                                      overflow: TextOverflow.ellipsis,
                                      style: klargeblackboldText),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: Colors.purple),
                                      Text(
                                        widget.package_details['location'],
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child:
                                        Icon(Icons.share, color: Colors.green),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Icon(Icons.favorite_outlined,
                                        color: Colors.red),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          ListTile(
                            title:
                                Text('Services', style: kmediumblackboldText),
                            trailing:
                                Text('Price', style: kmediumblackboldText),
                          ),
                          Divider(thickness: 0.5),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.package_details['services'].length,
                              itemBuilder: (context, index) {
                                return Container(
                                    child: ListTile(
                                  title: Text(
                                      widget.package_details['services'][index],
                                      style: kmediumblackboldText),
                                  subtitle: Text(
                                      widget.package_details['description']
                                          [index],
                                      style: ksmallgreyText),
                                  trailing: Text('PKR. ' +
                                      widget.package_details['price'][index]),
                                ));
                              },
                            ),
                          ),
                          ListTile(
                            title:
                                Text('Total : ', style: kmediumblackboldText),
                            trailing: Text("PKR. " + total.toString(),
                                style: kmediumblackboldText),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Book Now', style: kmediumwhiteText),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.purpleAccent),
                ))
          ],
        ),
      ),
    );
    //   Container(
    //   color: Colors.white,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text("Package name : " + widget.package_details['package'],
    //           style: kmediumblackText),
    //       Text("service name : " + widget.package_details['services'][0],
    //           style: kmediumblackText),
    //       Text("Package price : " + widget.package_details['description'][0],
    //           style: kmediumblackText)
    //     ],
    //   ),
    // );
  }
}

Swiper ImageSlider(BuildContext context, List<dynamic> images) {
  return new Swiper(
    itemCount: images.length,
//    viewportFraction: 0.8,
    scale: 0.8,
    autoplay: true,
    itemBuilder: (context, index) {
      return new Image.network(
        images[index],
        fit: BoxFit.cover,
      );
    },
  );
}

Container servicesDataContainer(BuildContext context, List<dynamic> serviceName,
    List<dynamic> serviceDescription, List<dynamic> servicePrice) {
  return new Container();
}
