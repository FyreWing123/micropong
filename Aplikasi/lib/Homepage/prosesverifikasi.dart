import 'package:aplikasi/Homepage/verifikasi.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';

class Prosesverifikasi extends StatefulWidget {
  @override
  _ProsesverifikasiState createState() => _ProsesverifikasiState();
}

class _ProsesverifikaasiState extends State<Prosesverifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Verifikasi()),
            );
          },
        ),
        title: Text(
          'Verifikasi Diproses',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(padding: const EdgeInserts.all(16)),
    );
  }
}
