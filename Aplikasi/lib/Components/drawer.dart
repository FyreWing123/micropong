import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/LoginScreen/login.dart';
import 'package:aplikasi/HomePage/profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String nama = 'Memuat...';
  String fotoUrl = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final doc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          nama = data?['username'] ?? 'Tanpa Nama'; // Sesuai field di Firestore
          email = data?['email'] ?? user.email ?? '';
          fotoUrl = data?['fotoUrl'] ?? ''; // optional, fallback avatar
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF9110DC)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          fotoUrl.isNotEmpty
                              ? NetworkImage(fotoUrl)
                              : AssetImage('images/default_avatar.png')
                                  as ImageProvider,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil Saya'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.history),
            title: Text('Riwayat Pemesanan'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
