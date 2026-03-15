class Validator {

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your email";
    }

    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? firstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your first name";
    }

    if (value.length < 3) {
      return "First name must be at least 3 characters";
    }

    return null;
  }

  static String? lastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your last name";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter phone number";
    }

    if (value.length != 11) {
      return "Phone number must be 11 digits";
    }

    if (!value.startsWith("01")) {
      return "Enter valid phone number";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter password";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}