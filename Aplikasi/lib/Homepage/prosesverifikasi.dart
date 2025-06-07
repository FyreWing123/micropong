import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';

class ProsesVerifikasi extends StatelessWidget {
  const ProsesVerifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Verifikasi Diproses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Verifikasi Sedang Diproses',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Terima kasih! Dokumen Anda telah dikirim dan sedang dalam proses peninjauan oleh tim MicroPong.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            const Text(
              'Estimasi proses ini memerlukan waktu maksimal 1x24 jam kerja.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            const Text(
              'Kami akan memberi tahu Anda melalui notifikasi dan email setelah verifikasi selesai.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.amber, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Beranda'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi batalkan jika perlu
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Batalkan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),
    );
  }
}
