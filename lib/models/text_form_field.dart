// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ROOTINE/models/task_model.dart';
// import 'package:ROOTINE/models/task_list.dart';
// import 'package:intl/intl.dart';

// class TextFormFieldModel extends StatelessWidget {
//   final String input;
//   final TextEditingController controller;
//   final int maxLength;
//   final TextInputType keyboardType;
//   final String labelText;
//   final String hintText;
//   final Widget suffixIcon;
//   final Type validatorClass;
//   TextFormFieldModel({
//     Key key,
//     this.input,
//     @required this.controller,
//     this.maxLength,
//     this.keyboardType,
//     @required this.labelText,
//     @required this.hintText,
//     this.suffixIcon,
//     this.validatorClass,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return new TextFormField(
//       controller: controller,
//       enabled: true,
//       maxLength: maxLength,
//       maxLengthEnforced: true,
//       autovalidate: false,
//       autofocus: false,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         suffixIcon: suffixIcon,
//       ),
//       validator: (input) {
//         return validatorClass(input);
//       },
//     );
//   }
// }
