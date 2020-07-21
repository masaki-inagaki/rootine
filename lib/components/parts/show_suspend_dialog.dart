// import 'package:flutter/material.dart';
// import 'package:ROOTINE/models/task_model.dart';

// class ShowSuspendDialog extends StatelessWidget{
//   final Task task;
//   const ShowSuspendDialog({
//     Key key,
//     @required this.task,
//   });

//   Future<String> build(BuildContext context) async {
//     String result = "";
//     result = await showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text("Postpone the task?"),
//           children: <Widget>[
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 80,
//                 width: 200,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       //width: 80,
//                       child: _buildDialogOption('Cancel', null, context,
//                           Colors.white, Colors.black, 50),
//                     ),
//                     Container(
//                       //width: 100,
//                       child: _buildDialogOption('Tomorrow', ' Tomorrow',
//                           context, Colors.blue, Colors.white, 50),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: 20,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   child: _buildDialogOption('Pick date and time', 'More',
//                       context, Colors.white, Colors.black, 20),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     return result;
//   }

//   //Object buildOverride() => override;
//   Widget _buildDialogOption(String t, String rt, BuildContext context,
//       Color color, Color textColor, double height) {
//     return ButtonTheme(
//       height: height,
//       child: FlatButton(
//         onPressed: () {
//           Navigator.pop(context, rt);
//         },
//         color: color,
//         child: Text(
//           t,
//           style: TextStyle(color: textColor),
//         ),
//       ),
//     );
//   }
// }
