import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:faker/faker.dart';

class Chat extends StatelessWidget {
  var faker = new Faker();
  static const routeName = '/wishlist';
  Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari Kontak, Penjual, & Pesan",
                  hintStyle: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
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

      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ChatItem(
            imageUrl: "https://picsum.photos/id/$index/200/300",
            judul: faker.person.name(),
            subtitle: faker.lorem.sentence(),
          );
        },
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 3),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String judul;
  final String subtitle;

  const ChatItem({
    Key? key,
    required this.imageUrl,
    required this.judul,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: Text(judul),
      subtitle: Text(subtitle),
      trailing: Text("10:00 PM"),
    );
  }
}
