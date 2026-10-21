import 'package:expense_track/provider/expense_provider.dart';
import 'package:expense_track/widget/addexpenses.dart';
import 'package:expense_track/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_track/database/expense_database.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomescreenState();
  }
}

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ExpenseProvider>(context, listen: false).loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    //final expenses = provider.expenses;

    return Scaffold(
      backgroundColor: Color(0xffCBD8E8),
      appBar: AppBar(
        animateColor: true,
        backgroundColor: Color(0xff120c6e),
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff120c6e),

        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,

            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Addexpenses(),
            ),
          );
        },
        child: const Icon(Icons.add, size: 28, color: Colors.white70),
      ),

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xffCBD8E8)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 9),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff120c6e), Color(0xff5e72eb)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Expense',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: Text(
                                key: ValueKey(provider.total),
                                '${provider.total}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (provider.expenses.isEmpty)
              Padding(
                padding: const EdgeInsetsGeometry.fromLTRB(10, 200, 10, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.money_off_csred,
                      size: 40,
                      color: Colors.black26,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Expense are empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            if (provider.expenses.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.expenses.length,
                  itemBuilder: (ctx, index) {
                    final expense = provider.expenses[index];
                    return Dismissible(
                      background: Container(
                        // decoration: BoxDecoration(shape: BoxShape.circle),
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.redAccent,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        alignment: Alignment.centerRight,

                        child: Icon(
                          Icons.delete_forever_outlined,
                          size: 25,
                          color: Colors.white60,
                        ),
                      ),
                      key: ValueKey(provider.expenses[index]),

                      direction: DismissDirection.endToStart,

                      onDismissed: (direction) async {
                        provider.remove(index);
                        final expenseToDelete = provider.expenses[index];
                        await ExpenseDatabase().getthisuserinfo();
                        await ExpenseDatabase().DeleteUserDetails(
                          expenseToDelete.id,
                        );

                        Provider.of<ExpenseProvider>(
                          context,
                          listen: false,
                        ).remove(index);
                      },
                      child: Cardexpense(expense: provider.expenses[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
