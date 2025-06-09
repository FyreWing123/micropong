import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi/Homepage/belumadajasa.dart';
import 'package:aplikasi/Homepage/verifikasi.dart';
import 'package:aplikasi/Homepage/jasa_anda.dart';

class Halaman_Jasa extends StatefulWidget {
  const Halaman_Jasa({super.key});
  static const routeName = '/halaman-jasa';

  @override
  _Halaman_JasaState createState() => _Halaman_JasaState();
}

class _Halaman_JasaState extends State<Halaman_Jasa> {
  bool? sudahVerifikasi;
  bool? punyaJasa;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cekStatusUser();
  }

  Future<void> _cekStatusUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('jasa')
            .where('userId', isEqualTo: user.uid)
            .get();

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final data = userDoc.data();
    final sudahVerif = data?['isProvider'] == true;

    setState(() {
      sudahVerifikasi = sudahVerif;
      punyaJasa = snapshot.docs.isNotEmpty;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!(sudahVerifikasi ?? false)) {
      return BelumAdaJasa();
    } else if (!(punyaJasa ?? false)) {
      return BelumAdaJasa();
    } else {
      return Jasa_Anda();
    }
  }
}
