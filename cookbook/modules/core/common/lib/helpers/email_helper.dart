class EmailHelper {
  static bool validate(String email) {
    final isValid = RegExp(
      r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$",
    ).hasMatch(email);

    return isValid;
  }
}
