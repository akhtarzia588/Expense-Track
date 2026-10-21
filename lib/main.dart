import 'package:expense_track/provider/expense_provider.dart';
import 'package:expense_track/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: ((context) => ExpenseProvider()),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Homescreen()),
    ),
  );
}
