import 'package:formz/formz.dart';

enum EmailInputError { isEmpty, invalid }

final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.isEmpty;
    }

    return !emailRegExp.hasMatch(value) ? EmailInputError.invalid : null;
  }
}
