import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { RED, GREEN }

class ColorBloc {
  Color color = Colors.red;
  final _inputEventController = StreamController<ColorEvent>();
  StreamSink<ColorEvent> get  inputEvenSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.RED)
      color = Colors.red;
    else if (event == ColorEvent.GREEN)
      color = Colors.green;
    else
      throw Exception('Wrong Event Type');
    _outputStateController.sink.add(color);
  }

  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }
  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
