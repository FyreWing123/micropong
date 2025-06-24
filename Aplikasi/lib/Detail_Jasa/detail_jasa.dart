import 'package:aplikasi/Homepage/ajukanpemesanan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailJasa extends StatefulWidget {
  final String jasaId;
  const DetailJasa({Key? key, required this.jasaId}) : super(key: key);

  @override
  State<DetailJasa> createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  DocumentSnapshot? jasa;
  bool isLoading = true;
  bool isWishlisted = false;

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

      setState(() {
        jasa = doc.exists ? doc : null;
        isLoading = false;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final wishDoc =
            await FirebaseFirestore.instance
                .collection('wishlist')
                .doc('${user.uid}_${widget.jasaId}')
                .get();
        setState(() {
          isWishlisted = wishDoc.exists;
        });
      }
    } catch (e) {
      print("Error fetching detail jasa: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> toggleWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || jasa == null) return;

    final jasaData = jasa!.data() as Map<String, dynamic>;
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlist')
        .doc('${user.uid}_${widget.jasaId}');

    if (isWishlisted) {
      await wishlistRef.delete();
    } else {
      await wishlistRef.set({
        'userId': user.uid,
        'jasaId': widget.jasaId,
        'judul': jasaData['judul'],
        'harga': jasaData['harga'],
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    setState(() {
      isWishlisted = !isWishlisted;
    });
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

    final data = jasa!.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['judul'] ?? 'Detail Jasa'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                'images/default_jasa.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data['judul'] ?? '-',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: isWishlisted ? Colors.red : Colors.grey,
                        ),
                        onPressed: toggleWishlist,
                      ),
                    ],
                  ),
                  Text(
                    "Rp ${data['harga'] ?? 0}",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                  ),
                  Divider(color: Colors.grey[300], thickness: 10, height: 20),
                  SizedBox(height: 12),
                  Text(
                    "Deskripsi Jasa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(data['deskripsi'] ?? 'Tidak ada deskripsi'),
                ],
              ),
            ),
            Divider(color: Colors.grey[400], thickness: 2, height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap:
                    () => Navigator.of(
                      context,
                    ).pushNamed(AjukanPemesanan.routeName),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Ajukan Pemesanan",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
