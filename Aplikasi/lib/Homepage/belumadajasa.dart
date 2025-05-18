import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'verifikasi.dart';

class BelumAdaJasa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Jasa Anda',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kamu belum mengelola jasa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk, jangan sia-siakan bakatmu dan buat jasa sekarang di MicroPong. '
              'Kelola jasa anda dengan manfaat berikut ini.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Icon and text row 1
            Row(
              children: const [
                Icon(Icons.attach_money, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Membantu mendapatkan passive income sebagai mahasiswa',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Icon and text row 2
            Row(
              children: const [
                Icon(Icons.chat_bubble_outline, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Kebebasan bertransaksi dengan metode apapun yang anda mau',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Icon and text row 3
            Row(
              children: const [
                Icon(Icons.calendar_month, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tagihan dan sewa jasa tercatat rapi',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Button: Mulai Mencari Jasa
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: Tambahkan logika navigasi ke fitur pencarian jasa
                },
                child: const Text('Mulai Mencari Jasa'),
              ),
            ),

            const SizedBox(height: 12),
            const Center(child: Text("atau")),
            const SizedBox(height: 12),

            // Button: Buat jasamu sekarang!
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Verifikasi()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAA00FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Buat jasamu sekarang!'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}
