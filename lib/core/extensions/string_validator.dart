extension StringValidator on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[\w-\.+]+@([\w-]+\.)+[\w-]{2,}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(this);
  }

  bool isValidUsername() {
    final usernameRegex = RegExp(
      r'^[\w-]{3,}$',
      caseSensitive: false,
      multiLine: false,
    );
    return usernameRegex.hasMatch(this);
  }

  bool get isNotBlank => trim().isNotEmpty;
}
