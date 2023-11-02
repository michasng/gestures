import 'package:firebase_auth/firebase_auth.dart';

class PermissionService {
  final _privilegedUserEmails = ['micha.sengotta@gmail.com'];

  bool isPrivilegedUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    return _privilegedUserEmails.contains(user.email);
  }
}
