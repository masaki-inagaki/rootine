import 'package:flutter/material.dart';

class OverdueEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120.0,
        height: 150.0,
        child: Column(children: <Widget>[
          Image(image: AssetImage('image/all_done.png')),
          Text('Well done!!'),
        ]),
      ),
    );
  }
}
