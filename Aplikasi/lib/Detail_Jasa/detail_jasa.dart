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
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text("Detail Jasa"),
          backgroundColor: Color(0xFF9110DC),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF9110DC)),
        ),
      );
    }

    if (jasa == null) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text("Detail Jasa"),
          backgroundColor: Color(0xFF9110DC),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                "Jasa tidak ditemukan",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    final data = jasa!.data() as Map<String, dynamic>;
    final imageUrl = data['imageUrl'] ?? 'https://via.placeholder.com/300';
    final namaJasa = data['judul'] ?? '-';
    final harga = "Rp ${data['harga'] ?? 0}";
    final deskripsi = data['deskripsi'] ?? 'Tidak ada deskripsi';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Color(0xFF9110DC),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'images/default_jasa.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: isWishlisted ? Colors.red : Colors.grey[600],
                  ),
                  onPressed: toggleWishlist,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header dengan harga
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                namaJasa,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF9110DC).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  harga,
                                  style: TextStyle(
                                    color: Color(0xFF9110DC),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Divider
                    Container(height: 1, color: Colors.grey[200]),

                    SizedBox(height: 24),

                    // Deskripsi
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      deskripsi,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC107),
                foregroundColor: Colors.black,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AjukanPemesanan(
                          imageUrl: imageUrl,
                          namaJasa: namaJasa,
                          harga: harga,
                        ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Ajukan Pemesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
