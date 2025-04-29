import 'package:flutter/material.dart';

class DetailJasa extends StatefulWidget {
  static const routeName = '/DetailJasa';
  const DetailJasa({super.key});

  @override
  State<DetailJasa> createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset('images/contoh_gambar.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp250.000 - Rp500.000',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Desain Logo Profesional Mahasiswa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 4),
                      Text('4.8 | 120 terjual'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 5.0,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SizedBox(height: 16), Text("Deskripsi Produk:")],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // tombol aksi tetap di bawah
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(Icons.chat),
                label: Text('Chat Pemilik Jasa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                child: Text('Ajukan Pemesanan'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
