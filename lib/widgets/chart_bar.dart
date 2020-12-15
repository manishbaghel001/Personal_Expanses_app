import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lebal;
  final double spendingAmount;
  final double spendingPctOfAmount;
  ChartBar(this.lebal, this.spendingAmount, this.spendingPctOfAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              
                height: constraints.maxHeight * 0.12,
                child: FittedBox(
                    child: Text('₹' + '${spendingAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)))),
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Container(
              height: constraints.maxHeight * 0.60,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(lebal,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
            ),
          ],
        );
      },
    );
  }
}
