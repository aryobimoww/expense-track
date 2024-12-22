import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});
  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<ModelExpenses> _registerExpenses = [
    ModelExpenses(
        title: 'Flutter Course',
        amount: 99000,
        date: DateTime.now(),
        category: Category.work),
    ModelExpenses(
        title: 'Cinema',
        amount: 150000,
        date: DateTime.now(),
        category: Category.leisure),
    ModelExpenses(
        title: 'Goes to Bangkok',
        amount: 2000000,
        date: DateTime.now(),
        category: Category.travel),
    ModelExpenses(
        title: 'Kamakura Dinning',
        amount: 1500000,
        date: DateTime.now(),
        category: Category.food),
  ];

  void _openExpenseAddOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(ModelExpenses expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(ModelExpenses expenses) {
    final expenseIndex = _registerExpenses.indexOf(expenses);
    setState(() {
      _registerExpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registerExpenses.insert(expenseIndex, expenses);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("The expense is empty please add some"),
    );

    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses App"),
        actions: [
          IconButton(
              onPressed: () {
                _openExpenseAddOverlay();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses),
          const SizedBox(
            height: 7,
          ),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
