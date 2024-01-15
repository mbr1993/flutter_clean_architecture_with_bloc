import 'dart:isolate';

import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';

class IsolateParser<T> {
  IsolateParser(this.json, this.converter);

  final Map<String, dynamic> json;

  ResponseConverter<T> converter;

  Future<T> parseInBackground() async {
    final port = ReceivePort();
    await Isolate.spawn(_parseListOfJson, port.sendPort);

    final result = await port.first;
    return result as T;
  }

  Future<void> _parseListOfJson(SendPort sendPort) async {
    final result = converter(json);
    Isolate.exit(sendPort, result);
  }
}
