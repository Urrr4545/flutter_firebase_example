import 'package:formz/formz.dart';

enum PasswordInputError { isEmpty, invalid }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty({String value = ''}) : super.pure(value);

  @override
  PasswordInputError? validator(String value) {
    bool hasMinLenght = value.length >= 8; //최소 8자이상
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]')); //최소 대문자 1개이상
    bool hasLowerCase = value.contains(RegExp(r'[a-z]')); //최소 소문자 1개이상
    bool hasDigit = value.contains(RegExp(r'\d')); //최소 숫자 1개이상
    bool hasSpecialCharacter =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')); //최소 숫자 1개이상

    if (value.isEmpty) return PasswordInputError.isEmpty;

    if (!hasMinLenght ||
        !hasUpperCase ||
        !hasLowerCase ||
        !hasDigit ||
        !hasSpecialCharacter) {
      return PasswordInputError.invalid;
    }

    return null;
  }
}
