import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/Components/drawer.dart';
import 'package:aplikasi/Detail_Jasa/detail_jasa.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/homepage';
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 220, 220, 220),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Icon(Icons.search, color: Colors.grey, size: 24),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 50),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        drawer: CustomDrawer(),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Rekomendasi untuk Anda",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('jasa').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.73,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailJasa(jasaId: doc.id),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  data['imageUrl'] ??
                                      'https://via.placeholder.com/150',
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data['judul'] ?? '-',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 16,
                                            ),
                                            Text(
                                              "4.8",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          data['lokasi'] ?? '-',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      data['pemilik'] ?? '-',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "start from",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Rp ${data['harga']}",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
        bottomNavigationBar: CustomNavbar(currentIndex: _currentIndex),
      ),
    );
  }
}
