import 'dart:convert';
import 'dart:math';

import 'secure_storage_service.dart';

const _encryptKeyName = 'hive_encrypt_key';

class EncryptionKeyService {
  const EncryptionKeyService({required SecureStorageService secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;

  Future<List<int>> getOrCreateKey() async {
    final stored = await _secureStorage.readData(_encryptKeyName);

    if (stored != null) return base64Decode(stored);

    final key = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    await _secureStorage.writeData(_encryptKeyName, base64Encode(key));
    return key;
  }

  Future<void> deleteKey() async => _secureStorage.deleteData(_encryptKeyName);
}
