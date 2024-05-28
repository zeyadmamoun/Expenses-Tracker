import 'package:personal_expanses/models/expense.dart';

final List<Expense> expenses = [
  Expense(
    category: Category.work,
    title: "Flutter Course",
    amount: 29.9,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.leisure,
    title: "Cinema",
    amount: 9.71,
    date: DateTime.now(),
  ),
  Expense(
    category: Category.food,
    title: "Breakfast",
    amount: 5.00,
    date: DateTime.now(),
  ),
];
