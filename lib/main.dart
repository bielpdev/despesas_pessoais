import 'dart:io';
import 'dart:math';

import 'package:despesas_pessoais/components/charts.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          //  appBarTheme: const AppBarTheme(titleTextStyle: TextStyle()),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool showchart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  _adicionarTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
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
    final mediaQuery = MediaQuery.of(context);
    bool IsLandScape = mediaQuery.orientation == Orientation.landscape;
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final appBar = AppBar(
      backgroundColor: const Color.fromARGB(255, 18, 99, 175),
      actions: [
        if (IsLandScape)
          IconButton(
            onPressed: () {
              setState(() {
                showchart = !showchart;
              });
            },
            icon: Icon(
              showchart ? Icons.list : Icons.show_chart,
              color: Colors.white,
            ),
          ),
        IconButton(
          onPressed: () => openTransactionFormModal(context),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
      title: const Center(
        child: Text(
          'Despesas Pessoas',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

    final availableHeight = MediaQuery.sizeOf(context).height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showchart || !IsLandScape)
            SizedBox(
                height: availableHeight * (IsLandScape ? 0.8 : 0.30),
                child: Chart(_recentTransactions)),
          if (!showchart || !IsLandScape)
            SizedBox(
              height: availableHeight * (IsLandScape ? 1 : 0.7),
              child: TransactionList(
                _transactions,
                _removeTransaction,
              ),
            )
        ],
      ),
    );

    Widget getButtonIcon(IconData icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(
              onTap: fn,
              child: Icon(icon),
            )
          : IconButton(onPressed: fn, icon: Icon(icon));
    }

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Despesas Pessoais"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (IsLandScape)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Text('Exibir Grafico '),
                  //       Switch(
                  //         focusColor: Colors.blue,
                  //         value: showchart,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             showchart = value;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  if (showchart || !IsLandScape)
                    SizedBox(
                        height: availableHeight * (IsLandScape ? 0.8 : 0.30),
                        child: Chart(_recentTransactions)),
                  if (!showchart || !IsLandScape)
                    SizedBox(
                      height: availableHeight * (IsLandScape ? 1 : 0.7),
                      child: TransactionList(
                        _transactions,
                        _removeTransaction,
                      ),
                    )
                ],
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // if (IsLandScape)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Text('Exibir Grafico '),
                  //       Switch(
                  //         focusColor: Colors.blue,
                  //         value: showchart,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             showchart = value;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  if (showchart || !IsLandScape)
                    SizedBox(
                        height: availableHeight * (IsLandScape ? 0.8 : 0.30),
                        child: Chart(_recentTransactions)),
                  if (!showchart || !IsLandScape)
                    SizedBox(
                      height: availableHeight * (IsLandScape ? 1 : 0.7),
                      child: TransactionList(
                        _transactions,
                        _removeTransaction,
                      ),
                    )
                ],
              ),
            ),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () => openTransactionFormModal(context),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
