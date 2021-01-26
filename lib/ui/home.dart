import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double _tipPercentage = 0.0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  double totalTip = 0;
  double totalPerPerson = 0;
  Color txtColor = Colors.deepOrange;
  Color bgColor = Colors.deepOrange.shade100;
  TextStyle txtStyle = TextStyle(
    color: Colors.deepOrange,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    totalPerPerson = (totalTip + _billAmount) / _personCounter;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tip Calculator",
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: mediaHeight * 0.15),
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(25.0),
          children: <Widget>[
            //Calculation Area
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total per Person",
                    style: txtStyle,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "\$ " + totalPerPerson.toStringAsFixed(2),
                    style: txtStyle,
                  ),
                ],
              ),
            ),
            //Tools for Calculator
            Container(
              margin: EdgeInsets.only(top: 25.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: txtColor,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  //Bill Amount Textfield
                  buildBillAmountTextField(),
                  //Tip Splitter
                  buildTipSplitter(),
                  //Tip Value
                  buildTipValue(),
                  //Tip Percentage
                  buildTipPercentageSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Tip Percentage Method
  buildTipPercentageSlider() {
    return Column(
      children: [
        Text(
          "$_tipPercentage%",
          style: txtStyle,
        ),
        Slider(
          min: 0,
          max: 100,
          activeColor: txtColor,
          inactiveColor: bgColor,
          divisions: 10,
          value: _tipPercentage.toDouble(),
          onChanged: (double value) {
            setState(() {
              _tipPercentage = value;
            });
          },
        ),
      ],
    );
  }

//Tip Value Method
  buildTipValue() {
    _billAmount < 0 || _billAmount.toString().isEmpty || _billAmount == null
        ? print(totalTip.toString())
        : totalTip = (_billAmount * _tipPercentage) / 100;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //Split Text
      Text(
        "Tip",
        style: txtStyle,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          " \$ $totalTip",
          style: txtStyle,
        ),
      ),
      //Split Button
    ]);
  }

//Tip Splitter Method
  buildTipSplitter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Split Text
        Text(
          "Split",
          style: txtStyle,
        ),
        //Split Button
        Row(
          children: [
            //Decreament Button
            buildMinusBtn("""-"""),
            //Number Area
            Text(
              "$_personCounter",
              style: txtStyle,
            ),
            //Increament Button
            buildMinusBtn("""+"""),
          ],
        ),
      ],
    );
  }

  //Decreament Button Method
  InkWell buildMinusBtn(String txtSign) {
    return InkWell(
      onTap: () {
        setState(() {
          _personCounter > 0 && txtSign == """-"""
              ? _personCounter--
              : _personCounter++;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: bgColor,
        ),
        child: Text(
          txtSign,
          style: TextStyle(
            color: txtColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

//Bill Amount Textfield Method
  buildBillAmountTextField() {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(color: txtColor),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.attach_money),
        hintText: "Bill Amount",
        hintStyle: TextStyle(
          color: txtColor,
        ),
      ),
      onChanged: (String value) {
        try {
          _billAmount = double.parse(value);
        } catch (e) {
          _billAmount = 0.0;
        }
      },
    );
  }
}
