import 'package:demo_getx_flutter/utils/validation/validate_util.dart';
import 'package:demo_getx_flutter/utils/validation/validation_result.dart';

class LoginValidationResults {
  static ValidationResult validateEmail(String email) {
    if (ValidateUtil.isNullEmptyOrWhitespace(email)) {
      return ValidationResult.error("");
    } else if (!ValidateUtil.validateEmail(email)) {
      return ValidationResult.error("");
    }
    return ValidationResult.ok();
  }

  static ValidationResult validatePassword(String password) {
    if (ValidateUtil.isNullEmptyOrWhitespace(password)) {
      return ValidationResult.error("");
    }
    if (password.length < 6) {
      return ValidationResult.error("");
    }
    return ValidationResult.ok();
  }
}
