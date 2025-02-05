import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CellWidget extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const CellWidget({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: CELL_SIZE,
        height: CELL_SIZE,
        decoration: BoxDecoration(
          color: BOARD_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: CELL_SIZE * 0.6,
              color: value == 'X' ? X_COLOR : O_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
