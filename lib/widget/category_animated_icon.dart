// Add to pubspec.yaml:
// dependencies:
//   flutter_animate: ^4.5.0

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:expense_track/model/model.dart';

Map<Category, IconData> categoryIcons = {
  Category.food: Icons.restaurant,
  Category.shopping: Icons.shopping_bag,
  Category.bill: Icons.receipt_long,
  Category.transport: Icons.directions_car,
  Category.others: Icons.category,
};

const Map<Category, Color> categoryColors = {
  Category.food: Color(0xff120c6e),
  Category.shopping: Color(0xffe63946),
  Category.bill: Color(0xfff4a261),
  Category.transport: Color(0xff2a9d8f),
  Category.others: Color(0xff6c757d),
};

class CategoryAnimatedIcon extends StatelessWidget {
  final Category category;
  final double size;

  const CategoryAnimatedIcon({
    super.key,
    required this.category,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      categoryIcons[category],
      color: categoryColors[category],
      size: size,
    );

    switch (category) {
      case Category.food:
        return icon
            .animate()
            .scale(
              begin: const Offset(0.4, 0.4),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 200.ms);

      case Category.shopping:
        return icon
            .animate()
            .slideX(
              begin: 1,
              end: 0,
              duration: 350.ms,
              curve: Curves.easeOutCubic,
            )
            .fadeIn(duration: 250.ms);

      case Category.bill:
        return icon
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(
              begin: const Offset(0.7, 0.7),
              end: const Offset(1, 1),
              duration: 300.ms,
              curve: Curves.easeOutBack,
            );

      case Category.transport:
        return icon
            .animate()
            .slideX(
              begin: -1,
              end: 0,
              duration: 350.ms,
              curve: Curves.easeOutCubic,
            )
            .fadeIn(duration: 250.ms);

      case Category.others:
        return icon
            .animate()
            .rotate(
              begin: -0.2,
              end: 0,
              duration: 400.ms,
              curve: Curves.easeOutExpo,
            )
            .fadeIn(duration: 300.ms);
    }
  }
}

// USAGE:
// CategoryAnimatedIcon(
//   key: ValueKey(expense.id), // unique key so animation replays each time
//   category: expense.category,
// )
