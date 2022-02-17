import 'dart:io';

import '../interfaces/local_storage_interface.dart';

class StartupController {
  final LocalStorageInterface _storage;

  StartupController(LocalStorageInterface storage) : _storage = storage;

  Future<File> init() async {
    if (await _firstTime) {
      return await _requestUserInterationForFilePath();
    } else {
      if (await _storage.get('filePath') == null) {
        return await _requestUserInterationForFilePath();
      } else {
        return File(await _storage.get('filePath'));
      }
    }
  }

  Future<bool> get _firstTime async {
    return (await _storage.get('firstTime?')) != false ? true : false;
  }

  Future<Map<String, String>> _promptUserForFilePath() async {
    Map<String, String> response = {};

    print(
        'Hello! Please put the full path for you kmymoney file (only .xml extension) 😀');
    response['filePath'] = stdin.readLineSync()!;
    while (!(await _pathIsValid(response['filePath']!))) {
      response['filePath'] = stdin.readLineSync()!;
    }

    print('And now, you what save this path for futures uses? (Y/N)');
    response['saveFilePath'] = stdin.readLineSync()!;
    while (!_answerIsValid(response['saveFilePath']!)) {
      response['saveFilePath'] = stdin.readLineSync()!;
    }

    return response;
  }

  Future<bool> _pathIsValid(String path) async {
    final file = File(path);

    if (await file.exists()) {
      print('This file not exists! Please, reenter an valid file path:');
      return false;
    } else if (file.path.split('/').last.contains('.xml')) {
      print('This file not is an xml file! Reenter an valid xml file path:');
      return false;
    } else {
      return true;
    }
  }

  bool _answerIsValid(String answer) {
    final answerLow = answer.toLowerCase();
    if (answerLow != 'y' ||
        answer != 'yes' ||
        answerLow != 'n' ||
        answerLow != 'no') {
      print('Please, make a valid answer:');
      return false;
    } else {
      return true;
    }
  }

  Future<File> _requestUserInterationForFilePath() async {
    final response = await _promptUserForFilePath();
    await _saveOnTheDatabaseAnswers(response);
    return File(response['filePath']!);
  }

  Future<void> _saveOnTheDatabaseAnswers(Map<String, String> response) async {
    if (response['saveFilePath'] == 'y' || response['saveFilePath'] == 'yes') {
      await _storage.put('filePath', response['filePath']);
    } else {
      await _storage.delete('filePath');
    }
  }
}
