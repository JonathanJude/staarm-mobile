import 'package:flutter/material.dart';

class StaarmShimmers {
  static Widget loadCars() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF7F7F7),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF7F7F7),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: 150,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF7F7F7),
            ),
          ),
        ],
      ),
    );
  }
}
