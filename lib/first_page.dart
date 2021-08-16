import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/my_bloc.dart';
import 'injection_container.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirsPageState createState() => _FirsPageState();
}

class _FirsPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<MyBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Page 1")),
        body: Container(
          child: BlocConsumer<MyBloc, MyState>(
            listener: (context, state) {
              if (state is SecondState) {
                Navigator.pushNamed(context, "SECONDPAGE");
              }
            },
            builder: (context, state) {
              if (state is FirstState) {
                return Column(
                  children: [
                    Text("State is FirstState"),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<MyBloc>(context).add(TriggerStateChange());
                        },
                        child: Text("Change state")),
                  ],
                );
              } else {
                return Text("some other state");
              }
            },
          ),
        ),
      ),
    );
  }
}
