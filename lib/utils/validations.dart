mixin CommonValidations {
  static const int passwordMinLength = 6;

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password cannot be empty";
    } else if (password.length < passwordMinLength) {
      return "Password should be at least $passwordMinLength characters long";
    } else {
      return null;
    }
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    }

    final isValid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email.trim());

    if (isValid) {
      return null;
    } else {
      return "Entered Email is not valid";
    }
  }

  String? isConfirmPasswordValid(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm Password cannot be empty";
    }
    if (confirmPassword.trim() == password?.trim()) {
      return null;
    } else {
      return "Passwords do not match";
    }
  }

  String? isValidName(String? name, String fieldName) {
    String pattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(pattern);

    if (name == null || name.isEmpty) {
      return "$fieldName cannot be empty";
    }

    if (!regExp.hasMatch(name.trim())) {
      return "Please enter a valid $fieldName";
    } else {
      return null;
    }
  }

  String? isNotEmpty(String? value, String? fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName cannot be empty";
    } else {
      return null;
    }
  }
}

String? Function(String? value) createEmptyValidator(String fieldName) {
  return (String? value) {
    if (value?.isEmpty == true) {
      return "$fieldName cannot be empty";
    } else {
      return null;
    }
  };
}
