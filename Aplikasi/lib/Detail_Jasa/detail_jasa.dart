import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailJasa extends StatefulWidget {
  final String jasaId;
  const DetailJasa({Key? key, required this.jasaId}) : super(key: key);

  @override
  State<DetailJasa> createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  DocumentSnapshot? jasa;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJasa();
  }

  Future<void> fetchJasa() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('jasa')
              .doc(widget.jasaId)
              .get();

      if (doc.exists) {
        setState(() {
          jasa = doc;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching detail jasa: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Jasa")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (jasa == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Jasa")),
        body: Center(child: Text("Jasa tidak ditemukan")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(jasa!['judul'] ?? 'Detail Jasa'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (jasa!['imageUrl'] != null &&
                jasa!['imageUrl'].toString().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(jasa!['imageUrl']),
              ),
            SizedBox(height: 16),
            Text(
              jasa!['judul'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Rp ${jasa!['harga']}",
              style: TextStyle(color: Colors.orange),
            ),
            SizedBox(height: 8),
            Text(jasa!['lokasi'] ?? ''),
            SizedBox(height: 16),
            Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(jasa!['deskripsi'] ?? 'Tidak ada deskripsi'),
          ],
        ),
      ),
    );
  }
}
