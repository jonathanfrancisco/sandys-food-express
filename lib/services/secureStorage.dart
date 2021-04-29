import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _secureStorage = FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeData = await _secureStorage.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key);
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _secureStorage.delete(key: key);
    return deleteData;
  }
}
