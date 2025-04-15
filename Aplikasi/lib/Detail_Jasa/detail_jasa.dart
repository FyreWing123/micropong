import 'package:flutter/material.dart';

class DetailJasa extends StatelessWidget {
  static const routeName = '/DetailJasa';
  const DetailJasa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Jasa")),
      body: Center(child: Text("dummy")),
    );
  }
}
