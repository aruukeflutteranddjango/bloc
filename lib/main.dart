import 'package:bloc_stream_example/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC with Stream'),
        centerTitle: true,
      ),
      body: Center(
          child: StreamBuilder<Color>(
        stream: _bloc.outputStateStream,
        initialData: Colors.red,
        builder: (context, snapshot) {
          return AnimatedContainer(
              
              height: 300,
              width: 300,
              color: snapshot.data,
              duration: const Duration(milliseconds: 500));
        },
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _bloc.inputEvenSink.add(ColorEvent.RED);
              }),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: (() => {_bloc.inputEvenSink.add(ColorEvent.GREEN)})),
        ],
      ),
    );
  }
}
