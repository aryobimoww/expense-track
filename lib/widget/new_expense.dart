import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ModelExpenses expenses) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitExpenseData() {
    final enteredMount = double.tryParse(_amountController.text);
    final amountInvalid = enteredMount == null || enteredMount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      //Do something
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content:
              const Text("Please make sure must input title, amount, date"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Ok"))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(ModelExpenses(
        title: _titleController.text,
        amount: enteredMount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  final format = DateFormat.yMEd();
  void _presentDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            style: Theme.of(context).textTheme.titleMedium,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: 'Rp ',
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        _selectedDate == null
                            ? 'No Date'
                            : format.format(_selectedDate!),
                        style: Theme.of(context).textTheme.titleMedium),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  style: Theme.of(context).textTheme.titleMedium,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text(
                  "Save Expense",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
