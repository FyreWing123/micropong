import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:aplikasi/Homepage/belumadajasa.dart';

class Verifikasi extends StatefulWidget {
  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
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
              MaterialPageRoute(builder: (_) => BelumAdaJasa()),
            );
          },
        ),
        title: Text(
          'Verifikasi Akun',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email'),
            const SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Nomor Handphone'),
            const SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter your phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}
