import 'package:flutter/material.dart';
import 'belumadajasa.dart';
import 'verifikasi.dart';
import 'jasa_anda.dart';

class HalamanJasa extends StatelessWidget {
  final bool sudahVerifikasi;
  final bool punyaJasa;

  const HalamanJasa({
    super.key,
    required this.sudahVerifikasi,
    required this.punyaJasa,
  });

  @override
  Widget build(BuildContext context) {
    if (!sudahVerifikasi) {
      return Verifikasi();
    } else if (!punyaJasa) {
      return BelumAdaJasa();
    } else {
      return JasaAnda();
    }
  }
}
