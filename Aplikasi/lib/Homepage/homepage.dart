import 'package:aplikasi/Components/drawer.dart';
import 'package:flutter/material.dart';
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
            SizedBox(
              height: 230,
              width: double.infinity,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 230,
                    color: Colors.primaries[index % Colors.primaries.length],
                    alignment: Alignment.center,
                    child: Text('Page ${index + 1}'),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Populer saat ini",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(height: 14),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 16 : 10,
                      right: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Item $index",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Mau cari di tempat lain?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                width: double.infinity,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                    Icon(Icons.location_searching, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Surabaya",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        bottomNavigationBar: CustomNavbar(currentIndex: _currentIndex),
      ),
    );
  }
}
