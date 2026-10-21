import 'package:flutter/material.dart';
import 'package:expense_track/model/model.dart';
import 'package:expense_track/database/expense_database.dart';

class ExpenseProvider with ChangeNotifier {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Model> _expenses = [];

  List<Model> get expenses => _expenses;
  double get total => _expenses.fold(0, (sum, e) => sum + e.amount);

  void add(Model expense) {
    _expenses.add(expense);

    notifyListeners();
  }

  void remove(int index) {
    _expenses.removeAt(index);
    notifyListeners();
  }

  Future<void> loadExpenses() async {
    final data = await ExpenseDatabase().getUserDetails();

    _expenses.clear();

    for (var item in data) {
      _expenses.add(
        Model(
          id: item['id'],
          title: item['title'],
          amount: double.parse(item['amount']),
          category: Category.values.firstWhere(
            (c) => c.name == item['category'],
            orElse: () => Category.others,
          ),
        ),
      );
    }

    notifyListeners();
  }
}
