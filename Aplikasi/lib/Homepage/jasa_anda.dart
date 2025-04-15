import 'package:aplikasi/Components/bottomnavbar.dart';
import 'package:flutter/material.dart';

class JasaAnda extends StatelessWidget {
  static const routeName = '/wishlist';
  const JasaAnda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(leading: Container()),
      ),
      body: Center(child: Text('Jasa Anda')),
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
    );
  }
}
