import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';

class AjukanPemesanan extends StatefulWidget {
  final String imageUrl;
  final String namaJasa;
  final String harga;

  const AjukanPemesanan({
    super.key,
    required this.imageUrl,
    required this.namaJasa,
    required this.harga,
  });

  static const routeName = '/ajukanpemesanan';

  @override
  _AjukanPemesananState createState() => _AjukanPemesananState();
}

class _AjukanPemesananState extends State<AjukanPemesanan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ajukan Pembayaran',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(children: [Container()]),
        ),
        bottomNavigationBar: CustomNavbar(currentIndex: 2),
      ),
    );
  }
}
