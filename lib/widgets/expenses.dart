import 'package:flutter/material.dart';
import 'package:personal_expanses/data/data_source.dart';
import 'package:personal_expanses/models/expense.dart';
import 'package:personal_expanses/widgets/chart/chart.dart';
import 'package:personal_expanses/widgets/expenses_list/expenses_list.dart';
import 'package:personal_expanses/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    expenses.remove(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => NewExpense(
                  onAddExpense: addExpense,
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chart(expenses: expenses),
            Expanded(
              flex: 1,
              child: ExpensesList(
                expenses: expenses,
                onDismiss: removeExpense,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
