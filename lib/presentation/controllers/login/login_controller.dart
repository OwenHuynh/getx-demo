import 'package:demo_getx_flutter/presentation/controllers/login/login_validate.dart';
import 'package:demo_getx_flutter/utils/base/page_state.dart';
import 'package:demo_getx_flutter/utils/constants/app_strings.dart';
import 'package:demo_getx_flutter/utils/validation/validate_util.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<PageState> pageState = PageState.initial.obs;
  RxString emailObs = ''.obs;
  RxString passwordObs = ''.obs;
  Rx<FormStatus> formStatus = FormStatus.initial.obs;
  RxBool enableButton = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    Init();
    super.onInit();
  }

  Future<void> Init() async {}

  void onEmailChange(String email) {
    emailObs.value = email;
    setEnableButton();
  }

  void onPasswordChange(String password) {
    passwordObs.value = password;
    setEnableButton();
  }

  void setEnableButton() {
    enableButton.value = !ValidateUtil.isNullOrEmpty(emailObs.value) ||
        !ValidateUtil.isNullOrEmpty(passwordObs.value);
  }

  String getErrorMessage() {
    switch (formStatus.value) {
      case FormStatus.initial:
        return AppStrings.empty;
      case FormStatus.invalid:
        return AppStrings.login_error_label;
      case FormStatus.valid:
        return AppStrings.empty;
    }
  }

  Future<void> loginAction() async {
    final emailValid =
        LoginValidationResults.validateEmail(emailObs.value).isValid;

    final passwordValid =
        LoginValidationResults.validatePassword(passwordObs.value).isValid;

    final isFormValid = emailValid && passwordValid;

    formStatus.value = isFormValid ? FormStatus.valid : FormStatus.invalid;
    errorMessage.value = getErrorMessage();

    if (isFormValid) {
      // TODO(loginAction): Handle login request
      print(true);
      // await Get.toNamed();
    }
  }

  void forgotPasswordAction() {
    Get.toNamed('/reset-password');
  }
}

enum FormStatus { initial, invalid, valid }
