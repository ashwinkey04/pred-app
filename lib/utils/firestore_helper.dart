import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreHelper {
  static updateUserDocument(Map<String, dynamic> udpationMap) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(udpationMap, SetOptions(merge: true));
  }

  static fetchStocksList() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('stocks').get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future<Map> checkUserDocumentData() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userData.exists) {
      return {"exists": true, "data": userData.data()};
    } else {
      return {"exists": false};
    }
  }

  static getRefMessageAndImage() async {
    var doc = await FirebaseFirestore.instance
        .collection('appInfo')
        .doc('refInfo')
        .get()
        .then((value) => value.data());
    return doc;
  }
}
