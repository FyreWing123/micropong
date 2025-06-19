import 'package:aplikasi/Components/editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String phone = '';
  String photoUrl = '';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(user.uid)
              .get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          username = data['username'] ?? 'Tanpa Nama';
          email = data['email'] ?? '';
          phone = data['phone'] ?? '';
          photoUrl = data['fotoUrl'] ?? ''; // Optional
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF9110DC),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Foto profil
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : const AssetImage('images/default_avatar.png')
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(email, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(phone, style: const TextStyle(color: Colors.grey)),

                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, EditProfile.routeName);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
