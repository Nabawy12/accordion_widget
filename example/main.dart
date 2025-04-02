import 'package:flutter/material.dart';
import 'package:accordion_widget/accordion_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Accordion Example')),
        body: AccordionWidget(
          showIcon: true,
          header: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(),
              SizedBox(width: 15),
              Text(
                "Zeyad Nabawy",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.red),
            child: Text("data"),
          ),
        ),
      ),
    );
  }
}
