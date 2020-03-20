import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String msg = '';
  TextEditingController heightInput = new TextEditingController();
  TextEditingController weightInput = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: heightInput,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Height (metre)',
                ),
              ),
              Container(height: 10),
              TextField(
                controller: weightInput,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight (kg)',
                ),
              ),
              RaisedButton(child: Text('Calculate'), onPressed: _changeText),
              Text(
                msg,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ));
  }
  
  void _openDialog(String result, String status) {
    showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Result'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('BMI: '+result),
              new Text('Status: '+status),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  _changeText() {
    setState(() {
      bool h = false;
      bool w = false;
      if (weightInput.text != '') {
        h = true;
      }
      if (heightInput.text != '') {
        w = true;
      }
      
      if (h && w){
        var mass = double.parse(weightInput.text);
        var h2 = double.parse(heightInput.text) * double.parse(heightInput.text);
        var bmi = mass / h2;
      
        bmi = double.parse(bmi.toStringAsFixed(2));
        if ( bmi < 18.5) {
          _openDialog(bmi.toString(), 'Underweight');
        }
        else if (bmi >= 18.5 && bmi < 25) {
          _openDialog(bmi.toString(), 'Normal');
        }
        else if (bmi >= 25 && bmi < 30) {
          _openDialog(bmi.toString(), 'Overweight');
        }
        else {
          _openDialog(bmi.toString(), 'Obese');
        }
        msg = "";
      }
      else {
        msg = "Please enter the required value!";
      }
      
    });
  }
}