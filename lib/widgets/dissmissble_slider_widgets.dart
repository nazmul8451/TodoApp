// import 'package:flutter/material.dart';
//
//
// class DissmissbleSliderWidgets extends StatelessWidget {
//   const DissmissbleSliderWidgets({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: ListView.builder(
//             itemCount: filteredTask.length,
//             itemBuilder: (context, index) {
//               return Dismissible(
//                 key: Key(UniqueKey().toString()),
//                 background: Container(
//                   color: Colors.green,
//                   child: Icon(
//                     Icons.check_box,
//                     color: Colors.white,
//                   ),
//                 ),
//                 secondaryBackground: Container(
//                   color: Colors.red,
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onDismissed: (direction) {
//                   if (direction == DismissDirection.startToEnd) {
//                     //task compeleted
//                     toggle_taskStatus(index);
//                   } else {
//                     //task deleted
//                     delete_taskStatus(index);
//                   }
//                 },
//                 child: Card(
//                   child: ListTile(
//                     title: Text(filteredTask[index]['task'],style: TextStyle(
//                         fontSize: 16,
//                         decoration: filteredTask[index]['completed']?TextDecoration.lineThrough:null
//                     ),),
//                     trailing: IconButton(
//                         onPressed: ()=>showTaskDialog(index),
//                         icon:Icon(Icons.edit) ),
//                   ),
//                 ),
//               );
//             }));
//   }
// }
