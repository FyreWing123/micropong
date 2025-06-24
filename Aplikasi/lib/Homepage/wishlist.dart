import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:aplikasi/Detail_Jasa/detail_jasa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  static const routeName = '/wishlist';

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("✅ Logged in user ID: ${user!.uid}");
    } else {
      print("❌ User belum login");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Wishlist")),
        body: Center(child: Text("Silakan login terlebih dahulu.")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'WISHLIST',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('wishlist')
                .where('userId', isEqualTo: user!.uid)
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("❌ Terjadi error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("📦 Wishlist kamu kosong."));
          }

          final wishlistItems = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final data = wishlistItems[index].data() as Map<String, dynamic>;
              return WishlistItem(data: data);
            },
          );
        },
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}

class WishlistItem extends StatefulWidget {
  final Map<String, dynamic> data;
  const WishlistItem({required this.data});

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  bool isWishlisted = true;

  Future<void> removeFromWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docId = '${user.uid}_${widget.data['jasaId']}';
    await FirebaseFirestore.instance.collection('wishlist').doc(docId).delete();

    setState(() {
      isWishlisted = false;
    });
  }

  void goToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailJasa(jasaId: widget.data['jasaId']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isWishlisted) return SizedBox(); // tidak ditampilkan setelah dihapus

    return InkWell(
      onTap: goToDetail,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/default_jasa.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.data['judul'] ?? 'Tanpa Judul',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: removeFromWishlist,
                ),
                SizedBox(height: 12),
                Text(
                  'Start from',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
                Text(
                  'Rp${widget.data['harga'].toString()}',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
