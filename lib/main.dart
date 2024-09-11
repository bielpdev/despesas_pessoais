import 'dart:math';

import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 210,
      date: DateTime.now(),
    ),
  ];

  _adicionarTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_adicionarTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
        title: const Text('Despesas Pessoas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: const Card(
              color: Colors.blue,
              elevation: 5,
              child: Text('Grafico'),
            ),
          ),
          TransactionList(_transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
