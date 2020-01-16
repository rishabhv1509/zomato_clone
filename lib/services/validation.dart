class Validation {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool emailValidation(String email) {
    isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return isEmailValid;
  }

  bool passwordValidation(String password) {
    if (password.length >= 6) {
      isPasswordValid = true;
    } else {
      isPasswordValid = false;
    }
    return isPasswordValid;
  }
}
