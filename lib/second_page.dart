import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({ Key? key }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2")
      ),
      body: Container(
        child: Text("you're on the 2nd page")
      ),
    );
  }
}