import 'package:flutter/material.dart';
import 'package:personal_expanses/models/expense.dart';
import 'package:personal_expanses/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDismiss,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onDismiss;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onDismiss(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index]),
        );
      },
    );
  }
}
