import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class InternalFileRepository<T> {
  final String _fileName;

  InternalFileRepository(this._fileName);

  Future<String> get _filePath async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<File> get _file async {
    return File('${await _filePath}/$_fileName');
  }

  Future<void> write(T entity) async {
    await (await _file).writeAsString(jsonEncode(entity));
  }

  Future<String> read() async {
    try {
      return await (await _file).readAsString();
    } catch (e) {
      return null;
    }
  }
}