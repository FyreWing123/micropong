import 'package:flutter/material.dart';

class DetailJasaPage extends StatefulWidget {
  const DetailJasaPage({super.key});

  @override
  State<DetailJasaPage> createState() => _DetailJasaPageState();
}

class _DetailJasaPageState extends State<DetailJasaPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://picsum.photos/600/300',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp300,000–600,000",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Desain Web",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Desain web mencakup codingan HTML + Javascript dan lain-lain",
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Surabaya"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Text(" 4.5 "),
                      Text("(50)"),
                      Spacer(),
                      Text("50 orang membeli jasa ini"),
                    ],
                  ),
                  Divider(height: 32),
                  Text(
                    "Informasi tentang penyedia jasa",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text("Muhammad Yusran Yuris"),
                    subtitle: Text("Universitas Airlangga"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.chat),
                      label: Text("Chat Pemilik Jasa"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: Text("Ajukan Pemesanan"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kami siap membantu Anda!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("✅ Keunggulan Layanan Kami"),
                  Text(
                    "🖥️ Mobile, Modern & Responsive – Tampil menarik di HP, tablet, dan laptop.",
                  ),
                  Text(
                    "🎯 SEO Friendly – Optimal agar website mudah ditemukan di Google.",
                  ),
                  Text(
                    "⚡ Kecepatan Maksimal – Loading cepat untuk pengalaman pengguna terbaik.",
                  ),
                  Text(
                    "🔐 Keamanan Website – Kami bantu proteksi website sesuai kebutuhan Anda.",
                  ),
                  Text(
                    "🛠️ Fitur Kustom Sesuai Kebutuhan – Dibuat sesuai keinginan.",
                  ),
                  SizedBox(height: 12),
                  Text("✅ Layanan Tambahan (Free Bonus):"),
                  Text("🎁 Gratis Domain 1 Tahun"),
                  Text("🎁 Gratis Hosting 1 Bulan"),
                  Text("🎁 Bantuan Setup SEO Dasar"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
