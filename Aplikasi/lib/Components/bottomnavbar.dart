import 'package:flutter/material.dart';
import 'package:aplikasi/Homepage/homepage.dart';
import 'package:aplikasi/Homepage/wishlist.dart';
import 'package:aplikasi/Homepage/chat.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;

  const CustomNavbar({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = Homepage();
        break;
      case 1:
        page = WishlistPage();
        break;
      case 2:
        page = Chat();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => _navigate(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: isActive ? Colors.amber : Colors.white60),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isActive ? Colors.amber : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 22, top: 15),
      decoration: const BoxDecoration(color: Color(0xFF9110DC)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, "Home", 0),
          _buildNavItem(context, Icons.favorite, "Wishlist", 1),
          _buildNavItem(context, Icons.chat, "Chat", 3),
        ],
      ),
    );
  }
}
