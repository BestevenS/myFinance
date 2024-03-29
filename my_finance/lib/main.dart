// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savings Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Savings Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _initialBalanceController = TextEditingController();
  final _monthlyDepositController = TextEditingController();
  final _annualRateController = TextEditingController();
  final _rateAfter100KController = TextEditingController(); // Νέος controller
  final _targetController = TextEditingController();

  String _result = '';

  Future<void> _calculateSavings() async {
    double initialBalance = double.parse(_initialBalanceController.text);
    double deposit = double.parse(_monthlyDepositController.text);
    double annualRate = double.parse(_annualRateController.text);
    double rateAfter100K =
        double.parse(_rateAfter100KController.text); // Νέα μεταβλητή
    double target = double.parse(_targetController.text);

    List<String> annualProgress = [];
    int monthCount = 0;

    while (initialBalance < target) {
      // Add monthly deposit
      initialBalance += deposit;
      monthCount++;

      // Apply annual interest at the end of each year
      if (monthCount % 12 == 0) {
        if (initialBalance > 100000) {
          // Έλεγχος για το όριο των 100,000
          initialBalance += initialBalance * rateAfter100K;
        } else {
          initialBalance += initialBalance * annualRate;
        }
        annualProgress.add(
            'Έτος ${monthCount ~/ 12}: \$${initialBalance.toStringAsFixed(2)}');
      }
    }

    int yearsRequired = monthCount ~/ 12;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yearly Progress'),
          content: SingleChildScrollView(
            child: ListBody(
              children: annualProgress
                  .map((yearlyProgress) => Text(yearlyProgress))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _result =
          'Χρειάζονται περίπου $yearsRequired χρόνια για να φτάσετε στον στόχο σας.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _initialBalanceController,
              decoration: const InputDecoration(
                labelText: 'Initial Balance',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _monthlyDepositController,
              decoration: const InputDecoration(
                labelText: 'Monthly Deposit',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _annualRateController,
              decoration: const InputDecoration(
                labelText: 'Annual Rate',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _rateAfter100KController,
              decoration: const InputDecoration(
                labelText: 'Rate after 100K',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _targetController,
              decoration: const InputDecoration(
                labelText: 'Target',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _calculateSavings,
              child: const Text('Calculate'),
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
