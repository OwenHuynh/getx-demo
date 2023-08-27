import 'package:demo_getx_flutter/utils/base/page_state.dart';
import 'package:demo_getx_flutter/utils/constants/app_strings.dart';
import 'package:demo_getx_flutter/utils/validation/validate_util.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  Rx<PageState> pageState = PageState.initial.obs;
  RxString phoneObs = ''.obs;
  RxString errorMessageObs = ''.obs;
  RxBool phoneValid = false.obs;

  @override
  void onInit() {
    Init();
    super.onInit();
  }

  Future<void> Init() async {}

  void onPhoneNumberChange(String phone) {
    final validatePhone = ValidateUtil.validatePhone(phone);
    phoneObs.value = phone;
    phoneValid.value = validatePhone;
  }

  void resetErrorMessage() {
    errorMessageObs.value = AppStrings.empty;
  }

  void navigateToConfirmSMSPage() {}
}
