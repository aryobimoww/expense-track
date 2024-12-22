import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class ModelExpenses {
  ModelExpenses(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get formatDate {
    initializeDateFormatting('id_ID', null);
    var format = DateFormat.yMMMEd('id_ID');
    return format.format(date);
  }

  String get formatNumber {
    var format =
        NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: "Rp");
    return format.format(amount);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ModelExpenses> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<ModelExpenses> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
