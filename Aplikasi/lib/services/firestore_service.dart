import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Tambahkan user baru ke koleksi 'users'
  Future<void> addUser(String uid, UserModel user) async {
    await _db.collection('users').doc(uid).set(user.toJson());
  }

  // Ambil user dari Firestore (jika nanti kamu perlu)
  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }
}
