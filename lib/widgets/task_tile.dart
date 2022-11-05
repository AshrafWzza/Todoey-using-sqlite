// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// use provider

// // important there is no need to do like in course(check scroll down)  that create statlessWidget And statefulWidget then Passing values
// class TaskTile extends StatefulWidget {
//   //use provider instead passing values
//   // String title;
//   // bool checkedBox;
//   //TaskTile({required this.title, this.checkedBox = false});
//   @override
//   State<TaskTile> createState() => _TaskTileState();
// }
//
// class _TaskTileState extends State<TaskTile> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         widget.title,
//         style: TextStyle(
//             decoration: widget.checkedBox ? TextDecoration.lineThrough : null),
//       ),
//       trailing: Checkbox(
//         value: widget.checkedBox,
//         onChanged: (bool? value) {
//           setState(() {
//             widget.checkedBox = value!;
//           });
//         },
//       ),
//     );
//   }
// }
//--------------------------------------------------
//////code in course
// import 'package:flutter/material.dart';
//
// class TaskTile extends StatefulWidget {
//   @override
//   _TaskTileState createState() => _TaskTileState();
// }
//
// class _TaskTileState extends State<TaskTile> {
//   bool isChecked = false;
//
//   void checkboxCallback(bool? checkBoxState) {
//     setState(() {
//       if (checkBoxState != null) {
//         isChecked = checkBoxState;
//       } else {
//         isChecked = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         "This is a task",
//         style: TextStyle(
//           decoration: isChecked ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: TaskCheckBox(
//           checkboxState: isChecked, toggleCheckboxState: checkboxCallback),
//     );
//   }
// }
//
// class TaskCheckBox extends StatelessWidget {
//   final bool checkboxState;
//   final Function(bool?) toggleCheckboxState;
//
//   TaskCheckBox(
//       {required this.checkboxState, required this.toggleCheckboxState});
//
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       activeColor: Colors.lightBlueAccent,
//       value: checkboxState,
//       onChanged: toggleCheckboxState,
//     );
//   }
// }
