import 'dart:ui';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Map<int, Color> color = {
  50: Color(0xFFFBE9E7),
  100: Color(0xFFFFCCBC),
  200: Color(0xFFFFAB91),
  300: Color(0xFFFF8A65),
  400: Color(0xFFFF7043),
  500: Color(0xFFFF5722),
  600: Color(0xFFF4511E),
  700: Color(0xFFE64A19),
  800: Color(0xFFD84315),
  900: Color(0xFFBF360C),
};

MaterialColor colorCustom = MaterialColor(0xFFFF5722, color);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.red,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  //fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1',
    //     title: 'New transaction',
    //     amount: 69.69,
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Another transaction',
    //     amount: 969.69,
    //     date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String titleTx, double amountTx, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: titleTx,
      amount: amountTx,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topCenter,
                    colors: [Colors.deepOrange, Colors.red]),
                ),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.20,
                child: Chart(_recentTransactions)),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red, Colors.blue]),
                ),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.80,
                child: TransactionList(_userTransaction, _deleteTransactions)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
