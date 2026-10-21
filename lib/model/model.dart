enum Category { food, transport, bill, shopping, others }

class Model {
  final String id;
  final String title;
  final double amount;
  //final DateTime date;
  final Category category;

  const Model({
    required this.id,
    required this.amount,
    required this.title,
    required this.category,
  });

  String get categoryName {
    switch (category) {
      case Category.food:
        return 'Food';
      case Category.bill:
        return 'Bill';
      case Category.shopping:
        return 'Shopping';
      case Category.transport:
        return 'Transport';
      case Category.others:
        return 'Others';
    }
  }
}
