import 'package:easy_localization/easy_localization.dart';

mixin CommonValidations {
  static const int passwordMinLength = 6;

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return "${"password".tr()} ${"can_not_be_empty".tr()}";
    } else if (password.length < passwordMinLength) {
      return "password_must_be_six_digit".tr();
    } else {
      return null;
    }
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "${"email".tr()} ${"can_not_be_empty".tr()}";
    }

    final isValid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email.trim());

    if (isValid) {
      return null;
    } else {
      return "enter_email_not_valid".tr();
    }
  }

  String? isConfirmPasswordValid(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "${"confirm_password".tr()} ${"can_not_be_empty".tr()}";
    }
    if (confirmPassword.trim() == password?.trim()) {
      return null;
    } else {
      return "passwords_does_not_matched".tr();
    }
  }

  String? isValidName(String? name, String fieldName) {
    String pattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(pattern);

    if (name == null || name.isEmpty) {
      return "$fieldName ${"can_not_be_empty".tr()}";
    }

    if (!regExp.hasMatch(name.trim())) {
      return "${"please_enter_a_valid".tr()} $fieldName";
    } else {
      return null;
    }
  }

  String? isNotEmpty(String? value, String? fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName ${"can_not_be_empty".tr()}";
    } else {
      return null;
    }
  }
}

String? Function(String? value) createEmptyValidator(String fieldName) {
  return (String? value) {
    if (value?.isEmpty == true) {
      return "$fieldName ${"can_not_be_empty".tr()}";
    } else {
      return null;
    }
  };
}
