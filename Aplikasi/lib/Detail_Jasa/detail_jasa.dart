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
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Surabaya', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('images/foto_user.jpg'),
                    ),
                    title: Text('Muhammad Yusran Yuris'),
                    subtitle: Text("Universitas Airlangga"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('''
🖥️ Mobile, Modern & Responsive – Tampil menarik di HP, tablet, dan laptop.

🎯 SEO Friendly – Optimal agar website mudah ditemukan di Google.

⚡ Kecepatan Maksimal – Loading cepat untuk pengalaman pengguna terbaik.

🔐 Keamanan Website – Kami bantu proteksi website sesuai kebutuhan Anda.

🛠️ Fitur Kustom Sesuai Kebutuhan – Dibuat sesuai keinginan.
''', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ulasan Pembeli",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Row(
                      children: [
                        Text(
                          "Ael ale",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text("5.0"),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "Pelayanan bagus dan hasil desain sangat memuaskan!",
                      ),
                    ),
                  ),
                  Divider(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Row(
                      children: [
                        Text(
                          "Frisol",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text("2.0"),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text("Pengerjaannya lama bangetttt"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
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
