// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';

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
