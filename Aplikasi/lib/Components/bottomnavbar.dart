import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;
  final double iconSize;
  final double fontSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    this.iconSize = 28,
    this.fontSize = 14,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.white60,
    this.backgroundColor = Colors.purple,
  });

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: isActive ? activeColor : inactiveColor,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 22, top: 15),
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(15)),
          _buildNavItem(Icons.home, "Home", 0),
          Padding(padding: EdgeInsets.all(14)),
          _buildNavItem(Icons.favorite, "Wishlist", 1),
          Padding(padding: EdgeInsets.all(15)),
          _buildNavItem(Icons.business_center, "Jasa Anda", 2),
          Padding(padding: EdgeInsets.all(18)),
          _buildNavItem(Icons.chat, "Chat", 3),
          Padding(padding: EdgeInsets.all(18)),
          _buildNavItem(Icons.person, "Profile", 4),
        ],
      ),
    );
  }
}
