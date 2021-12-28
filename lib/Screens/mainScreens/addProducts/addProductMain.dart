import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/mainScreens/addProducts/addTaskScreen.dart';
import 'package:hall_bookify/Widgets/ServicesList.dart';

class AddProduct extends StatelessWidget {
  // TextEditingController _serviceNameController = TextEditingController();
  // TextEditingController _servicePriceController = TextEditingController();
  // TextEditingController _serviceDescriptionController = TextEditingController();
  // TextEditingController _picturesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('This is 3rd screen add product'),
                ServicesList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => addTaskScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
//
// class serviceCard extends StatelessWidget {
//   String title, description, price;
//   serviceCard(
//       {required this.title, required this.description, required this.price});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   child: Text('Disini Judul', style: klargeblackboldText),
//                 ),
//                 Container(
//                   child: Text(
//                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Container(
//             child: Image.network(
//               'https://picsum.photos/250?image=9',
//               width: 100,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// AlertDialog(
// title: Text("Add Services"),
// content: Column(
// children: [
// buildTextField(
// "Service Name", "Name", _serviceNameController),
// buildTextField(
// "Service Price", "Price", _servicePriceController),
// buildTextField("Service Description", "Description",
// _serviceDescriptionController),
// ],
// ),
// actions: [
// FlatButton(
// child: Text("Close"),
// onPressed: () {
// Navigator.of(context).pop();
// },
// ),
// FlatButton(
// child: Text(
// "SUBMIT",
// style: TextStyle(color: Colors.white),
// ),
// color: Colors.purple,
// onPressed: () {
// // serviceCard(
// //     title: _serviceNameController.text,
// //     description: _serviceDescriptionController.text,
// //     price: _servicePriceController.text);
// },
// )
// ],
// );
