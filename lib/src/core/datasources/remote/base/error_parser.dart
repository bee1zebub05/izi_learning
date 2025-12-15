
abstract interface class ErrorMessage {
  static String somethingError() => 'Something Error';
}

class ErrorParser {
  static String getErrorMessage(String error) {
    switch (error) {
      case 'errors.provider.notfound':
        return "Account not exist";
      case 'errors.login.failed':
        return "Incorrect password";
      default:
        return error;
    }
  }
}
