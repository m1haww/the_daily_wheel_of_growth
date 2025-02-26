// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';

// class Pw {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String _hashPin(String pin) {
//     var bytes = utf8.encode(pin);
//     return sha256.convert(bytes).toString(); // Hash PIN for security
//   }

//   Future<void> savePin(String userId, String pin) async {
//     String hashedPin = _hashPin(pin);
//     await _firestore.collection('users').doc(userId).set({'pin': hashedPin});
//   }

//   Future<bool> validatePin(String userId, String enteredPin) async {
//     DocumentSnapshot userDoc =
//         await _firestore.collection('users').doc(userId).get();
//     if (userDoc.exists) {
//       String savedHashedPin = userDoc['pin'];
//       return savedHashedPin == _hashPin(enteredPin);
//     }
//     return false;
//   }
// }

// class PasswordPage extends StatefulWidget {
//   @override
//   _PasswordPageState createState() => _PasswordPageState();
// }

// class _PasswordPageState extends State<PasswordPage> {
//   List<int> pin = [];
//   Pw pinService = Pw();

//   void _submitPin() async {
//     if (pin.length == 4) {
//       String userId = "user123"; // Replace with authenticated user ID
//       await pinService.savePin(userId, pin.join());
//       print("PIN Set!");
//     }
//   }

//   void _checkPin() async {
//     String userId = "user123"; // Replace with actual user ID
//     bool isValid = await pinService.validatePin(userId, pin.join());

//     if (isValid) {
//       print("PIN valid! Access granted.");
//       // Navigate to the main screen
//     } else {
//       print("PIN invalid! Please try again.");
//     }
//   }

//   void _addNumber(int number) {
//     if (pin.length < 4) {
//       setState(() {
//         pin.add(number);
//       });
//     }
//   }

//   void _removeNumber() {
//     if (pin.isNotEmpty) {
//       setState(() {
//         pin.removeLast();
//       });
//     }
//   }

//   Widget _buildNumberButton(int number) {
//     return GestureDetector(
//       onTap: () => _addNumber(number),
//       child: Container(
//         width: 70,
//         height: 70,
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.grey[800],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: Text(
//             "$number",
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Set Password",
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               4,
//               (index) => Container(
//                 width: 40,
//                 height: 40,
//                 margin: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[700],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     pin.length > index ? "${pin[index]}" : "",
//                     style: TextStyle(fontSize: 24, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               childAspectRatio: 1.2,
//             ),
//             itemCount: 9,
//             itemBuilder: (context, index) {
//               return _buildNumberButton(index + 1);
//             },
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildNumberButton(0),
//               GestureDetector(
//                 onTap: _removeNumber,
//                 child: Container(
//                   width: 70,
//                   height: 70,
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.purple,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(Icons.backspace, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submitPin,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text("Set",
//                 style: TextStyle(fontSize: 18, color: Colors.white)),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _checkPin,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text("Check PIN",
//                 style: TextStyle(fontSize: 18, color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }
