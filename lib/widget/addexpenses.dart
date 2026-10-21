import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_track/database/expense_database.dart';
import 'package:flutter/material.dart';
import 'package:expense_track/model/model.dart';
import 'package:expense_track/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Addexpenses extends StatefulWidget {
  const Addexpenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddexpenseState();
  }
}

class _AddexpenseState extends State<Addexpenses> {
  Category _selectedCategory = Category.others;
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();

  Future<String> uploaddata() async {
    String id = FirebaseFirestore.instance.collection('users').doc().id;

    Map<String, dynamic> uploaddata = {
      "id": id,
      "amount": _amountcontroller.text,
      "title": _titlecontroller.text,
      "category": _selectedCategory.name,
    };
    await ExpenseDatabase().addUserDetails(uploaddata, id);
    Fluttertoast.showToast(
      msg: "Successfully add details",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 54, 244, 120),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 330,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xff120c6e), Color(0xff5e72eb)],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Add Expense',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: _titlecontroller,
            style: TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              label: const Text(
                'Enter the title',
                style: TextStyle(color: Colors.white60, fontSize: 15),
              ),
              fillColor: Colors.white38,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _amountcontroller,
            style: TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              label: const Text(
                'Enter the amount',
                style: TextStyle(color: Colors.white60, fontSize: 15),
              ),
              fillColor: Colors.white38,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 7),
          DropdownButtonFormField<Category>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            initialValue: _selectedCategory,
            dropdownColor: Color(0xff120c6e),
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  backgroundColor: Colors.white70,
                ),
                onPressed: () async {
                  String id = await uploaddata();

                  final newExpense = Model(
                    id: id,
                    amount: double.parse(_amountcontroller.text),
                    //date: date,
                    title: _titlecontroller.text,
                    category: _selectedCategory,
                  );
                  Provider.of<ExpenseProvider>(
                    context,
                    listen: false,
                  ).add(newExpense);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Saved',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff120c6e),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  'Cancle',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
