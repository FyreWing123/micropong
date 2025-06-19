import 'package:aplikasi/Components/drawer.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:aplikasi/Homepage/rekomendasi_jasa.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 220, 220, 220),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Icon(Icons.search, color: Colors.grey, size: 24),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 50),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              "Rekomendasi untuk Anda",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
          ),
          RekomendasiJasa(),
          SizedBox(height: 30),
        ],
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: _currentIndex),
    );
  }
}
