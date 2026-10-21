import 'package:expense_track/model/model.dart';
import 'package:expense_track/widget/category_animated_icon.dart';
import 'package:flutter/material.dart';

class Cardexpense extends StatefulWidget {
  const Cardexpense({super.key, required this.expense});
  final Model expense;
  @override
  State<StatefulWidget> createState() {
    return _CardexpenseState();
  }
}

class _CardexpenseState extends State<Cardexpense> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white54,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryAnimatedIcon(category: widget.expense.category),
            Text(
              widget.expense.title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 20),

            Text(
              widget.expense.categoryName,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            //Text("Thh", style: TextStyle(color: Colors.white)),
            const SizedBox(width: 8),
            Text(
              'PKR : ${widget.expense.amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
