import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  const SecureStorageService();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions.biometric(enforceBiometrics: true),
    iOptions: IOSOptions.defaultOptions,
    wOptions: WindowsOptions.defaultOptions,
    webOptions: WebOptions.defaultOptions,
    lOptions: LinuxOptions.defaultOptions,
    mOptions: MacOsOptions.defaultOptions,
  );

  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readData(String key) async => await _storage.read(key: key);

  Future<void> deleteData(String key) async => await _storage.delete(key: key);

  Future<void> deleteAllData() async => await _storage.deleteAll();

  Future<bool> containsData(String key) async {
    return await _storage.containsKey(key: key);
  }
}
