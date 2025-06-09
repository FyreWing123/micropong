import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:aplikasi/Homepage/tambah_jasa.dart';

class Jasa_Anda extends StatefulWidget {
  static const routeName = '/jasa-anda';

  @override
  _Jasa_AndaState createState() => _Jasa_AndaState();
}

class _Jasa_AndaState extends State<Jasa_Anda> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        userName = userDoc.data()?['name'] ?? 'Anda';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Jasa Anda",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelola jasa yang kamu tawarkan di MicroPong!',
              style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('jasa')
                        .where(
                          'userId',
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                        )
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Belum ada jasa."));
                  }

                  final jasaList = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: jasaList.length,
                    itemBuilder: (context, index) {
                      final data =
                          jasaList[index].data() as Map<String, dynamic>;

                      return JasaCard(
                        title: data['judul'] ?? 'Tanpa Judul',
                        owner: userName ?? 'Anda',
                        price: data['harga'] ?? 0,
                        status: data['status'] ?? 'Aktif',
                        statusColor:
                            (data['status'] == 'Aktif')
                                ? Colors.green
                                : Colors.grey,
                        imageUrl:
                            data['imageUrl'] ??
                            'https://via.placeholder.com/300x200',
                        borderColor: Colors.transparent,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahJasa()),
          );
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}

class JasaCard extends StatelessWidget {
  final String title;
  final String owner;
  final int price;
  final String status;
  final Color statusColor;
  final String imageUrl;
  final Color borderColor;

  const JasaCard({
    Key? key,
    required this.title,
    required this.owner,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.imageUrl,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          owner,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'start from',
                        style: TextStyle(fontSize: 10, color: Colors.black45),
                      ),
                      Text(
                        'Rp${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.more_vert, color: Colors.black45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
