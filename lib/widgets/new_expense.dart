import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category selectedCategory = Category.food;

  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('invalid input'),
            content: const Text('invalid input'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('ok'))
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate =
                            DateTime(now.year - 1, now.month, now.day);
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: firstDate,
                          lastDate: now,
                        );
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      },
                      icon: const Icon(Icons.calendar_view_day_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton(
            value: selectedCategory,
            items: Category.values.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (newValue == null) {
                  return;
                }
                selectedCategory = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final enteredAmount = double.tryParse(_amountController.text);
                  var amountIsInvalid =
                      enteredAmount == null || enteredAmount <= 0;

                  if (_titleController.text.trim().isEmpty) {
                    showErrorDialog(context);
                    return;
                  }
                  if (amountIsInvalid) {
                    showErrorDialog(context);
                    return;
                  }
                  if (_selectedDate == null) {
                    showErrorDialog(context);
                    return;
                  }
                  final expense = Expense(
                      title: _titleController.text,
                      amount: enteredAmount,
                      date: _selectedDate!,
                      category: selectedCategory);
                  widget.onAddExpense(expense);
                  Navigator.pop(context);
                },
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
