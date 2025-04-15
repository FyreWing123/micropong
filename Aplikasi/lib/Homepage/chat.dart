import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  static const routeName = '/wishlist';
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(leading: Container()),
      ),
      body: Center(child: Text('Chat')),
      bottomNavigationBar: CustomNavbar(currentIndex: 3),
    );
  }
}
