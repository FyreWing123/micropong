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
            const Text('Verifikasi Email'),
            const SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Masukkan Email Anda",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Verifkasi Nomor Telepon'),
            const SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Masukan Nomor Telepon Anda",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Verifikasi Identitas (Title + Subtitle)
                Text(
                  "Verifikasi Identitas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(
                  "Kami melindungi informasi dan penggunaan data diri para pengguna kami.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                SizedBox(height: 20),

                // Upload Foto Identitas (Title)
                Text(
                  "Upload Foto Identitas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                SizedBox(height: 20),

                // Disclaimer
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
                        "Dengan melengkapi formulir ini, penjual telah menyatakan bahwa:",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "• Semua info yang diberikan kepada MicroPong adalah akurat, valid, dan terbaru.",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      Text(
                        "• Penjual memiliki izin dan kekuasaan penuh sesuai hukum yang berlaku untuk menawarkan jasa di MicroPong.",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      Text(
                        "• Semua tindakan yang dilakukan oleh penjual telah sah dan merupakan perjanjian yang berlaku bagi penjual.",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Tombol Lanjut
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Lanjut",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}
