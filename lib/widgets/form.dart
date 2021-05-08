// import 'package:flutter/material.dart';
//
// class Form extends StatefulWidget {
//   @override
//   _FormState createState() => _FormState();
// }
//
// class _FormState extends State<Form> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: SingleChildScrollView(
//       child: Form(ch),
//     ),);
//   }
// }
//
//
//
//
//
//
//
// // class Form extends StatefulWidget {
// //   @override
// //   _FormState createState() => _FormState();
// // }
// //
// // class _FormState extends State<Form> {
// //   final formkey = GlobalKey<FormState>();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         SingleChildScrollView(
// //           child: Form(
// //               key: formkey,
// //               child:Column(
// //                 children: [
// //                   TextFormField(
// //                     validator: (val) => (val.isEmpty
// //                         ? "provide a name for your document"
// //                         : null),
// //                     decoration: InputDecoration(hintText: "Document title"),
// //                     onSaved: (val) => _note.title = val,
// //                   ),
// //                   TextFormField(
// //                     onSaved: (val) => _note.body = val,
// //                     validator: (val) => null,
// //                     textAlign: TextAlign.justify,
// //                     style: TextStyle(fontSize: 20),
// //                     keyboardType: TextInputType.multiline,
// //                     maxLines: null,
// //                     decoration: InputDecoration(
// //                       border: InputBorder.none,
// //                     ),
// //                     textInputAction: TextInputAction.newline,
// //                   ),
// //                 ],
// //               ),
// //           ),
// //         ),
// //         SizedBox(
// //           height: 20,
// //         ),
// //       ],
// //     );
// //   }
// // }
// // child:Form(
// // key: formkey,
// // child:
// // ),