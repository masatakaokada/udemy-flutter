import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = ChangeNotifierProvider(((ref) => MainModel()));

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> createUser({required BuildContext context}) async {
    final Map<String, dynamic> userData = {
      'userName': 'Alice',
      'uid': 'firstUser'
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc('firstUser')
        .set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    counter++;
    notifyListeners();
  }
}
