// import 'package:flutter/material.dart';
// import 'package:ROOTINE/models/task_model.dart';

// class ShowSuspendDialog extends StatelessWidget {
//   final Task task;
//   const ShowSuspendDialog({
//     Key key,
//     @required this.task,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final result = showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text("Postpone the task?"),
//           children: <Widget>[
//             _buildDialogOption('Tomorrow', ' Tomorrow', context),
//             _buildDialogOption('Cancel', 'Cancel', context),
//           ],
//         );
//       },
//     );
//     return result;
//   }

//   //Object buildOverride() => override;

//   Widget _buildDialogOption(String t, String rt, BuildContext context) {
//     return SimpleDialogOption(
//       child: ListTile(
//         title: Text(t),
//       ),
//       onPressed: () {
//         Navigator.pop(context, rt);
//       },
//     );
//   }
// }
