import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi/Homepage/belumadajasa.dart';
import 'package:aplikasi/Homepage/verifikasi.dart';
import 'package:aplikasi/Homepage/jasa_anda.dart';

class HalamanJasa extends StatefulWidget {
  const HalamanJasa({super.key});
  static const routeName = '/halaman-jasa';

  @override
  _HalamanJasaState createState() => _HalamanJasaState();
}

class _HalamanJasaState extends State<HalamanJasa> {
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

    final verifikasi = user.emailVerified;

    final snapshot = await FirebaseFirestore.instance
        .collection('jasa')
        .where('userId', isEqualTo: user.uid)
        .get();

    final punya = snapshot.docs.isNotEmpty;

    setState(() {
      sudahVerifikasi = verifikasi;
      punyaJasa = punya;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!(sudahVerifikasi ?? false)) {
      return Verifikasi();
    } else if (!(punyaJasa ?? false)) {
      return BelumAdaJasa();
    } else {
      return JasaAnda();
    }
  }
}

