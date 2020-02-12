// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zomato_clone/models/test_model.dart';

// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider<TestModel>(,
//       create: (context) => TestModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('hello'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                   onPressed: Provider.of<TestModel>(context).increment),
//               Text(Provider.of<TestModel>(context).count.toString())
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
