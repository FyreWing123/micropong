import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  static const routeName = '/wishlist';
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(leading: Container()),
      ),
      body: Center(child: Text('Wishlist')),
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}
