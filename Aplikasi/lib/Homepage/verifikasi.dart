import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:aplikasi/Homepage/belumadajasa.dart';

class Verifikasi extends StatefulWidget {
  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> submitVerification() async {
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mohon lengkapi email dan nomor telepon")),
      );
      return;
    }

    if (uid == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User tidak ditemukan")));
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'email': email,
        'phoneNumber': phone,
        'isProvider': true,
        'emailVerified': true,
        'phoneVerified': true,
        'isVerified': true,
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data berhasil diverifikasi")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BelumAdaJasa()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    }
  }

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
            const Text('Verifikasi Email'),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Masukkan Email Anda",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Verifikasi Nomor Telepon'),
            const SizedBox(height: 5),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Masukkan Nomor Telepon Anda",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Dengan melengkapi formulir ini, Anda menyatakan bahwa:",
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "• Semua info yang diberikan adalah akurat, valid, dan terbaru.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  Text(
                    "• Anda memiliki izin dan kuasa penuh untuk menawarkan jasa.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  Text(
                    "• Semua tindakan yang dilakukan merupakan perjanjian yang berlaku.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Lanjut", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}
