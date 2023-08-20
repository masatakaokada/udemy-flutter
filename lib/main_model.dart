import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
// domain
import 'package:udemy_flutter/domain/firestore_user/firestore_user.dart';

final mainProvider = ChangeNotifierProvider(((ref) => MainModel()));

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> createUser({required BuildContext context}) async {
    final uuid = Uuid();
    final String v4 = uuid.v4();
    // final Map<String, dynamic> userData = {
    //   'userName': 'Alice',
    //   'uid': v4
    // };
    final FirestoreUser firestoreUser =
        FirestoreUser(userName: 'Alice', uid: v4);
    final Map<String, dynamic> userData = firestoreUser.toJson();
    final Map<String, dynamic> userData2 = {'userName': 'Bob', 'uid': 'abcd'};
    final FirestoreUser firestoreUser2 = FirestoreUser.fromJson(userData2);
    // Bobと表示されるはず
    print(firestoreUser2.userName);
    counter++;
    await FirebaseFirestore.instance.collection('users').doc(v4).set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }
}
