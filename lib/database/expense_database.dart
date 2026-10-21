import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseDatabase {
  Future addUserDetails(Map<String, dynamic> userinfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userinfoMap);
  }

  Future DeleteUserDetails(String id) async {
    return FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  Future<QuerySnapshot> getthisuserinfo() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  Future<List<Map<String, dynamic>>> getUserDetails() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
