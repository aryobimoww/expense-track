import 'package:expense_tracker/widget/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<ModelExpenses> expenses;
  final void Function(ModelExpenses expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
