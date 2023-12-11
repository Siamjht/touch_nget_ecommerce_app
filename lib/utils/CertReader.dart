
import 'package:flutter/services.dart';

abstract class CertReader{
  static ByteData? cert;

  static Future<void> initialize() async {
    cert = await rootBundle.load("assets/certs/alorferi_com.cer");
  }

  static ByteData? getCert(){
    return cert;
  }

  static Uint8List getCertData(){
    final Uint8List certBytes = cert!.buffer.asUint8List();
    return certBytes;
  }
}