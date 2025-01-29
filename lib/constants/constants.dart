// constants/constants.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _localstorage = const FlutterSecureStorage();

class Constants {
  static const String baseUrl = 'https://api.katarasa.id/';

  Future<void> write({required String key, required String value}) async {
    await _localstorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await _localstorage.read(key: key);
  }

  double parseSaldo(String saldo) {
    String cleanedSaldo = saldo.replaceAll(RegExp(r'[^\d,]'), '');
    cleanedSaldo = cleanedSaldo.replaceAll(',', '.');
    return double.parse(cleanedSaldo);
  }
}
