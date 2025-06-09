import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi/models/user_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // Tambah user baru dengan UserModel (khusus Sign Up manual)
  Future<void> addUser(String uid, UserModel user) async {
    await _db.collection('users').doc(uid).set(user.toJson());
  }

  // Ambil user jika perlu
  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Cek & Buat user jika belum ada (khusus Google Sign-In atau login umum)
  Future<void> createUserIfNotExists(User user) async {
    final doc = await _db.collection('users').doc(user.uid).get();
    if (!doc.exists) {
      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'nama': user.displayName ?? 'User Baru',
        'email': user.email,
        'fotoUrl': user.photoURL ?? 'https://i.imgur.com/BoN9kdC.png',
        'isProvider': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> tambahJasa(Map<String, dynamic> jasaData) async {
    await _db.collection('jasa').add(jasaData);
  }
}
