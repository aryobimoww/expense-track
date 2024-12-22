import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

var kColorSchema =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 226, 252));

var kDarkColorSchema = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 169, 1, 152));
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Expense(),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorSchema,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorSchema.primaryContainer,
          foregroundColor: kDarkColorSchema.secondary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorSchema.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorSchema.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkColorSchema.secondary,
              fontSize: 16,
            ),
            titleMedium: TextStyle(
              color: kDarkColorSchema.secondary,
            )),
      ),
      theme: ThemeData().copyWith(
          colorScheme: kColorSchema,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorSchema.onPrimaryContainer,
            foregroundColor: kColorSchema.onSecondary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorSchema.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchema.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorSchema.secondary,
                  fontSize: 16,
                ),
                titleMedium: TextStyle(
                  color: kColorSchema.secondary,
                ),
              )

          // scaffoldBackgroundColor: const Color.fromARGB(255, 255, 226, 252)
          ),
    );
  }
}
