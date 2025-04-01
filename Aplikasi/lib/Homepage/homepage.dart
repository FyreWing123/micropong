import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65), // Set custom height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ), // Adjust left/right padding
              child: SizedBox(
                height: 45, // Adjust search box height
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Rounded search bar
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(
                      255,
                      220,
                      220,
                      220,
                    ), // Light background for search bar
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 10,
                      ), // Adjust icon position
                      child: Icon(Icons.search, color: Colors.grey, size: 24),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 50,
                    ), // Adjust icon area width
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              //container iklan
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
            SizedBox(height: 30),
            Padding(
              // populer saat ini
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Populer saat ini",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 14),
            SizedBox(
              //container populer saat ini
              height: 200, // Tinggi container
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Jumlah item
                itemBuilder: (context, index) {
                  return Container(
                    width: 200, // Lebar tiap item
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
                          blurRadius: 6, // Blur shadow
                          spreadRadius: 2, // Lebar shadow
                          offset: Offset(0, 4), // Posisi shadow (x, y)
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
              //mau cari ditempat lain?
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Mau cari di tempat lain?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
