enum FirebaseAuthError {
  emailAlreadyInUse('email-already-in-use', 'Dieser Nutzer existiert bereits.'),
  invalidEmail('invalid-email', 'Die E-Mail Adresse ist ungültig.'),
  operationNotAllowed(
    'operation-not-allowed',
    'Der Vorgang ist aus technischen Gründen nicht erlaubt.',
  ),
  weakPassword('weak-password', 'Bitte wählen Sie ein stärkeres Passwort.'),
  userDisabled('user-disabled', 'Dieser Nutzer ist deaktiviert.'),
  userNotFound('user-not-found', 'Dieser Nutzer existiert nicht.'),
  wrongPassword('wrong-password', 'Das Passwort ist falsch.'),
  userMismatch('user-mismatch', 'Die Zugangsdaten gehören nicht dem Nutzer.'),
  invalidCredential('invalid-credential', 'Die Zugangsdaten sind ungültig.'),
  invalidVerificationCode(
    'invalid-verification-code',
    'Der Verifizierungs-Code ist ungültig.',
  ),
  invalidVerificationId(
    'invalid-verification-id',
    'Die Verifizierungs-ID ist ungültig.',
  );

  final String code;
  final String message;

  const FirebaseAuthError(this.code, this.message);

  static FirebaseAuthError? byCode(String code) {
    return FirebaseAuthError.values.cast<FirebaseAuthError?>().firstWhere(
      (element) => element?.code == code,
      orElse: () {
        // ignore: avoid_print
        print('An unexpected firebase auth error occurred: $code');
        return null;
      },
    );
  }
}
