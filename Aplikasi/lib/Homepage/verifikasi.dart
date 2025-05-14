import 'package:aplikasi/Homepage/belumadajasa.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/Components/bottomnavbar.dart';

class Verifikasi extends StatefulWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(BelumAdaJasa());
          },
        ),
        title: Text(
          'Verifikasi Akun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
