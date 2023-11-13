//Validação de formularios utilizando o Regex

bool emailValidator(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

bool passwordValidator(String password) {
  final RegExp regex = RegExp(r"^[a-zA-Z0-9]{8,}$");
  return regex.hasMatch(password);
}
