import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class EncryptionHelper {
  final encrypt.Key key;

  EncryptionHelper(this.key);

  // AES GCM 모드를 사용한 암호화
  String encryptData(String data) {
    // 매번 새로운 IV를 생성 (GCM 모드에서는 12바이트 IV 권장)
    final iv = encrypt.IV.fromSecureRandom(12);

    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    final encrypted = encrypter.encrypt(data, iv: iv);

    // IV를 암호화된 데이터와 함께 저장
    final result = jsonEncode({
      'iv': iv.base64, // IV를 저장
      'data': encrypted.base64, // 암호화된 데이터
    });

    return result;
  }

  String decryptData(String encryptedData) {
    // JSON 형식에서 IV와 암호화된 데이터 분리
    final decoded = jsonDecode(encryptedData);

    final iv = encrypt.IV.fromBase64(decoded['iv']);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final decrypted = encrypter.decrypt64(decoded['data'], iv: iv);
    return decrypted;
  }
}
