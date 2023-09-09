import 'package:firebase_auth/firebase_auth.dart';

// workaround for https://github.com/firebase/flutterfire/issues/10966
String? extractFirebaseAuthExceptionCode(FirebaseAuthException exception) {
  if (exception.code != 'unknown') return exception.code;
  if (exception.message == null) return null;

  String regexPattern = r'(?<=\(auth/)(.*?)(?=\)\.)';
  RegExp regExp = RegExp(regexPattern);
  Match? match = regExp.firstMatch(exception.message!);

  return match == null ? null : match.group(0)!;
}
