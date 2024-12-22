import 'package:expense_tracker/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  final ModelExpenses expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    expense.formatNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    children: [
                      Icon(categoryIcon[expense.category]),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        expense.formatDate,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
